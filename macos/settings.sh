# This file contains settings for MacOS which makes me happy :3
# The best resource for finding new settings for other users is: https://www.defaults-write.com

# All values are sorted inside their blocks the newest are on the top

set -e

echo "Configuring your MacOS. Hang tight :3"
osascript -e 'tell application "System Preferences" to quit'

# =============================================================================================
# General
# =============================================================================================

# hide remaining battery time show percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "NO"

# disable dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# scrollbars visible when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# deactivate rubber scrolling
# http://osxdaily.com/2012/05/10/disable-elastic-rubber-band-scrolling-in-mac-os-x
defaults write -g NSScrollViewRubberbanding -int 0

# =============================================================================================
# Display
# =============================================================================================

# set blue accent color
defaults write -globalDomain AppleAccentColor -int 4
defaults write NSGlobalDomain AppleHighlightColor -int 4

# =============================================================================================
# Dock
# =============================================================================================

# set size
defaults write com.apple.dock tilesize -int 40
# show indicator lights for open apps in Dock
defaults write com.apple.dock show-process-indicators -bool true
# fix location
defaults write com.apple.Dock size-immutable -bool yes
# show Dock instantly
defaults write com.apple.dock autohide-delay -float 0
# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# =============================================================================================
# Safari
# =============================================================================================

# don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# improve Safari security
defaults write com.apple.Safari \
  com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled \
  -bool false
defaults write com.apple.Safari \
  com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles \
  -bool false

# =============================================================================================
# Text editor
# =============================================================================================

# disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# disable autocorrect
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# disable auto-capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# diable automatic period substitution
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# =============================================================================================
# Menu bar
# =============================================================================================

# make status icons smaller, so they will take less space
# https://flaky.build/built-in-workaround-for-applications-hiding-under-the-macbook-pro-notch
defaults write -globalDomain NSStatusItemSelectionPadding -int 12
defaults write -globalDomain NSStatusItemSpacing -int 12

# =============================================================================================
# Finder
# =============================================================================================

# keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# show Finder path bar
defaults write com.apple.finder ShowPathbar -bool true
# do not show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool false
# show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
# show file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true
# allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true
# display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# show Library folder
chflags nohidden ~/Library

# =============================================================================================
# Activity monitor
# =============================================================================================

# show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
# visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5
# show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# =============================================================================================
# Hot corners
# =============================================================================================

defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0

# =============================================================================================
# Sonoma
# =============================================================================================

# disable text cursor in macOS Sonoma
defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist redesigned_text_cursor -dict-add Enabled -bool NO

# =============================================================================================
# Maccy
# =============================================================================================

defaults write org.p0deje.Maccy pasteByDefault false
defaults write org.p0deje.Maccy historySize 50
defaults write org.p0deje.Maccy fuzzySearch true
defaults write org.p0deje.Maccy hotKey command+shift+v
defaults write org.p0deje.Maccy popupPosition -string "statusItem"

# Restarting apps
echo "Restarting apps..."
killall Finder
killall Dock

echo "Done!"
