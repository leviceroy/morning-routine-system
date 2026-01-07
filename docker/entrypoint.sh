#!/bin/bash
set -e

echo "🌅 Morning Routine System - Docker Container"
echo "=============================================="

# Check if gcalcli is installed
if ! command -v gcalcli &> /dev/null; then
    echo "❌ Error: gcalcli not found"
    exit 1
fi

echo "✅ gcalcli version: $(gcalcli --version 2>&1 | head -1)"

# Check if calendar credentials are configured
if [ ! -d "$HOME/.gcalcli_oauth" ] && [ ! -d "/app/.gcalcli" ]; then
    echo ""
    echo "⚠️  Google Calendar not yet authenticated"
    echo ""
    echo "To authenticate:"
    echo "  1. Enter the container: docker-compose exec morning-routine bash"
    echo "  2. Run: gcalcli init --noauth_local_server"
    echo "  3. Follow the authentication prompts"
    echo ""
fi

# Check environment variables
if [ -z "$GOOGLE_CLIENT_ID" ] || [ -z "$GOOGLE_CLIENT_SECRET" ]; then
    echo ""
    echo "⚠️  Google OAuth credentials not set"
    echo "Please set GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET in .env file"
    echo ""
fi

# Set timezone if provided
if [ -n "$TZ" ]; then
    echo "🌍 Timezone: $TZ"
fi

# Display calendar name
if [ -n "$CALENDAR_NAME" ]; then
    echo "📅 Calendar: $CALENDAR_NAME"
fi

echo ""
echo "Ready! Run '/morning-routine:main' to start."
echo "=============================================="
echo ""

# Execute command
exec "$@"
