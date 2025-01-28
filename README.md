# Personal Expense Tracker App

This is a **Personal Expense Tracker App** built with Flutter, designed to help users manage their expenses effectively. The app allows users to add, view, and summarize their expenses with additional features like sorting, filtering, and daily reminder notifications.

---

## Features

### 1. Add Expenses
- Users can input expense details such as:
    - Date
    - Amount
    - Description
- Full-width "Add Expense" button for easy navigation.

### 2. View Expenses
- Displays a list of recorded expenses.
- **Sorting**: Sort expenses by date in ascending or descending order.
- **Filtering**: Filter expenses by a specific date.

### 3. Expense Summary
- Weekly and Monthly summaries of expenses.
- Categorized totals with clear display for each time frame.

### 4. Daily Reminder Notifications
- Sends a notification daily at a specified time to remind users to log their expenses.

### 5. Data Persistence
- All data is stored locally using SQLite.
- Data remains available even after restarting the app.

---

## Getting Started

### Prerequisites
Ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Android Studio or VS Code with Flutter plugin
- A real device or emulator for testing

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/dsolanki2772/expense_tracker.git
   cd expense_tracker
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## Usage Instructions

### Add Expense
1. Tap the **Add Expense** button on the home page.
2. Fill in the details:
    - Date (use the date picker)
    - Amount (only decimal values allowed)
    - Description (multi-line input)
3. Tap **Add Expense** to save the entry.

### View and Manage Expenses
- Navigate to the **Expenses** tab to view the list of expenses.
- Use the dropdown to sort expenses by date.
- Use the "Filter by Date" button to display expenses for a specific day.

### Expense Summary
- Navigate to the **Summary** tab.
- View weekly and monthly expense totals.

### Set Daily Reminder
- Enable daily reminders by tapping the "Set Daily Reminder" button (optional).
- Notifications will appear daily at 8:00 PM to remind you to log expenses.

---

## Technical Details

### Architecture
- **State Management**: Bloc
- **Database**: SQLite
- **Notifications**: `flutter_local_notifications`

### Key Dependencies
- `flutter_bloc`: State management
- `sqflite`: Local database
- `flutter_local_notifications`: Notifications
- `intl`: Date formatting

---

## Troubleshooting

### Notification Issues
- Ensure your app has notification permissions.
- Check the device's notification settings for the app.

### SQLite Issues
- Verify the database is initialized properly.
- Check the log for any SQL errors.

---

## Future Enhancements
- User authentication.
- Cloud data synchronization.
- Advanced reporting and analytics.