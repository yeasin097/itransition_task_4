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
https://localhost:5001
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

### Security Features
- User status checking before each request
- Automatic redirection to login for blocked users
- Secure password handling
- CSRF protection
- XSS prevention

### UI/UX Features
- Modern, responsive design
- Bootstrap 5 components
- Font Awesome icons
- Interactive table with hover effects
- Status badges for user states
- Confirmation dialogs for destructive actions

## Technologies Used

- ASP.NET Core MVC
- Entity Framework Core
- SQL Server
- Bootstrap 5
- Font Awesome
- jQuery
- Identity Framework

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Bootstrap for the UI framework
- Font Awesome for the icons
- Microsoft for ASP.NET Core and Entity Framework Core

