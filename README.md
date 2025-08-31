# CatalystConsole

A C++ console application template that works on Windows and Linux. This template gives you a basic project structure with a build system already set up, so you can start writing C++ code right away instead of spending time configuring everything from scratch.

## What You Get

### **Basic C++ Project Structure**
- A `src` folder for your C++ source files
- A `main.cpp` file to start with
- Separate folders for organizing your code

### **Build System (Premake)**
- Generates project files for Visual Studio, VS Code, and other editors
- Handles both Debug and Release builds
- Works on Windows and Linux without changes

### **C++23 Setup**
- Configured to use the latest C++ standard
- Includes basic utility files to get started
- Ready to compile with modern C++ features

### **Cross-Platform Support**
- PowerShell script for Windows
- Bash script for Linux
- Same code works on both operating systems

## Why Use This Template

### **Save Time**
- No need to figure out how to set up a C++ project
- Build system is already configured
- You can focus on learning C++ instead of build tools

### **Learn Modern C++**
- Uses current C++ standards
- Shows how to organize a real project
- Includes examples of basic C++ code structure

### **Avoid Common Problems**
- No more "compiler not found" errors
- Build settings are already correct
- Works the same way on different computers

## What You Need

### **Windows**
- Visual Studio 2022 (free Community version works)
- Or MinGW-w64 compiler
- Premake 5 (download and add to PATH)

### **Linux**
- GCC 13+ or Clang 15+
- Make
- Premake 5

## Project Structure

```
├── src/                  # Put your C++ files here
│   ├── Core/            # Core code
│   │   ├── Common/      # Shared utilities
│   │   └── System/      # System code
│   └── main.cpp         # Start here
├── scripts/              # Build scripts
├── docs/                # How-to guides
└── build/                # Generated files (created when you build)
```

## How to Start

1. **Clone this repository**
2. **Run the build script**:
   - Windows: `.\build.ps1`
   - Linux: `./build.sh`
3. **Open the generated project** in your editor
4. **Start writing C++ code**

For detailed instructions, see the docs folder:
- [Setup Guide](docs/SETUP.md) - How to install everything
- [Usage Guide](docs/USAGE.md) - How to use the template
- [Structure Guide](docs/STRUCTURE.md) - How the project is organized

## Adding Your Code

- Put new `.cpp` and `.h` files in the `src` folder
- The build system automatically finds them
- No need to edit build files when adding code

## Getting Help

- Check the docs folder first
- Open a GitHub issue if something doesn't work
- Make sure you have the right tools installed

## Contributing

Found a bug or have an idea? Feel free to submit a Pull Request or open an issue.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## What This Uses

- [Premake](https://premake.github.io/) for building
- C++23 standard for modern C++ features
