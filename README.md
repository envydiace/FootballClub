# FootballClub

FootballClub is an iOS MVP for community football clubs that helps members discover, register for, and manage weekly football games while reducing manual administration for organisers.

The app was developed using SwiftUI and follows a layered MVVM-style architecture with domain-focused models, Use Cases, repository protocols, and in-memory data repositories.

---

## Project Overview

The purpose of FootballClub is to simplify weekly football game participation.

Club members can:
- Browse upcoming games
- View game details and availability
- Register for a game
- View confirmed and waitlisted registrations
- Cancel registrations

Organisers can:
- View registered players
- View the waitlist
- Promote waitlisted players when places become available

The MVP focuses on the registration and waitlist workflow identified during Assignment 1.

---

## Repository

Source code and Git version history are available on GitHub:

https://github.com/envydiace/FootballClub

---

## Domain Context

Community football clubs often manage weekly games through manual processes such as spreadsheets, messages, and informal communication.

This can create problems including:
- Unclear game availability
- Manual tracking of registered players
- Last-minute cancellations
- Difficulty managing waitlists
- Repetitive administrative work for organisers

The application models the football registration domain using semantic domain entities:

- `WeeklyFootballGame` — represents a scheduled weekly football game
- `ClubMember` — represents a football club member or organiser
- `WeeklyGameRegistration` — represents a member's registration for a game
- `WeeklyGameRegistrationStatus` — represents registration states such as confirmed, waitlisted, or cancelled

The primary domain workflow implemented in the MVP is **Register For Game**.

---

## Architecture Summary

The application follows a layered MVVM-style architecture that separates the user interface, presentation logic, domain behaviour, and data access.

```text
Views -> ViewModels -> Use Cases -> Domain Models -> Repository Protocols -> In-Memory Repository Implementations -> Mock Data
```

### Views

The SwiftUI presentation layer contains four main functional screens:

- UpcomingGamesView
- GameDetailView
- MyRegistrationsView
- ManageGameView

These views are responsible for displaying information and receiving user interactions.

### ViewModels

Each main screen uses a ViewModel to manage presentation state and coordinate user actions:

- UpcomingGamesViewModel
- GameDetailViewModel
- MyRegistrationsViewModel
- ManageGameViewModel

The ViewModels keep UI logic separate from the core business rules.

### Use Cases

Business behaviour is implemented through dedicated Use Case structs:

- RegisterForGameUseCase
- CancelGameRegistrationUseCase
- PromoteWaitlistedPlayerUseCase

For example, RegisterForGameUseCase checks the registration window, prevents duplicate active registrations, checks game capacity, and determines whether the member should be confirmed or waitlisted.

### Domain Models

The domain layer uses semantic models that represent real football club concepts:

- WeeklyFootballGame
- ClubMember
- WeeklyGameRegistration
- WeeklyGameRegistrationStatus

These models represent the main entities and states involved in weekly game participation.

### Data Layer

Repository protocols provide an abstraction between the domain logic and the underlying data implementation:

- WeeklyFootballGameRepository
- WeeklyGameRegistrationRepository
- ClubMemberRepository

The current MVP uses in-memory implementations:

- InMemoryWeeklyFootballGameRepository
- InMemoryWeeklyGameRegistrationRepository
- InMemoryClubMemberRepository

MockFootballData provides predefined games, members, and registrations for development and testing.

This structure keeps the MVP modular and testable, while allowing the in-memory data implementation to be replaced by persistent storage or a remote API in the future without requiring major changes to the SwiftUI views or domain business rules.
--- 
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
