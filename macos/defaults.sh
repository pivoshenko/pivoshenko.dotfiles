#!/usr/bin/env bash

osascript -e 'tell application "System Preferences" to quit'

# Add permanent item to dock
permament_dock_item() {
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}

# Enable dock autohide
defaults write com.apple.dock autohide -bool true
# Enable dock magnification
defaults write com.apple.dock magnification -bool true
# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true
# Disable launch animation
defaults write com.apple.dock launchanim -bool false
# Disable recently used spaces
defaults write com.apple.dock mru-spaces -bool false
# Disable recent applications in dock
defaults write com.apple.dock show-recents -bool false
# Set magnified icon size
defaults write com.apple.dock largesize -int 65
# Set default icon size
defaults write com.apple.dock tilesize -int 45
# Set dock position at bottom
defaults write com.apple.dock orientation -string "bottom"

# Clear persistent dock items
defaults write com.apple.dock persistent-apps -array

# Add common applications to dock
# permament_dock_item "/System/Applications/NordPass.app"
# permament_dock_item "/System/Applications/NordVPN.app"
# permament_dock_item "/Applications/Spotify.app"
# permament_dock_item "/System/Applications/Launchpad.app"
# permament_dock_item "/Applications/Obsidian.app"
# permament_dock_item "/Applications/Telegram.app"
# permament_dock_item "/Applications/Vesktop.app"
# permament_dock_item "/Applications/Zen Browser.app"
# permament_dock_item "/Applications/Zed.app"
# permament_dock_item "/Applications/Visual Studio Code.app"
# permament_dock_item "/Applications/iTerm.app"
# permament_dock_item "/Applications/DBeaver.app"

# Show all file extensions
defaults write com.apple.finder AppleShowAllExtensions -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
# Enable Finder quit option
defaults write com.apple.finder QuitMenuItem -bool true
# Disable extension change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Set Finder view style to column view
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Require password immediately after sleep or screensaver begins
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show 24-hour format clock in menubar
defaults write com.apple.menuextra.clock Show24Hour -bool true
# Show date in menubar clock
defaults write com.apple.menuextra.clock ShowDate -bool true

# Enable function keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
# Enable tap to click for mouse
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Enable secondary click for trackpad
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
# Enable force click for trackpad
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true
# Set trackpad corner click behavior
defaults write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
# Enable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Auto-hide the menubar
defaults write NSGlobalDomain _HIHideMenuBar -bool true
# Force 24-hour time format
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Set dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
# Disable automatic switching of themes
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool false
# Enable paging behavior for scrollbars
defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool true
# Show scroll bars when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show hidden files
defaults write NSGlobalDomain AppleShowAllFiles -bool true

# Keep screenshot shadows
defaults write com.apple.screencapture disable-shadow -bool false
# Show screenshot thumbnail previews
defaults write com.apple.screencapture show-thumbnail -bool true
# Set screenshot save location
defaults write com.apple.screencapture location -string "~/Pictures/screenshots"

# Disable automatic macOS updates
defaults write com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false
# Disable displays spanning spaces
defaults write com.apple.spaces spans-displays -bool false

# Hide widgets in Stage Manager
defaults write com.apple.WindowManager StandardHideWidgets -bool true
# Auto-hide Stage Manager
defaults write com.apple.WindowManager AutoHide -bool true
# Disable standard click to show desktop
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
# Hide desktop when using Stage Manager
defaults write com.apple.WindowManager HideDesktop -bool true
# Hide Stage Manager widgets
defaults write com.apple.WindowManager StageManagerHideWidgets -bool true
# Hide desktop icons in standard view
defaults write com.apple.WindowManager StandardHideDesktopIcons -bool true

# Show battery percentage in menubar
defaults write com.apple.menuextra.battery ShowPercent -bool true
# Hide time remaining in battery menu
defaults write com.apple.menuextra.battery ShowTime -bool false
# Disable quarantine warning for files
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Open Activity Monitor main window at launch
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
# Set Activity Monitor Dock icon to show CPU usage
defaults write com.apple.ActivityMonitor IconType -int 2
# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0
# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-apps -bool true
# Show process indicators in Dock
defaults write com.apple.dock show-process-indicators -bool true
# Prevent resizing of Dock
defaults write com.apple.dock size-immutable -bool true
# Hide external drives on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
# Hide removable media on desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Apply changes
killall Finder
killall Dock
