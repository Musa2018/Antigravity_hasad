# AGENTS.md

## Coding Standards
- Follow Clean Architecture and SOLID principles.
- Use feature-first folder structure.
- All public methods must have XML documentation (C#) or Doc comments (Dart).
- Ensure all Flutter widgets are responsive and support RTL (Arabic).

## Testing
- Aim for high coverage in Domain and Application layers.
- Use Widget tests for shared components.

## Synchronization
- Always consider offline scenarios.
- Data MUST be saved locally before attempting API calls for core features.
