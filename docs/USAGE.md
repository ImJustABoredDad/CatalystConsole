# Usage Guide - C++ Console Application Template

## Getting Started

### First Time Setup
1. **Install prerequisites** (see [SETUP.md](SETUP.md))
2. **Generate project files**: Run `.\build.ps1` (Windows) or `./build.sh` (Linux)
3. **Start coding** in the `src/` directory

### Daily Workflow
```bash
# 1. Generate/update project files
.\build.ps1

# 2. Build your project (in Visual Studio or command line)
# 3. Run and test
# 4. Repeat!
```

---

## Adding New Source Files

### Simple Addition
1. **Create your files** in the `src/` directory
2. **Premake automatically includes** all `.cpp`, `.h`, and `.hpp` files
3. **No configuration needed** - just add files and rebuild

### Example Structure
```
src/
├── Core/
│   ├── Common/
│   │   ├── Utilities.h          # Header file
│   │   └── Utilities.cpp        # Implementation
│   └── System/
│       ├── Network.h            # New header
│       └── Network.cpp          # New implementation
├── main.cpp
└── YourNewClass.h               # New header
```

### Best Practices
- **Co-locate headers and sources** in the same directory
- **Use descriptive names** for your classes and files
- **Follow the existing structure** for consistency

---

## Customizing the Build

### Modify Build Configuration
Edit `scripts/premake/config.lua` to customize:

#### Add New Build Configurations
```lua
configurations { "Debug", "Release", "Profile" }

-- Add Profile configuration
filter "configurations:Profile"
    defines { "PROFILE" }
    symbols "On"
    optimize "On"
```

#### Add New Platforms
```lua
platforms { "x64", "x86" }

-- Add x86-specific settings
filter "platforms:x86"
    defines { "X86" }
```

#### Custom Compiler Flags
```lua
-- Add custom flags for all configurations
filter {}
    flags { "MultiProcessorCompile", "FatalWarnings" }

-- Add flags for specific configurations
filter "configurations:Debug"
    flags { "ExtraWarnings" }
```

---

## Adding Dependencies

### Using the Dependency Helper

#### Basic Library (Auto-detection)
```lua
-- In scripts/premake/config.lua, uncomment and modify:
deps.add_library("boost", { name = "boost_system" })
```

#### Header-Only Library
```lua
deps.add_header_only("json", { "C:/json/include", "/usr/include/json" })
```

#### Custom Paths
```lua
deps.add_library("mysql", {
    name = "mysqlclient",
    find_paths = { "C:/mysql/include", "/usr/include/mysql" },
    lib_paths = { "C:/mysql/lib", "/usr/lib" }
})
```

#### Conditional Dependencies
```lua
-- Only add MySQL if environment variable is set
if os.getenv("NEED_MYSQL") then
    deps.add_library("mysql", { name = "mysqlclient" })
end
```

### Manual Dependency Addition
If you prefer manual control:

```lua
-- Add include directories
includedirs { 
    "src",
    "C:/external/include",
    "/usr/local/include"
}

-- Add library directories
libdirs { 
    "C:/external/lib",
    "/usr/local/lib"
}

-- Link libraries
links { "external_lib", "another_lib" }
```

---

## Customizing the Application

### Modify Main Entry Point
Edit `src/main.cpp` to change your application:

```cpp
#include <print>
#include <string>
#include <iostream>

int main(int argc, char* argv[])
{
    std::print("My Custom Application\n");
    std::print("=====================\n\n");
    
    // Your custom logic here
    std::print("Hello from my app!\n");
    
    std::print("\nPress Enter to continue...");
    std::cin.get();
    return 0;
}
```

### Add New Classes
Create new header and source files:

```cpp
// src/Core/System/MyClass.h
#pragma once
#include <string>

class MyClass {
public:
    MyClass(const std::string& name);
    void DoSomething();
    
private:
    std::string m_name;
};
```

```cpp
// src/Core/System/MyClass.cpp
#include "MyClass.h"
#include <print>

MyClass::MyClass(const std::string& name) : m_name(name) {}

void MyClass::DoSomething() {
    std::print("MyClass {} is doing something!\n", m_name);
}
```

---

## Build and Development Workflow

### Development Cycle
1. **Write code** in `src/` directory
2. **Generate project files** (if structure changed): `.\build.ps1`
3. **Build project** in your IDE or command line
4. **Test and debug**
5. **Repeat**

### When to Regenerate Project Files
- **Adding new source files** - Usually not needed
- **Changing build configuration** - Always needed
- **Adding dependencies** - Always needed
- **Modifying project structure** - Always needed

### Platform Selection Guide
- **Use x64 (64-bit)** when:
  - Targeting modern systems (Windows 7+, Linux with 64-bit kernel)
  - Need larger memory address space (>4GB)
  - Want better performance on 64-bit processors
  - Building for production servers or modern desktops

- **Use x86 (32-bit)** when:
  - Need compatibility with older systems
  - Targeting embedded devices or legacy hardware
  - Want smaller executable size
  - Building for systems with limited resources

**Note**: In Visual Studio, select **Win32** platform for 32-bit builds, but the output directories will be named `x86`.

---

## Parallel Build Optimization

### Smart Core Detection
The template automatically detects your CPU cores and optimizes build performance:

- **Multi-core systems**: Uses `cores - 1` for stability (capped at 8)
- **Single-core systems**: Falls back to safe single-threaded builds
- **Cross-platform**: Works on both Windows and Linux

### Performance Benefits
```
Sequential Build:    File1 → File2 → File3 → File4  (10 seconds)
Parallel Build:      File1 ┐
                          ├─ All compile simultaneously
                          ├─ (3-5x faster!)
                          ┘
```

### Using Fast Build Mode
```bash
# Windows
.\build.ps1
# Select option 3: "Fast Build (Parallel + Optimized)"

# Linux  
./build.sh
# Select option 3: "Fast Build (Parallel + Optimized)"
```

### Manual Parallel Commands
```bash
# Windows (MSBuild)
msbuild /m /p:Configuration=Release /p:Platform=x64

# Linux (Make)
make -j$(nproc) config=release platform=x64
```

### Build Commands Reference

#### Windows
```bash
# Generate VS project
premake5 --file=scripts/premake/config.lua vs2022

# Build with MSBuild (64-bit)
msbuild build/CatalystConsole.sln /p:Configuration=Debug /p:Platform=x64

# Build with MSBuild (32-bit)
msbuild build/CatalystConsole.sln /p:Configuration=Release /p:Platform=Win32

# Fast parallel build (Release x64)
msbuild build/CatalystConsole.sln /m /p:Configuration=Release /p:Platform=x64

# Clean
Remove-Item "build" -Recurse -Force
```

#### Linux
```bash
# Generate Makefile
premake5 --file=scripts/premake/config.lua gmake2

# Build (64-bit)
cd build && make config=debug platform=x64

# Build (32-bit)
cd build && make config=release platform=x86

# Fast parallel build (Release x64)
cd build && make -j$(nproc) config=release platform=x64

# Clean
rm -rf build
```

---

## Advanced Customization

### Environment-Specific Settings
```lua
-- Different settings for different environments
if os.getenv("CI_BUILD") then
    defines { "CI_BUILD", "NO_DEBUG" }
    symbols "Off"
else
    symbols "On"
end
```

### Platform-Specific Code
```cpp
#ifdef _WIN32
    // Windows-specific code
    #include <windows.h>
#else
    // Linux/Unix-specific code
    #include <unistd.h>
#endif
```

### Custom Build Actions
```lua
-- Add custom build steps
filter "configurations:Release"
    postbuildcommands {
        "echo Building release version...",
        "copy \"%{cfg.buildtarget.abspath}\" \"release_output/\""
    }
```

---

## Related Documentation

- **[SETUP.md](SETUP.md)** - Installation and setup instructions
- **[STRUCTURE.md](STRUCTURE.md)** - Understanding the project organization
- **[DEPENDENCIES.md](DEPENDENCIES.md)** - Detailed dependency management
