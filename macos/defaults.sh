#!/usr/bin/env bash

osascript -e 'tell application "System Preferences" to quit'

# =================================================
# Dock
# =================================================

# add permanent item to dock
permament_dock_item() {
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$1</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
}

# enable dock autohide
defaults write com.apple.dock autohide -bool true
# enable dock magnification
defaults write com.apple.dock magnification -bool true
# minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true
# disable launch animation
defaults write com.apple.dock launchanim -bool false
# disable recently used spaces
defaults write com.apple.dock mru-spaces -bool false
# disable recent applications in dock
defaults write com.apple.dock show-recents -bool false
# set magnified icon size
defaults write com.apple.dock largesize -int 65
# set default icon size
defaults write com.apple.dock tilesize -int 45
# set dock position at bottom
defaults write com.apple.dock orientation -string "bottom"

# clear persistent dock items
defaults write com.apple.dock persistent-apps -array
# add common applications to dock
permament_dock_item "/System/Applications/NordPass.app"
permament_dock_item "/System/Applications/NordVPN.app"
permament_dock_item "/System/Applications/Launchpad.app"
permament_dock_item "/Applications/Obsidian.app"
permament_dock_item "/Applications/Telegram.app"
permament_dock_item "/Applications/Discord.app"
permament_dock_item "/Applications/Zen Browser.app"
permament_dock_item "/Applications/Zed.app"
permament_dock_item "/Applications/Visual Studio Code.app"
permament_dock_item "/Applications/iTerm.app"
permament_dock_item "/Applications/Spotify.app"

# =================================================
# Finder
# =================================================

# show all file extensions
defaults write com.apple.finder AppleShowAllExtensions -bool true
# show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# show path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
# show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
# enable Finder quit option
defaults write com.apple.finder QuitMenuItem -bool true
# disable extension change warning
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# set Finder view style to column view
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# =================================================
# Screensaver
# =================================================

# require password immediately after sleep or screensaver begins
defaults write com.apple.screensaver askForPasswordDelay -int 0

# =================================================
# Menubar
# =================================================

# show 24-hour format clock in menubar
defaults write com.apple.menuextra.clock Show24Hour -bool true
# show date in menubar clock
defaults write com.apple.menuextra.clock ShowDate -bool true

# =================================================
# Keyboard / Mouse / Trackpad
# =================================================

# enable function keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
# enable tap to click for mouse
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# enable secondary click for trackpad
defaults write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
# enable force click for trackpad
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true
# set trackpad corner click behavior
defaults write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
# enable natural scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# =================================================
# Menubar
# =================================================

# auto-hide the menubar
defaults write NSGlobalDomain _HIHideMenuBar -bool true
# force 24-hour time format
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# =================================================
# Theme
# =================================================

# set dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
# disable automatic switching of themes
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool false
# enable paging behavior for scrollbars
defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool true
# show scroll bars when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# =================================================
# Finder
# =================================================

# show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# show hidden files
defaults write NSGlobalDomain AppleShowAllFiles -bool true

# =================================================
# Screenshot Tool
# =================================================

# keep screenshot shadows
defaults write com.apple.screencapture disable-shadow -bool false
# show screenshot thumbnail previews
defaults write com.apple.screencapture show-thumbnail -bool true
# set screenshot save location
defaults write com.apple.screencapture location -string "~/Pictures/screenshots"

# =================================================
# Misc
# =================================================

# disable automatic macOS updates
defaults write com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false
# disable displays spanning spaces
defaults write com.apple.spaces spans-displays -bool false

# =================================================
# Stage Manager
# =================================================

# hide widgets in Stage Manager
defaults write com.apple.WindowManager StandardHideWidgets -bool true
# auto-hide Stage Manager
defaults write com.apple.WindowManager AutoHide -bool true
# disable standard click to show desktop
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
# hide desktop when using Stage Manager
defaults write com.apple.WindowManager HideDesktop -bool true
# hide Stage Manager widgets
defaults write com.apple.WindowManager StageManagerHideWidgets -bool true
# hide desktop icons in standard view
defaults write com.apple.WindowManager StandardHideDesktopIcons -bool true

# =================================================
# Custom User Preferences
# =================================================

# show battery percentage in menubar
defaults write com.apple.menuextra.battery ShowPercent -bool true
# hide time remaining in battery menu
defaults write com.apple.menuextra.battery ShowTime -bool false
# disable quarantine warning for files
defaults write com.apple.LaunchServices LSQuarantine -bool false
# open Activity Monitor main window at launch
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
# set Activity Monitor Dock icon to show CPU usage
defaults write com.apple.ActivityMonitor IconType -int 2
# show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0
# group windows by application in Mission Control
defaults write com.apple.dock expose-group-apps -bool true
# show process indicators in Dock
defaults write com.apple.dock show-process-indicators -bool true
# prevent resizing of Dock
defaults write com.apple.dock size-immutable -bool true
# hide external drives on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
# hide removable media on desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# apply changes
killall Finder
killall Dock
