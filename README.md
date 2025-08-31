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

## Project Structure

```
├── src/                  # Put your C++ files here
│   ├── Core/            # Core code
│   │   └── Common/      # Shared utilities
│   └── main.cpp         # Start here
├── scripts/              # Build scripts
├── docs/                # How-to guides
└── build/                # Generated files (created when you build)
```

## Documentation

For setup instructions, usage guides, and detailed information, see the [docs folder](docs/):

- [01-setup.md](docs/01-setup.md) - How to install everything
- [02-usage.md](docs/02-usage.md) - How to use the template  
- [03-structure.md](docs/03-structure.md) - How the project is organized
- [04-dependencies.md](docs/04-dependencies.md) - Adding external libraries

## Contributing

Found a bug or have an idea? Feel free to submit a Pull Request or open an issue.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## What This Uses

- [Premake](https://premake.github.io/) for building
- C++23 standard for modern C++ features
