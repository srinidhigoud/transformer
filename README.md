# Transformer Project

This repository contains the codebase for the Transformer project, which focuses on [brief description of your project, e.g., "implementing and optimizing transformer models for natural language processing tasks"].

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Setup](#setup)
3. [Running the Project](#running-the-project)
4. [Contributing](#contributing)
5. [License](#license)

---

## Prerequisites

Before setting up the project, ensure you have the following installed on your system:

- **Git**: [Install Git](https://git-scm.com/downloads)
- **Python 3.12**: [Install Python 3.12](https://www.python.org/downloads/)
- **Homebrew** (for macOS): [Install Homebrew](https://brew.sh/)
- **Bazelisk**: Installed automatically by the setup script.

---

## Setup

Follow these steps to set up the project on your local machine:

### 1. Clone the Repository

Clone the repository using either HTTPS or SSH:

```bash
# Using HTTPS
git clone https://github.com/srinidhigoud/transformer.git

# Using SSH
git clone git@github.com:srinidhigoud/transformer.git
```

Navigate to the project directory:

```bash
cd transformer
```

### 2. Run the Setup Script

The setup.sh script will install all dependencies, set up Bazel, and configure the development environment.

Run the script:
```bash
chmod +x scripts/setup.sh
bash scripts/setup.sh
```

This script will:
- Install Bazelisk.
- Set up a Python virtual environment.
- Install Python dependencies.
- Configure pre-commit hooks for code formatting and linting.

### 3. Activate the Virtual Environment

After running the setup script, activate the virtual environment:

```bash
source .venv/bin/activate
```

---

## Running the Project

Once the setup is complete, you can run the project using Bazel. For example:

```bash
bazel build //...
bazel run //path/to:target
```

Replace `//path/to:target` with the appropriate Bazel target for your use case.

---

## Contributing

We welcome contributions! Please follow these steps to contribute to the project:

1. **Fork the Repository**: Fork the repository to your GitHub account.

2. **Clone Your Fork**: Clone your forked repository to your local machine.

3. **Create a Branch**: Create a new branch for your feature or bugfix:

```bash
git checkout -b feature/your-feature-name
```

4. **Make Changes**: Make your changes and ensure they adhere to the project's coding standards.

5. **Run Pre-Commit Hooks**: Before committing, run the pre-commit hooks to ensure your code is properly formatted and linted:

```bash
pre-commit run --all-files
```

6. **Commit and Push**: Commit your changes and push them to your fork:

```bash
git add .
git commit -m "Your commit message"
git push origin feature/your-feature-name
```

7. **Create a Pull Request**: Open a pull request from your fork to the main repository. Provide a clear description of your changes.

---

## License

This project is licensed under the [Apache License](https://github.com/srinidhigoud/transformer/blob/main/LICENSE). See the `LICENSE` file for details.

---

## Contact

For questions or feedback, please contact `Srinidhi Goud` at [srinidhi.goud29@gmail.com].

---