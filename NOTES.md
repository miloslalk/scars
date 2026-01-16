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
- Notifications: pending design/discussion for scheduling and preferences.
- Re-authenticate action added for password users before sensitive changes.
- Email change sends verification; unchanged email does not re-send.
- Email/password changes locked for non-password providers.
- Password change requires confirmation and enforces strength rules with visibility toggles.

## Body Awareness
- Body awareness captures a tap position and color on the body outline.
- Saved per day at `users/{uid}/body_awareness/{yyyyMMdd}` with x/y/color/createdAt.
- Body awareness screen styled differently in light/dark themes.
- Body regions are detected with basic hit zones; console logs region name.
- TODO: Add precise hit-map detection (color-coded mask) to detect body part and outside-body taps.

## Navigation
- Bottom nav includes Home, Body Awareness, My Space, Messages, Help.
- Settings moved to avatar menu with a styled dropdown (Settings/Log out).

## Assets & Data
- Mock data assets/repositories removed; app uses Firebase only.
- Body outline asset: `assets/images/Human_body_outline.svg`.

## Messages (Balloons)
- Messages tab shows a continuous stream of animated balloons.
- Balloons are tinted variants of `assets/images/balloon_heart.svg`.
- Balloons pop on tap with a brief burst animation.
