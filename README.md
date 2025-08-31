# C++ Console Application Template

A cross-platform C++ template project using Premake build system. This template provides a clean foundation for console applications that need to run on both Windows and Linux systems.

## Features

- **Cross-platform**: Supports Windows and Linux builds
- **Premake build system**: Easy project generation for multiple IDEs
- **Modern C++**: Uses C++23 standard with cutting-edge features
- **Debug/Release configurations**: Separate build configurations
- **Minimal template**: Clean, focused structure without unnecessary complexity

## Prerequisites

### Windows
- Visual Studio 2022 or later (Community edition is fine)
- Or Visual Studio Build Tools 2022+
- Or MinGW-w64 (GCC 13+)

### Linux
- GCC 13+ or Clang 15+
- Make
- Build essentials package

### Both Platforms
- [Premake 5](https://premake.github.io/download) - Download and add to PATH

## Project Structure

```
├── src/                  # Source files
│   ├── Core/            # Core systems
│   │   ├── Common/      # Common utilities
│   │   │   ├── Utilities.h
│   │   │   └── Utilities.cpp
│   │   └── System/      # System services
│   └── main.cpp         # Main application entry point
├── scripts/              # Build and utility scripts
│   └── premake/         # Premake build system
│       ├── config.lua   # Build configuration
│       └── deps.lua     # Simple dependency helper
├── docs/                 # Detailed documentation
│   ├── SETUP.md         # Installation and setup
│   ├── USAGE.md         # Usage and customization
│   ├── STRUCTURE.md     # Project organization
│   └── DEPENDENCIES.md  # Adding external libraries
├── build/                # Generated project files
├── build.ps1             # Windows PowerShell build script
├── build.sh              # Linux shell build script
└── README.md            # This file
```

## Quick Start

### 1. Generate Project Files
```bash
# Windows
.\build.ps1

# Linux
./build.sh
```

### 2. Build & Run
- **Visual Studio**: Open `build/CatalystConsole.sln`
  - Select platform: **x64** for 64-bit, **Win32** for 32-bit
  - Select configuration: **Debug** or **Release**
- **Command Line**: Use the generated Makefile or MSBuild
- **Executable**: Located in `build/bin/[Debug|Release]/[x64|x86]/`

## Documentation

- **[Setup Guide](docs/SETUP.md)** - Installation and first-time setup
- **[Usage Guide](docs/USAGE.md)** - How to use and customize the template
- **[Structure Guide](docs/STRUCTURE.md)** - Understanding the project organization
- **[Dependencies Guide](docs/DEPENDENCIES.md)** - Adding external libraries

## Configuration Options

### Build Configurations
- **Debug**: Includes debug symbols, no optimization
- **Release**: Optimized, no debug symbols

### Platforms
- **x64**: 64-bit builds (default)
- **x86**: 32-bit builds

### C++ Standard
- **C++23**: Latest C++ standard with modern features
  - `std::print` for formatted output
  - `std::expected` for error handling in file operations
  - Modern template features and syntax

## Customization

### Renaming Your Project
The template includes a built-in project renaming tool that automatically customizes all files for your new project:

```bash
# Windows
.\build.ps1
# Select option 4: "Rename Project (Customize Template)"

# Linux
./build.sh
# Select option 4: "Rename Project (Customize Template)"
```

**What gets renamed:**
- Project name and solution name
- Executable name
- Company/organization information
- All references in build files, README, and source code

**Example workflow:**
1. Run the build script and select "Rename Project"
2. Enter your project details (e.g., "MyGame", "ServerApp")
3. Confirm the changes
4. Your template is now customized for your project!
5. Run the build script again to generate project files

### Adding New Source Files
- **Place files** in the `src/` directory
- **Premake automatically includes** all `.cpp`, `.h`, and `.hpp` files
- **No configuration needed** - just add files and rebuild

### Adding Dependencies
- **Smart dependency helper** automatically finds libraries
- **No hardcoded paths** - works on any machine
- **Simple one-liner** to add most common libraries

**See [Dependencies Guide](docs/DEPENDENCIES.md)** for detailed examples and advanced usage.

## Need Help?

### Common Issues
- **Premake not found**: Install Premake 5 and add to PATH
- **Build errors**: Ensure your compiler supports C++23
- **Setup problems**: See [Setup Guide](docs/SETUP.md) for detailed troubleshooting

### Getting Help
- **Check the docs**: Each guide has troubleshooting sections
- **Verify prerequisites**: Make sure all tools are installed correctly
- **Check build output**: Generated project files show detailed error information

## License

This template is provided as-is for educational and development purposes.
