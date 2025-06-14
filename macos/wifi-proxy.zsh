#!/usr/bin/env zsh

# Request administrator privilege if not run with sudo
if [[ $EUID -ne 0 ]]; then
  echo "🔒 This script requires administrator privileges. Please enter your password."
  exec sudo "$0" "$@"
fi

this_file=$(basename $0)

print "\n$this_file - macOS Wi-Fi proxy enable/disable script\n"

internal_ip_addr=$(ipconfig getifaddr en0)
port=8080


# ------------------------------------------------------------------------------
# Function declarations / implementations
# ------------------------------------------------------------------------------

# Function to enable Wi-Fi proxy
function set_wifi_proxy() {
    networkservice=$(networksetup -listallnetworkservices | grep -E '(Wi-Fi|AirPort)')
    networksetup -setwebproxy "$networkservice" "$internal_ip_addr" "$port"
    networksetup -setsecurewebproxy "$networkservice" "$internal_ip_addr" "$port"
    echo "\nWi-Fi proxy has been enabled. ($internal_ip_addr:$port)\n"
}

# Function to disable Wi-Fi proxy
function unset_wifi_proxy() {
    networkservice=$(networksetup -listallnetworkservices | grep -E '(Wi-Fi|AirPort)')
    networksetup -setwebproxystate "$networkservice" off
    networksetup -setsecurewebproxystate "$networkservice" off
    echo "\nWi-Fi proxy has been disabled.\n"
}


# ------------------------------------------------------------------------------
# Entry point
# ------------------------------------------------------------------------------

echo "S. Set Wi-Fi Proxy"
echo "U. Unset Wi-Fi Proxy"
echo "Q. Quit"
echo

while true; do
    echo -n "Please select an option (S/U/Q): "
    read choice
    choice=$(echo "$choice" | tr '[:lower:]' '[:upper:]')  # convert lowercase to uppercase
    case $choice in
        S)
            set_wifi_proxy
            break
            ;;
        U)
            unset_wifi_proxy
            break
            ;;
        Q)
            break
            ;;
        *)
            ;;
    esac
done

exit 0
