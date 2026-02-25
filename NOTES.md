# Product Rules Log

## Registration
- Email/password registration is required.
- Username must be unique and at least 6 characters.
- Password rules: min 8 chars, at least 1 uppercase, 1 number, 1 special.
- Confirm password must match.
- Password visibility toggle is available.
- Terms checkbox required; link opens Terms page (lorem ipsum for now).
- Real-time username availability check with inline feedback.
- Email verification required; expires after 5 days.
- If verification expired, account is deleted on next login attempt.
- Login warning: "Please verify your email {email} until {expiration date}".

## Authentication
- Firebase Auth is the source of truth for passwords.
- Login supports email or username (username resolves to email via RTDB index).
- Google sign-in is supported; new users get a generated unique username.
- Logout clears session and returns to landing page.
- Login password field has an eye toggle for visibility.
- TODO (before production): finalize Google OAuth consent screen branding in Google Cloud so Google sign-in shows `When Scars (!) Become Art` instead of `project-537...`.
- Android Google Sign-In checklist:
- Firebase Android app package must be `eu.whenscarsbecomeart.app`.
- Required SHA-1 fingerprints in Firebase for this app:
- Debug: `4B:D3:10:70:0E:32:28:F3:FD:4E:09:60:77:2A:DC:AC:3D:61:8C:41`
- Release/upload: `28:DC:D8:63:D9:20:CB:A4:C4:32:4C:28:86:32:96:6F:08:FF:3F:DC`
- After adding fingerprints: redownload `android/app/google-services.json`, then run `flutter clean`, `flutter pub get`, uninstall app, and rerun.

## Drawings
- Canvas supports brush, eraser, undo, and text tool (draggable).
- Save uploads image to Firebase Storage at `users/{uid}/drawings/{username_timestamp}.png`.
- Save writes metadata to RTDB `users/{uid}/drawings/{timestamp}`.
- Storage and RTDB rules restrict access to the authenticated user.
- Calendar day view pulls all drawings for the selected date and allows deletion with confirmation.

## Avatars
- Users can set an avatar from camera or gallery.
- Avatar uploads to Storage at `users/{uid}/avatars/avatar.jpg`.
- Avatar URL stored in RTDB at `users/{uid}/avatarUrl`.
- Removing avatar deletes storage object and clears `avatarUrl`.

## Prompt & Music
- On Save/Skip, show body check dialog.
- If user chooses Yes, open music player and play the provided MP3.
- Music player has Play/Pause and Skip.

## Localization
- English-only strings for new work until translations are requested.

## Process
- Keep this file updated whenever new product rules/behaviors are added.

## My Space
- My Space is a lock-tab hub with Calendar, Journal, and Library tiles.
- Calendar uses a date picker and full-screen modal carousel (Mood, Body, Quote, Note).
- Mood page shows drawings for the day; Note page shows the latest journal entry for the day.
- Body page shows the saved body awareness point for the day.

## Journal
- Journal entries are stored per user at `users/{uid}/journal/{entryId}`.
- Entry metadata: text, createdAt, fontFamily, isBold, isItalic.

## Settings & Theme
- Settings are opened from the avatar menu; bottom nav settings tab removed.
- Theme selector added (System/Light/Dark).
- Users can update display name; stored in Auth displayName and RTDB `users/{uid}/fullName`.
- Push notifications moved to FCM + Cloud Functions scheduler.
- Daily push: "Good morning" at 09:00 local (device `utcOffsetMinutes` based).
- Inactivity push: "We miss you" when `lastLoginAt` is older than 7 days.
- Device push state stored at `users/{uid}/devices/{tokenKey}` (token/platform/offset/send guards).
- User notification preferences editable in Settings (daily on/off, time, inactivity on/off) and saved at `users/{uid}/notificationPrefs` + synced to `users/{uid}/devices/*`.
- TODO: Configure iOS push end-to-end (APNs key/cert in Firebase + Push Notifications capability in Xcode target).
- TODO: Add push QA checklist and runbook (force-run scheduler, validate `queued/sent`, foreground/background behavior, token cleanup).
- Re-authenticate action added for password users before sensitive changes.
- Email change sends verification; unchanged email does not re-send.
- Email/password changes locked for non-password providers.
- Password change requires confirmation and enforces strength rules with visibility toggles.

## Body Awareness
- Body awareness captures a tap position and color on the body outline.
- Saved per day at `users/{uid}/body_awareness/{yyyyMMdd}` with x/y/color/createdAt.
- Body awareness screen styled differently in light/dark themes.
- Body regions are detected with basic hit zones; console logs region name.

## Navigation
- Bottom nav includes Home, Body Awareness, My Space, Messages, Help.
- Settings moved to avatar menu with a styled dropdown (Settings/Log out).

## Assets & Data
- Mock data assets/repositories removed; app uses Firebase only.
- Body outline asset: `assets/images/Human_body_outline.svg`.
- TODO: Cookie Monster on Android shows gray/noisy artifact in transparent areas (iOS is fine). Likely WebM alpha export/decoder compatibility issue; verify on real Android device and with clip provider (re-encode Android assets if needed).

## Messages (Balloons)
- Once a user pops a balloon message, it must never be shown again to that user.
- The number of visible balloons equals the number of messages the user has not popped.
- Messages tab shows a continuous stream of animated balloons.
- Balloons are tinted variants of `assets/images/balloon-heart-fill_1.svg`.
- Balloons pop on tap with a brief burst animation.
- Balloon messages do not expire.
- TODO: Limit popping to 1 balloon per day, reset at 00:00 CET (keep unlimited for testing).
- Messages load from RTDB path `messages/{locale}` with assets fallback when DB data is missing.
- TODO: Add 365 localized messages per language when provided by client (current list is for testing) using `{id,text}` entries with stable IDs across locales.

## Care Corner
- Care Corner is a standalone page with 7 flag bubbles (Romania, Serbia, Greece, North Macedonia, Germany, Turkey, EU).
- Tapping a flag centers it and reveals 3 inner bubbles: Wellbeing, Support & Services, Education.
- Inner bubbles open mock content lists; content will be wired to Firebase later.

## Drawing
- Notification timezone handling updated to use device IANA timezone (`timezoneName`) for DST-safe push delivery; UTC offset remains as fallback.
