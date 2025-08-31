# Project Structure Guide - C++ Console Application Template

## Directory Overview

```
C++ Console Application Template/
├── src/                           # Your source code goes here
│   ├── Core/                     # Core systems and utilities
│   │   ├── Common/              # Common utilities and helpers
│   │   │   ├── Utilities.h      # Utility function declarations
│   │   │   └── Utilities.cpp    # Utility function implementations
│   │   └── System/              # System-level services (ready for you)
│   └── main.cpp                 # Application entry point
├── scripts/                       # Build system and utilities
│   └── premake/                  # Premake build system
│       ├── config.lua            # Build configuration
│       └── deps.lua              # Dependency management helper
├── build/                         # Generated project files (auto-created)
├── build.ps1                      # Windows PowerShell build script
├── build.sh                       # Linux shell build script
├── docs/                          # This documentation
└── README.md                      # Project overview and features
```

---

## Source Code Organization (`src/`)

### Core Principles
- **Co-located headers and sources** - Keep `.h` and `.cpp` files together
- **Logical grouping** - Organize by functionality, not file type
- **Scalable structure** - Easy to add new modules and systems

### Directory Structure Explained

#### `src/Core/` - Foundation Systems
This is where your core application logic lives:

```
src/Core/
├── Common/              # Shared utilities used everywhere
│   ├── Utilities.h      # File I/O, string helpers, common functions
│   └── Utilities.cpp    # Implementation of utility functions
└── System/              # System-level services (currently empty)
    ├── Network.h        # Network functionality (when you add it)
    ├── Database.h       # Database connections (when you add it)
    └── Config.h         # Configuration management (when you add it)
```

#### `src/main.cpp` - Application Entry Point
- **Single entry point** for your application
- **Command line argument handling** already implemented
- **Clean, minimal structure** ready for your code

### Adding New Modules

#### Example: Adding a Network Module
```bash
# Create new module directory
mkdir src/Core/Network

# Add header and source files
touch src/Core/Network/NetworkManager.h
touch src/Core/Network/NetworkManager.cpp
```

#### Example: Adding a Game-Specific Module
```bash
# Create game module
mkdir src/Game
mkdir src/Game/Player
mkdir src/Game/World

# Add game-specific files
touch src/Game/Player/Player.h
touch src/Game/Player/Player.cpp
touch src/Game/World/World.h
touch src/Game/World/World.cpp
```

---

## Build System Organization (`scripts/premake/`)

### Why This Structure?
- **Separation of concerns** - Build system separate from source code
- **Easy maintenance** - All build-related files in one place
- **Professional appearance** - Looks like enterprise projects

### Files Explained

#### `config.lua` - Build Configuration
- **Project settings** - C++ standard, platforms, configurations
- **Compiler flags** - Warnings, optimizations, defines
- **Platform-specific** - Windows vs Linux settings
- **Dependency examples** - Commented examples for adding libraries

#### `deps.lua` - Dependency Helper
- **Smart library detection** - Automatically finds common library locations
- **Cross-platform** - Works on Windows and Linux
- **Simple API** - One function call to add a library
- **No hardcoded paths** - Environment-friendly

---

## Generated Files (`build/`)

### What Gets Generated
```
build/
├── CatalystConsole.sln        # Visual Studio solution
├── CatalystConsole.vcxproj         # Visual Studio project
├── CatalystConsole.vcxproj.filters # VS file organization
├── Makefile                      # GNU Make build file
├── CatalystConsole.make           # Make configuration
├── bin/                          # Executable output
│   ├── Debug/
│   │   ├── x64/
│   │   │   └── CatalystConsole.exe # 64-bit debug executable
│   │   └── x86/
│   │       └── CatalystConsole.exe # 32-bit debug executable
│   └── Release/
│       ├── x64/
│       │   └── CatalystConsole.exe # 64-bit release executable
│       └── x86/
│           └── CatalystConsole.exe # 32-bit release executable
└── obj/                          # Object files and intermediates
    ├── Debug/
    │   ├── x64/
    └── Release/
        ├── x64/
        └── x86/
```

**Note**: Visual Studio uses `Win32` for 32-bit builds, while the output directories use `x86`.

### Why This Structure?
- **IDE integration** - Works with Visual Studio, CodeBlocks, etc.
- **Command line builds** - Makefiles for CI/CD and automation
- **Clean separation** - Source, build, and output clearly separated
- **Professional output** - Industry-standard build organization
- **Multi-platform support** - Separate builds for 32-bit and 64-bit architectures

### Platform Selection
- **x64 (64-bit)**: Modern systems, better performance, larger memory address space
- **x86 (32-bit)**: Legacy compatibility, smaller executable size, wider device support

---

## Build Scripts (Root Level)

### Why in Root?
- **Easy access** - Users don't need to navigate into subdirectories
- **Standard location** - Where users expect build scripts
- **Cross-platform** - PowerShell for Windows, Bash for Linux

### Script Functions
- **Project generation** - Creates IDE projects and Makefiles
- **Build management** - Handles different build targets
- **Cleanup** - Removes generated files
- **Error handling** - Checks prerequisites and provides helpful messages

---

## Documentation Organization (`docs/`)

### Documentation Structure
```
docs/
├── SETUP.md           # Installation and setup instructions
├── USAGE.md           # How to use and customize the template
├── STRUCTURE.md       # This file - understanding the organization
└── DEPENDENCIES.md    # Adding external libraries
```

### Why Separate Documentation?
- **README stays focused** - Quick overview and features
- **Detailed guides** - Step-by-step instructions for specific tasks
- **Easy navigation** - Users can find exactly what they need
- **Maintainable** - Each topic has its own file

---

## Best Practices for Your Code

### File Organization
1. **Group by functionality** - Not by file type
2. **Keep related files together** - Header and source in same directory
3. **Use descriptive names** - Clear, meaningful file and directory names
4. **Follow existing patterns** - Maintain consistency with the template

### Adding New Features
1. **Create appropriate directories** - Group related functionality
2. **Add to existing modules** - Extend Core/Common or Core/System
3. **Create new modules** - For major new features
4. **Update build configuration** - If adding dependencies

### Example: Adding a Web Server
```bash
# Create web server module
mkdir src/Core/Web
mkdir src/Core/Web/HTTP
mkdir src/Core/Web/WebSocket

# Add files
touch src/Core/Web/WebServer.h
touch src/Core/Web/WebServer.cpp
touch src/Core/Web/HTTP/HttpRequest.h
touch src/Core/Web/HTTP/HttpRequest.cpp
```

---

## Related Documentation

- **[SETUP.md](SETUP.md)** - Installation and setup instructions
- **[USAGE.md](USAGE.md)** - How to use and customize the template
- **[DEPENDENCIES.md](DEPENDENCIES.md)** - Adding external libraries
