#!/bin/bash

# Function to display menu
show_menu() {
    echo "===== System Metrics Monitoring ====="
    echo "1. View CPU Usage"
    echo "2. View Memory Usage"
    echo "3. View Disk Space"
    echo "4. Monitor Nginx Service"
    echo "5. Monitor a Different Service"
    echo "6. Exit"
    echo "====================================="
    echo
}

# Function to display CPU usage
show_cpu_usage() {
    top -n 1
}

# Function to display memory usage
show_memory_usage() {
    free -h
}

# Function to display disk space
show_disk_space() {
    df -h
}

# Function to check and start Nginx service
monitor_nginx_service() {
    # Check if Nginx is running
    if systemctl is-active --quiet nginx; then
        echo "Nginx service is running."
    else
        echo "Nginx service is not running."
        read -p "Do you want to start Nginx? (y/n): " choice
        if [[ $choice == "y" ]]; then
            sudo systemctl start nginx
            echo "Nginx service has been started."
        fi
    fi
}

# Function to monitor a specific service
monitor_specific_service() {
    read -p "Enter the name of the service to monitor: " service_name
    if systemctl is-active --quiet "$service_name"; then
        echo "$service_name service is running."
    else
        echo "$service_name service is not running."
    fi
}

# Function for error handling
handle_error() {
    echo "Error: $1"
    exit 1
}

# Clear the screen before the loop starts
clear

# Main script
while true; do
    show_menu
    read -p "Enter your choice: " choice
    echo

    case $choice in
        1) show_cpu_usage ;;
        2) show_memory_usage ;;
        3) show_disk_space ;;
        4) monitor_nginx_service ;;
        5) monitor_specific_service ;;
        6) exit 0 ;;
        *) handle_error "Invalid choice. Please enter a valid option." ;;
    esac

    echo
    read -p "Press Enter to continue..." -t 3
    echo
done
