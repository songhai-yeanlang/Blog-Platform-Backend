# Blog-post-beginner-api
For beginner students learning frontend fetch with a real API.

## Test With Postman

1. Import `postman/Blog-Post-API.postman_collection.json` into Postman.
2. Import `postman/Blog-Post-API.postman_environment.json`.
3. Select the `Blog Post API - Local` environment.
4. Set `baseUrl` if your server is not running on `http://localhost:3000`.
5. Set a unique `email` before testing register.

## Local Setup

1. Create `.env` from `.env.example` and fill in your MySQL settings.
2. Create the database tables from `src/script/db.sql`.
3. Run `npm install`.
4. Run `npm run dev`.

## Suggested Postman Flow

1. `Auth / Register`
2. Copy the verification token from your email. If SMTP is not configured, copy it from the server console log.
3. Paste the token into the `verificationToken` environment variable.
4. `Auth / Verify Email`
5. `Auth / Login`
6. Use profile requests. Login automatically saves `token` and `refreshToken`.

For forgot-password testing, run `Auth / Forgot Password`, copy the OTP from email or the server console, set the `otp` environment variable, then run `Auth / Verify OTP`. That request automatically saves `resetToken` for `Auth / Reset Password`.
