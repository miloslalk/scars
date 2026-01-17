const crypto = require('crypto');
const admin = require('firebase-admin');
const functions = require('firebase-functions');
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
