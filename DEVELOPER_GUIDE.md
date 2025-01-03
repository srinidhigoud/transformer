# Developer Guide

This guide provides instructions for managing dependencies, creating new `BUILD` files, and defining binary targets with dependencies in the Transformer project.

---

## Table of Contents

1. [Managing Dependencies](#managing-dependencies)
2. [Creating New `BUILD` Files](#creating-new-build-files)
3. [Defining Binary Targets with Dependencies](#defining-binary-targets-with-dependencies)
4. [Example: `run_pruning` Target](#example-run_pruning-target)

---

## Managing Dependencies

Dependencies for this project are managed using `pip` and Bazel. The dependencies are listed in the `requirements/` directory.

### Steps to Add or Update Dependencies:

1. Add or update the dependency in `requirements/requirements.in`.
2. Run the `update_requirements.sh` script to update the locked dependencies:
    ```bash
    bash scripts/update_requirements.sh
    ```

This script will:

- Create a virtual environment (if it doesn't exist).
- Install or upgrade pip-tools and other required tools.
- Update the requirements_lock.txt file with the latest versions of the dependencies.

---

## Creating New BUILD Files

`BUILD` files are used to define Bazel targets for your Python code. Each directory containing Python code should have a BUILD file.

Steps to Create a New `BUILD` File:
1. Navigate to the directory where you want to create the `BUILD` file.
2. Create a new `BUILD` file:
    ```bash
    touch BUILD
    ```
3. Define the targets in the `BUILD` file (see the next section for details).

---

## Defining Binary Targets with Dependencies

To define a binary target with dependencies, use the py_binary rule in the `BUILD` file. Dependencies can be specified using the requirement function from the pip repository.

Example `BUILD` File:
```bash
load("@pip//:requirements.bzl", "requirement")

py_binary(
    name = "run_pruning",
    srcs = ["run_pruning.py"],
    deps = [
        requirement("torch"),
        requirement("numpy"),
    ],
)
```

Explanation:
- `name`: The name of the target. This will be used to build or run the target.
- `srcs`: The source files for the target.
- `deps`: The dependencies for the target. Use `requirement("package_name")` to include Python packages from `pip`.

--- 

## Example: `run_pruning` Target

The `run_pruning` target is defined in the `optimizations/pruning/BUILD` file. It depends on `torch` and `numpy`.

Steps to Build and Run the Target:
1. Build the target:
```bash
bazel build //optimizations/pruning:run_pruning
```
2. Run the target:
```bash
bazel run //optimizations/pruning:run_pruning
```

---

## Additional Resources

- [Bazel Documentation](https://bazel.build/docs)
- [Python Rules for Bazel](https://github.com/bazelbuild/rules_python)

---

## Contact

For questions or feedback, please contact `Srinidhi Goud` at [srinidhi.goud29@gmail.com].

---