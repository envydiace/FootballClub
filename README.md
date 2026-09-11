## Setup and Testing Instructions

1. Open the project in Xcode.
2. Select an iPhone simulator.
3. Build and run the `FootballClub` target.
4. The app starts using the predefined mock data in `MockFootballData.swift`.
5. Use the small role switch button at the top of the app to switch between:
   - **Club Member** — Alex Nguyen
   - **Organiser** — Sarah Wilson

The role switch is included for testing purposes only. Switching role recreates the relevant screens using the selected mock user so both member and organiser workflows can be tested without authentication.

### Recommended Test Scenarios

#### 1. Waitlist and Organiser Promotion
Use **Sunday Football**.

Initial mock state:
- Capacity: 1 player
- Sam Lee is confirmed
- Alex Nguyen is waitlisted

Test flow:
1. Start as **Club Member (Alex Nguyen)**.
2. Open `My Registrations` and confirm that Sunday Football is shown as waitlisted.
3. Switch to **Organiser (Sarah Wilson)**.
4. Open Sunday Football.
5. Open `Manage Game`.
6. Confirm that:
   - Sam Lee appears under registered players.
   - Alex Nguyen appears in the waitlist.
7. Promote the first waitlisted player.
8. Alex should move from the waitlist to confirmed.

This scenario tests:
- waitlist display
- organiser-only game management
- waitlist promotion
- registration status changes

#### 2. Existing Confirmed Registration
Use **Wednesday Night Football**.

Initial mock state:
- Registration is open.
- Capacity: 16 players.
- Alex Nguyen is already confirmed.
- Jordan Smith is also confirmed.

Test flow:
1. Switch to **Club Member (Alex Nguyen)**.
2. Open Wednesday Night Football.
3. Confirm that the app recognises Alex's existing registration.
4. Open `My Registrations`.
5. Confirm that Wednesday Night Football is shown as confirmed.
6. Cancel the registration.
7. Return to the game detail screen.
8. Confirm that the registration state has refreshed.

This scenario tests:
- confirmed registrations
- duplicate-registration prevention
- registration cancellation
- UI refresh after cancellation

### Additional Mock Scenarios

The project also includes additional mock games for edge-case testing:

- **Friday Evening Football**
  - Registration has not opened yet.
  - Used to test the `registrationNotOpen` rule.

- **Saturday Morning Football**
  - Registration is already closed.
  - Alex has a historical cancelled registration.
  - Used to test closed registration behaviour and cancelled-registration history.

- **Tuesday Social Football**
  - Capacity: 3 players.
  - Two players are already confirmed.
  - One place remains available.
  - Used to test player counts and remaining capacity.

### Mock Users

| User | Role | Purpose |
|---|---|---|
| Alex Nguyen | Member | Main member used to test registration, cancellation and waitlist flows |
| Sarah Wilson | Organiser | Used to test organiser-only game management |
| Sam Lee | Member | Used as an existing confirmed player |
| Jordan Smith | Member | Additional confirmed registration data |
| Chris Brown | Member | Additional mock club member |

### Data Persistence

This MVP uses in-memory repositories and predefined mock data. Changes made while the app is running are kept only for the current app session.

Restarting the app resets the data back to the initial values defined in `MockFootballData.swift`.
