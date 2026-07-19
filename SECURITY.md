# HASAD - Security Documentation

## API Security
- HTTPS required for all production traffic.
- JWT expiration set to 1 hour; Refresh tokens valid for 30 days.
- Rate limiting on sensitive endpoints (Login, Reset Password).

## Mobile Security
- No sensitive data (JWT, PII) in plain SQLite.
- `flutter_secure_storage` used for secrets.
- Jailbreak/Root detection (planned).

## Audit Trails
- All create/update/delete operations on the backend are logged with the acting User ID.
