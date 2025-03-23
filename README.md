# User Management System

A modern web application for managing users with authentication, authorization, and user management features. Built with ASP.NET Core MVC and Entity Framework Core.

## Features

- 🔐 User Authentication (Login/Register)
- 👥 User Management Dashboard
- 🔒 Role-based Authorization
- 📊 User Status Tracking (Active/Blocked)
- ⏰ Last Login Time Tracking
- 📝 User Registration Time Tracking
- ✅ Multiple User Selection
- 🛡️ User Blocking/Unblocking
- 🗑️ User Deletion
- 📱 Responsive Design
- 🎨 Modern UI with Bootstrap 5
- 🔍 Real-time User Status Checking

## Prerequisites

- .NET 9.0 SDK or later
- SQL Server (Express or higher)
- Visual Studio 2022 or later / VS Code

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yeasin097/itransition-task_4.git
cd user-management-system
```

2. Update the database connection string in `appsettings.json`:
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=your_server;Database=UserManagementDb;Trusted_Connection=True;TrustServerCertificate=true"
}
```

3. Run the database migrations:
```bash
dotnet ef database update
```

4. Run the application:
```bash
dotnet run
```

5. Open your browser and navigate to:
```
https://localhost:5166
```

## Project Structure

```
UserManagementSystem/
├── Controllers/         # Application controllers
├── Models/             # Data models and view models
├── Views/              # Razor views
├── Data/               # Database context and configurations
├── Filters/            # Custom action filters
├── wwwroot/            # Static files (CSS, JS, images)
└── Migrations/         # Database migrations
```

## Features in Detail

### User Authentication
- Secure login and registration system
- Password hashing and validation
- Remember me functionality
- Session management

### User Management
- View all users in a responsive table
- Sort users by last login time
- Multiple user selection with checkboxes
- Block/Unblock users
- Delete users
- Real-time status updates



