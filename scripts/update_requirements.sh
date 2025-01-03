#!/bin/bash

set -e  # Exit on any error

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${GREEN}[UPDATE REQUIREMENTS]${NC} $1"
}

# Error handling function
error_exit() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    exit 1
}

# Get the root directory of the project (one level up from scripts/)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Validate Python environment
validate_python_env() {
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1-2)
    
    if [[ "$(printf '%s\n' "3.9" "$PYTHON_VERSION" | sort -V | head -n1)" != "3.9" ]]; then
        error_exit "Python 3.9+ required. Current version: $PYTHON_VERSION"
    fi
}

# Update requirements function
update_requirements() {
    # Validate Python environment
    validate_python_env

    # Create virtual environment if not exists
    VENV_PATH="$PROJECT_ROOT/venv"
    if [[ ! -d "$VENV_PATH" ]]; then
        log "Creating virtual environment..."
        python3 -m venv "$VENV_PATH"
    fi

    # Activate virtual environment
    source "$VENV_PATH/bin/activate"

    # Install required tools
    log "Installing pip tools..."
    pip install --upgrade pip pip-tools pur wheel setuptools pipdeptree

    # Navigate to requirements directory
    cd "$PROJECT_ROOT/requirements"

    # Backup existing requirements files
    log "Backing up existing requirements files..."
    [[ -f requirements.in ]] && cp requirements.in requirements.in.bak
    [[ -f requirements_lock.txt ]] && cp requirements_lock.txt requirements_lock.txt.bak

    # Use pur to update packages interactively
    log "Updating packages in requirements.in..."
    pur -r requirements.in

    # Compile requirements with latest versions
    log "Compiling requirements with pip-compile..."
    pip-compile requirements.in --output-file=requirements_lock.txt --constraint constraints.txt

    # Return to project root
    cd "$PROJECT_ROOT"

    # Deactivate virtual environment
    deactivate

    log "Requirements updated successfully! 🚀"
}

# Cleanup function
cleanup() {
    # Remove virtual environment
    if [[ -d "$PROJECT_ROOT/venv" ]]; then
        rm -rf "$PROJECT_ROOT/venv"
        log "Virtual environment removed."
    fi
}

# Trap signals for cleanup
trap cleanup EXIT SIGINT SIGTERM

# Main script execution
update_requirements