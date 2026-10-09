#!/usr/bin/bash
choice=$(printf "Shutdown\nRestart\nSuspend\nLogout\nLock" | dmenu -l 10 -c)
case $choice in
  Shutdown) systemctl poweroff ;;
  Restart) systemctl reboot ;;
  Suspend) systemctl suspend ;;
  Logout) loginctl terminate-session $XDG_SESSION_ID ;;
  Lock) slock ;;
esac


