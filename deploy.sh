#!/bin/bash

# deploy.sh - Simplified deployment script for Task4 on a Linux server (Ubuntu 20.04) for intern review

# Exit on any error
set -e

# Variables
APP_NAME="Task4"
APP_DIR="/home/$USER/task4"
PUBLISH_DIR="$APP_DIR/publish"
SQL_SA_PASSWORD="@SRock3700x"  # Password meeting SQL Server requirements
SERVER_IP=$(curl -s ifconfig.me)  # Automatically detect the server's public IP
APP_PORT=5166  # Port for the application

# Log function for better output
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Step 1: Update the system and install prerequisites
log "Updating system and installing prerequisites..."
sudo apt-get update
sudo apt-get install -y wget curl apt-transport-https software-properties-common

# Step 2: Install .NET 8 SDK
log "Installing .NET 8 SDK..."
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-8.0
dotnet --version

# Step 3: Install SQL Server 2022
log "Installing SQL Server 2022..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list)"
sudo apt-get update
sudo apt-get install -y mssql-server

# Step 4: Configure SQL Server with error handling
log "Configuring SQL Server..."
if ! sudo /opt/mssql/bin/mssql-conf setup <<EOF
2
yes
$SQL_SA_PASSWORD
$SQL_SA_PASSWORD
EOF
then
    log "SQL Server setup failed. Please check the password and try again."
    log "Password must be at least 8 characters long and include uppercase, lowercase, digits, and/or special characters."
    exit 1
fi

# Start SQL Server
sudo systemctl start mssql-server
sudo systemctl enable mssql-server
sudo systemctl status mssql-server

# Step 5: Install SQL Server command-line tools
log "Installing SQL Server command-line tools..."
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list)"
sudo apt-get update
sudo apt-get install -y mssql-tools unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc

# Step 6: Create the UserManagementDb database
log "Creating UserManagementDb database..."
sqlcmd -S localhost -U sa -P "$SQL_SA_PASSWORD" -Q "CREATE DATABASE UserManagementDb"

# Step 7: Install EF Core tools
log "Installing EF Core tools..."
dotnet tool install --global dotnet-ef
echo 'export PATH="$PATH:$HOME/.dotnet/tools"' >> ~/.bashrc
source ~/.bashrc

# Step 8: Publish the application
log "Publishing the application..."
cd "$(dirname "$0")"  # Navigate to the script's directory (repo root)
dotnet publish -c Release -o "$PUBLISH_DIR"

# Step 9: Apply EF Core migrations
log "Applying EF Core migrations..."
cd "$APP_DIR"
dotnet ef database update --project "$(dirname "$0")"

# Step 10: Open firewall port for Kestrel
log "Opening firewall port $APP_PORT..."
sudo ufw allow $APP_PORT/tcp
sudo ufw status

# Step 11: Final instructions
log "Setup complete!"
log "To run the application, execute the following commands:"
log "  cd $PUBLISH_DIR"
log "  ASPNETCORE_URLS=http://+:$APP_PORT dotnet Task4.dll"
log "Then access the app at http://$SERVER_IP:$APP_PORT"
log "To stop the app, press Ctrl+C in the terminal where it's running."
log "To verify the database, connect to SQL Server with:"
log "  sqlcmd -S localhost -U sa -P $SQL_SA_PASSWORD"
log "Then run: USE UserManagementDb; SELECT * FROM AspNetUsers; GO"