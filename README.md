# CatalystConsole

A cross-platform C++ console application framework built with modern C++23 features and the Premake build system. Designed for developers who need a robust, efficient foundation for building console applications that work seamlessly across Windows and Linux platforms.

## What This Project Gives You

### 🚀 **Modern C++ Development Experience**
- **C++23 Standard**: Access to the latest language features like `std::print`, `std::expected`, and modern template syntax
- **Cross-Platform Compatibility**: Write once, run anywhere - no platform-specific code needed
- **Performance Optimized**: Built with modern compiler optimizations and efficient data structures

### 🛠️ **Professional Build System**
- **Premake Integration**: Generate project files for Visual Studio, VS Code, Make, and more with a single command
- **Multi-Configuration Support**: Debug and Release builds with proper symbol handling
- **Dependency Management**: Smart library detection and linking without hardcoded paths
- **IDE Agnostic**: Works with your preferred development environment

### 🏗️ **Clean, Scalable Architecture**
- **Modular Design**: Well-organized code structure that grows with your project
- **Separation of Concerns**: Clear boundaries between core systems, utilities, and application logic
- **Extensible Framework**: Easy to add new features without breaking existing code
- **Best Practices**: Follows modern C++ development patterns and conventions

### 🔧 **Developer Productivity Features**
- **Zero Configuration**: Add new source files without build system changes
- **Smart Dependencies**: Automatic library detection and linking
- **Cross-Platform Scripts**: PowerShell and Bash scripts for consistent workflow
- **Documentation**: Comprehensive guides for setup, usage, and customization

## Key Benefits for Developers

### **Time Savings**
- No need to set up cross-platform build systems from scratch
- Automatic project file generation for multiple IDEs
- Pre-configured debug and release configurations

### **Code Quality**
- Modern C++23 features for better error handling and performance
- Clean architecture patterns that scale with project size
- Consistent coding standards across the project

### **Maintenance**
- Single codebase for multiple platforms
- Easy dependency updates and management
- Well-documented structure for team collaboration

### **Flexibility**
- Works with any C++23 compatible compiler
- Easy to customize for specific project needs
- Extensible framework for additional features

## Technology Stack

- **Language**: C++23 with modern features
- **Build System**: Premake 5 for cross-platform project generation
- **Platforms**: Windows (x64/x86) and Linux (x64/x86)
- **Compilers**: Visual Studio 2022+, GCC 13+, Clang 15+
- **Scripts**: PowerShell (Windows) and Bash (Linux)

## Project Structure

```
├── src/                  # Source files
│   ├── Core/            # Core systems and utilities
│   │   ├── Common/      # Common utilities and helpers
│   │   └── System/      # System-level services
│   └── main.cpp         # Application entry point
├── scripts/              # Build and automation scripts
├── docs/                 # Comprehensive documentation
└── build/                # Generated project files
```

## Getting Started

For detailed setup and usage instructions, see our comprehensive documentation:

- **[Setup Guide](docs/SETUP.md)** - Complete installation and first-time setup
- **[Usage Guide](docs/USAGE.md)** - How to use and customize the framework
- **[Structure Guide](docs/STRUCTURE.md)** - Understanding the project organization
- **[Dependencies Guide](docs/DEPENDENCIES.md)** - Adding and managing external libraries

## Quick Commands

```bash
# Generate project files
.\build.ps1          # Windows
./build.sh           # Linux

# Build and run
# Open generated project files in your preferred IDE
```

## Contributing

Contributions are welcome! This project thrives on community input. Please feel free to submit Pull Requests or open issues for bugs and feature requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with [Premake](https://premake.github.io/) build system
- Leverages modern C++23 features for optimal performance and developer experience
