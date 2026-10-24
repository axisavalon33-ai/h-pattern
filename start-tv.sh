#!/bin/sh
# MEDSCOPE II exhibition screen - run with:  sh start-tv.sh
cd "$(dirname "$0")" || exit 1

IP=""
if command -v ipconfig >/dev/null 2>&1; then           # macOS
  IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
fi
if [ -z "$IP" ] && command -v hostname >/dev/null 2>&1; then   # Linux
  IP=$(hostname -I 2>/dev/null | awk '{print $1}')
fi
[ -z "$IP" ] && IP="<laptop-IP>"

echo ""
echo " =========================================================="
echo "  MEDSCOPE II exhibition screen is starting..."
echo " =========================================================="
echo ""
echo "  Type this on the TV:  http://$IP:8000"
echo ""
echo "  On this laptop you can test with:  http://localhost:8000"
echo "  Keep this window OPEN. To stop: press Ctrl+C."
echo " =========================================================="
echo ""

if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server 8000
else
  python -m http.server 8000
fi
