# Meeting Room Booking App

> A Flutter application for booking meeting rooms built as part of a technical interview task.

---

## How to Run

### Prerequisites
- Flutter SDK >= 3.35.0
- Dart SDK >= 3.10.1
- Android Studio / VS Code

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/AlshaimaaAbdElnaeem/meeting_room_booking.git

# 2. Navigate to the project
cd meeting_room_booking

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

### Build APK
```bash
flutter build apk --release
```

### Build Web
```bash
flutter build web
```

---

## Features

- [x] Display list of meeting rooms with name and capacity
- [x] Book a room with date, time slot, and user name
- [x] View existing bookings for each room
- [x] Conflict detection — prevents double booking
- [x] Loading and error states with retry
- [x] Pull to refresh on rooms list
- [x] Responsive UI — works on mobile and web

---

## API

**Base URL:** `https://employeevoice.hub2.icall.com.eg`

| Endpoint | Method | Description |
|---|---|---|
| `/items/rooms` | GET | Get all rooms |
| `/items/bookings?filter[room_id][_eq]={id}` | GET | Get bookings for a room |
| `/items/bookings` | POST | Create a new booking |

---

## Time Spent

approximately **3.5 hours**
