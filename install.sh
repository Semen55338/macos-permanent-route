#!/bin/bash

LaunchDaemon="/Library/LaunchDaemons/net.staticroute.plist"

if [ "$EUID" -ne 0 ]
  then echo "Only root can run this"
  exit
fi

[ ! -f $LaunchDaemon ] && cat > $LaunchDaemon << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>static.route</string>
  <key>Program</key>
  <string>$(pwd)/startup-route.sh</string>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF

launchctl load -w $LaunchDaemon 