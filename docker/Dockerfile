# Morning Routine System - Docker Image
FROM python:3.11-slim

# Set labels
LABEL maintainer="leviceroy"
LABEL description="Morning Routine System with Claude Code and gcalcli"
LABEL version="1.1.0"

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    GCALCLI_CONFIG=/app/.gcalcli

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Install gcalcli
RUN pip install --no-cache-dir gcalcli

# Create directories
RUN mkdir -p /app/Daily /app/Goals /app/Notes /app/.claude

# Copy application files
COPY .claude/ /app/.claude/
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set up non-root user (optional but recommended)
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} routine && \
    useradd -m -u ${UID} -g routine routine && \
    chown -R routine:routine /app

USER routine

# Set working directory
WORKDIR /app

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD gcalcli --version || exit 1

# Entry point
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
