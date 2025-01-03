#!/bin/bash

# Exit immediately if any command fails
set -e

# Function to handle errors and perform cleanup
handle_error() {
    echo "An error occurred. Exiting..."
    # Deactivate virtual environment if active
    deactivate 2>/dev/null || true
    exit 1
}

# Trap errors and call the error handler
trap 'handle_error' ERR

echo "Setting up Bazel and development environment..."

# Get the root directory of the project (one level up from scripts/)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 1. Install Bazelisk
bash "$PROJECT_ROOT/scripts/install_bazel.sh"

# 2. Add Bazelisk to PATH for the current session
export PATH="$PROJECT_ROOT/.bazelisk:$PATH"

# 3. Optionally, persist PATH modifications in .bashrc or .zshrc
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_CONFIG="$HOME/.bashrc"
else
    SHELL_CONFIG="$HOME/.profile"
fi

if ! grep -q ".bazelisk" "$SHELL_CONFIG"; then
    echo "export PATH=\"$PROJECT_ROOT/.bazelisk:\$PATH\"" >> "$SHELL_CONFIG"
    echo "Bazelisk added to $SHELL_CONFIG. Restart your terminal or run 'source $SHELL_CONFIG'."
else
    echo "Bazelisk already in $SHELL_CONFIG."
fi

echo "Bazel setup complete."

# 4. Ensure Python 3.12 is installed
echo "Setting up Python 3.12..."

if ! command -v python3.12 &> /dev/null; then
    echo "Python 3.12 is not installed. Installing Python 3.12..."
    brew install python@3.12
else
    echo "Python 3.12 is already installed."
fi

# 5. Deactivate and delete the virtual environment if it exists
VENV_DIR="$PROJECT_ROOT/.venv"
if [[ -d "$VENV_DIR" ]]; then
    echo "Deleting existing virtual environment..."
    deactivate 2>/dev/null || true  # Deactivate if active
    rm -rf "$VENV_DIR"
fi

# 6. Set up a new virtual environment using Python 3.12
echo "Creating a virtual environment with Python 3.12..."
python3.12 -m venv "$VENV_DIR"

# Activate the virtual environment
echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# 7. Ensure pip is installed and upgraded
echo "Setting up pip..."
python3.12 -m ensurepip --upgrade
python3.12 -m pip install --upgrade pip

# 8. Install pre-commit and set up hooks
echo "Setting up pre-commit for formatting and linting..."

if ! command -v pre-commit &> /dev/null; then
    echo "Installing pre-commit..."
    python3.12 -m pip install pre-commit
else
    echo "pre-commit is already installed."
fi

# Install pre-commit hooks
echo "Installing pre-commit hooks..."
python3.12 -m pre_commit install

# 9. Run pre-commit on all files to ensure consistency
echo "Running pre-commit on all files..."
python3.12 -m pre_commit run --all-files

echo "Development environment setup complete. You can now run bazel using '$PROJECT_ROOT/.bazelisk/bazel' (or simply 'bazel' if PATH is updated)."