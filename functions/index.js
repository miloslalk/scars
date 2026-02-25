const crypto = require('crypto');
const admin = require('firebase-admin');
const functions = require('firebase-functions/v1');
const nodemailer = require('nodemailer');

admin.initializeApp();

const smtpConfig = functions.config().smtp || {};
const moderationConfig = functions.config().moderation || {};
const transporter = nodemailer.createTransport({
  host: smtpConfig.host,
  port: Number(smtpConfig.port || 587),
  secure: smtpConfig.secure === 'true',
  auth: smtpConfig.user
    ? {
        user: smtpConfig.user,
        pass: smtpConfig.pass,
      }
    : undefined,
});

const MODERATOR_EMAIL = moderationConfig.email || 'lalkovic91@gmail.com';

exports.reportMessage = functions.https.onCall(async (data, context) => {
  const messageId = typeof data.messageId === 'string' ? data.messageId : '';
  const messageText =
    typeof data.messageText === 'string' ? data.messageText.trim() : '';

  if (!messageId || !messageText) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Message data is required.'
    );
  }

  if (messageText.length > 1000) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Message text too long.'
    );
  }

  const reportRef = admin.database().ref('message_reports').push();
  const reportId = reportRef.key;
  const token = crypto.randomBytes(16).toString('hex');
  const createdAt = new Date().toISOString();

  await reportRef.set({
    messageId,
    messageText,
    reporterUid: context.auth ? context.auth.uid : null,
    status: 'pending',
    token,
    createdAt,
  });

  const baseUrl =
    moderationConfig.base_url || 'https://YOUR_REGION-YOUR_PROJECT.cloudfunctions.net';
  const approveUrl = `${baseUrl}/moderateMessage?reportId=${reportId}&token=${token}&action=approve`;
  const rejectUrl = `${baseUrl}/moderateMessage?reportId=${reportId}&token=${token}&action=reject`;

  await transporter.sendMail({
    from: moderationConfig.from || 'Scars App <no-reply@scars.app>',
    to: MODERATOR_EMAIL,
    subject: 'Scars App: Message Report',
    text:
      `A message was reported.\n\n` +
      `Message:\n${messageText}\n\n` +
      `Approve: ${approveUrl}\n` +
      `Reject: ${rejectUrl}\n`,
  });

  return { ok: true };
});

exports.moderateMessage = functions.https.onRequest(async (req, res) => {
  const reportId = req.query.reportId;
  const token = req.query.token;
  const action = req.query.action;

  if (typeof reportId !== 'string' || typeof token !== 'string') {
    res.status(400).send('Missing reportId or token.');
    return;
  }

  if (action !== 'approve' && action !== 'reject') {
    res.status(400).send('Invalid action.');
    return;
  }

  const reportRef = admin.database().ref(`message_reports/${reportId}`);
  const snapshot = await reportRef.get();
  if (!snapshot.exists()) {
    res.status(404).send('Report not found.');
    return;
  }

  const report = snapshot.val();
  if (report.token !== token) {
    res.status(403).send('Invalid token.');
    return;
  }

  await reportRef.update({
    status: action === 'approve' ? 'approved' : 'rejected',
    reviewedAt: new Date().toISOString(),
  });

  res
    .status(200)
    .send(`Report ${action === 'approve' ? 'approved' : 'rejected'}.`);
});

const DAILY_MORNING_HOUR = 9;
const DAILY_MORNING_MINUTE = 0;
const DAILY_WINDOW_MINUTES = 15;
const INACTIVE_DAYS = 7;
const FCM_BATCH_SIZE = 500;

function toDate(value) {
  if (!value) return null;
  if (typeof value === 'string') {
    const parsed = new Date(value);
    return Number.isNaN(parsed.getTime()) ? null : parsed;
  }
  if (typeof value === 'number') {
    const parsed = new Date(value);
    return Number.isNaN(parsed.getTime()) ? null : parsed;
  }
  return null;
}

function toOffsetMinutes(value) {
  const parsed = Number(value);
  if (!Number.isFinite(parsed)) return 0;
  if (parsed < -840 || parsed > 840) return 0;
  return Math.trunc(parsed);
}

function validTimeZone(value) {
  if (typeof value !== 'string' || value.trim() === '') return null;
  const tz = value.trim();
  try {
    Intl.DateTimeFormat('en-US', { timeZone: tz }).format(new Date());
    return tz;
  } catch (_) {
    return null;
  }
}

function localClockForTimeZone(nowUtc, timeZone) {
  const parts = new Intl.DateTimeFormat('en-US', {
    timeZone,
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    hourCycle: 'h23',
  }).formatToParts(nowUtc);
  const map = {};
  for (const part of parts) {
    map[part.type] = part.value;
  }
  const year = Number(map.year);
  const month = Number(map.month);
  const day = Number(map.day);
  const hour = Number(map.hour);
  const minute = Number(map.minute);
  if (
    !Number.isFinite(year) ||
    !Number.isFinite(month) ||
    !Number.isFinite(day) ||
    !Number.isFinite(hour) ||
    !Number.isFinite(minute)
  ) {
    return null;
  }
  return {
    hour,
    minute,
    dateKey: `${year.toString()}${month.toString().padStart(2, '0')}${day
      .toString()
      .padStart(2, '0')}`,
  };
}

function localClockFallbackForOffset(nowUtc, offsetMinutes) {
  const local = new Date(nowUtc.getTime() + offsetMinutes * 60 * 1000);
  return {
    hour: local.getUTCHours(),
    minute: local.getUTCMinutes(),
    dateKey: `${local.getUTCFullYear().toString()}${(local.getUTCMonth() + 1)
      .toString()
      .padStart(2, '0')}${local.getUTCDate().toString().padStart(2, '0')}`,
  };
}

function isInvalidTokenError(code) {
  return (
    code === 'messaging/registration-token-not-registered' ||
    code === 'messaging/invalid-registration-token'
  );
}

function boolWithFallback(value, fallback) {
  return typeof value === 'boolean' ? value : fallback;
}

function intInRange(value, min, max, fallback) {
  if (!Number.isFinite(Number(value))) return fallback;
  const parsed = Math.trunc(Number(value));
  if (parsed < min || parsed > max) return fallback;
  return parsed;
}

async function sendNotificationTargets({
  targets,
  title,
  body,
  buildSuccessUpdate,
  nowIso,
}) {
  let sentCount = 0;
  let removedCount = 0;

  for (let i = 0; i < targets.length; i += FCM_BATCH_SIZE) {
    const batch = targets.slice(i, i + FCM_BATCH_SIZE);
    const response = await admin.messaging().sendEachForMulticast({
      tokens: batch.map((item) => item.token),
      notification: { title, body },
    });

    const writes = [];
    response.responses.forEach((result, idx) => {
      const item = batch[idx];
      const ref = admin.database().ref(item.path);

      if (result.success) {
        sentCount += 1;
        writes.push(
          ref.update({
            ...buildSuccessUpdate(item.meta),
            lastNotificationAt: nowIso,
          })
        );
        return;
      }

      const code = result.error?.code || '';
      if (isInvalidTokenError(code)) {
        removedCount += 1;
        writes.push(ref.remove());
      }
    });
    await Promise.all(writes);
  }

  return { sentCount, removedCount };
}

exports.sendDailyMorningNotifications = functions.pubsub
  .schedule('every 15 minutes')
  .timeZone('Etc/UTC')
  .onRun(async () => {
    const usersSnap = await admin.database().ref('users').get();
    if (!usersSnap.exists()) return null;

    const users = usersSnap.val();
    const now = new Date();
    const nowIso = now.toISOString();
    const targets = [];

    for (const [uid, userData] of Object.entries(users)) {
      const devices = userData?.devices;
      if (!devices || typeof devices !== 'object') continue;
      const userPrefs =
        userData?.notificationPrefs && typeof userData.notificationPrefs === 'object'
          ? userData.notificationPrefs
          : {};

      for (const [deviceKey, deviceData] of Object.entries(devices)) {
        const token = deviceData?.token;
        if (typeof token !== 'string' || token.trim() === '') continue;
        const dailyEnabled = boolWithFallback(
          deviceData?.dailyEnabled,
          boolWithFallback(userPrefs?.dailyEnabled, true)
        );
        if (!dailyEnabled) continue;

        const dailyHour = intInRange(
          deviceData?.dailyHour,
          0,
          23,
          intInRange(userPrefs?.dailyHour, 0, 23, DAILY_MORNING_HOUR)
        );
        const dailyMinute = intInRange(
          deviceData?.dailyMinute,
          0,
          59,
          intInRange(userPrefs?.dailyMinute, 0, 59, DAILY_MORNING_MINUTE)
        );

        const timezoneName = validTimeZone(deviceData?.timezoneName);
        const local = timezoneName
          ? localClockForTimeZone(now, timezoneName)
          : localClockFallbackForOffset(
              now,
              toOffsetMinutes(deviceData?.utcOffsetMinutes)
            );
        if (!local) continue;
        const currentMinutes = local.hour * 60 + local.minute;
        const targetMinutes = dailyHour * 60 + dailyMinute;
        const inWindow =
          currentMinutes >= targetMinutes &&
          currentMinutes < targetMinutes + DAILY_WINDOW_MINUTES;
        if (!inWindow) continue;

        const localDateKey = local.dateKey;
        if (deviceData?.dailyLastSentDate === localDateKey) continue;

        targets.push({
          token,
          path: `users/${uid}/devices/${deviceKey}`,
          meta: { localDateKey },
        });
      }
    }

    if (targets.length === 0) return null;

    const result = await sendNotificationTargets({
      targets,
      title: 'Good morning',
      body: 'Take a gentle moment for yourself today.',
      buildSuccessUpdate: (meta) => ({
        dailyLastSentDate: meta.localDateKey,
        dailyLastSentAt: nowIso,
        lastNotificationType: 'daily',
      }),
      nowIso,
    });

    console.log(
      `Daily notification run: sent=${result.sentCount}, removed=${result.removedCount}, queued=${targets.length}`
    );
    return null;
  });

exports.sendInactiveNotifications = functions.pubsub
  .schedule('every 60 minutes')
  .timeZone('Etc/UTC')
  .onRun(async () => {
    const usersSnap = await admin.database().ref('users').get();
    if (!usersSnap.exists()) return null;

    const users = usersSnap.val();
    const now = new Date();
    const nowIso = now.toISOString();
    const inactiveMs = INACTIVE_DAYS * 24 * 60 * 60 * 1000;
    const targets = [];

    for (const [uid, userData] of Object.entries(users)) {
      const lastLoginAt = toDate(userData?.lastLoginAt);
      if (!lastLoginAt) continue;
      if (now.getTime() - lastLoginAt.getTime() < inactiveMs) continue;

      const devices = userData?.devices;
      if (!devices || typeof devices !== 'object') continue;
      const userPrefs =
        userData?.notificationPrefs && typeof userData.notificationPrefs === 'object'
          ? userData.notificationPrefs
          : {};

      for (const [deviceKey, deviceData] of Object.entries(devices)) {
        const token = deviceData?.token;
        if (typeof token !== 'string' || token.trim() === '') continue;
        const inactiveEnabled = boolWithFallback(
          deviceData?.inactiveEnabled,
          boolWithFallback(userPrefs?.inactiveEnabled, true)
        );
        if (!inactiveEnabled) continue;

        const inactiveLastSentAt = toDate(deviceData?.inactiveLastSentAt);
        if (
          inactiveLastSentAt &&
          now.getTime() - inactiveLastSentAt.getTime() < inactiveMs
        ) {
          continue;
        }

        targets.push({
          token,
          path: `users/${uid}/devices/${deviceKey}`,
          meta: null,
        });
      }
    }

    if (targets.length === 0) return null;

    const result = await sendNotificationTargets({
      targets,
      title: 'We miss you',
      body: 'Come back whenever you are ready. We are here for you.',
      buildSuccessUpdate: () => ({
        inactiveLastSentAt: nowIso,
        lastNotificationType: 'inactive',
      }),
      nowIso,
    });

    console.log(
      `Inactive notification run: sent=${result.sentCount}, removed=${result.removedCount}, queued=${targets.length}`
    );
    return null;
  });
