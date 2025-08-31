# Setup Guide - C++ Console Application Template

## Prerequisites

### Windows
- **Visual Studio 2022** or later (Community edition is fine)
- **OR** Visual Studio Build Tools 2022+
- **OR** MinGW-w64 (GCC 13+)

### Linux
- **GCC 13+** or **Clang 15+**
- **Make** utility
- **Build essentials** package

### Both Platforms
- **[Premake 5](https://premake.github.io/download)** - Download and add to PATH

---

## Installation Steps

### Step 1: Install Premake 5

#### Windows
1. Download from [premake.github.io/download](https://premake.github.io/download)
2. Extract `premake5.exe` to a folder (e.g., `C:\tools\premake\`)
3. Add that folder to your system PATH
4. Verify: Open PowerShell and run `premake5 --version`

#### Linux
```bash
# Ubuntu/Debian
sudo apt-get install premake5

# Or download manually
wget https://github.com/premake/premake-core/releases/download/v5.0.0-beta7/premake-5.0.0-beta7-linux.tar.gz
tar -xzf premake-5.0.0-beta7-linux.tar.gz
sudo mv premake5 /usr/local/bin/
```

### Step 2: Verify Installation
```bash
# Windows
premake5 --version

# Linux
premake5 --version
```

You should see: `Premake 5.0.0-beta7, a build script generator`

---

## Quick Start

### Option 1: Use Build Scripts (Recommended)
```bash
# Windows
.\build.ps1

# Linux
./build.sh
```

### Option 2: Manual Commands
```bash
# Generate Visual Studio project
premake5 --file=scripts/premake/config.lua vs2022

# Generate Makefile
premake5 --file=scripts/premake/config.lua gmake2

# Generate CodeBlocks project
premake5 --file=scripts/premake/config.lua codeblocks
```

---

## Building Your Project

### Windows (Visual Studio)
1. Open `build/CatalystConsole.sln`
2. Select configuration (Debug/Release) and platform (x64/Win32)
3. Build solution (Ctrl+Shift+B)

### Windows (Command Line)
```bash
# Using MSBuild
msbuild build/CatalystConsole.sln /p:Configuration=Debug /p:Platform=x64

# Using Visual Studio Build Tools
msbuild build/CatalystConsole.sln /p:Configuration=Release /p:Platform=x64
```

### Linux
```bash
# Navigate to build directory
cd build

# Build debug version (64-bit)
make config=debug platform=x64

# Build release version (64-bit)
make config=release platform=x64

# Build debug version (32-bit)
make config=debug platform=x86

# Build release version (32-bit)
make config=release platform=x86

# Clean build files
make clean
```

---

## Running Your Application

The executable will be in `build/bin/[Debug|Release]/[x64|x86]/` directory.

```bash
# Windows (64-bit)
build\bin\Debug\x64\CatalystConsole.exe

# Windows (32-bit)
build\bin\Debug\x86\CatalystConsole.exe

# Linux (64-bit)
./build/bin/Debug/x64/CatalystConsole

# Linux (32-bit)
./build/bin/Debug/x86/CatalystConsole
```

---

## Troubleshooting

### Common Issues

#### 1. "Premake5 not found"
- **Solution**: Add Premake to your PATH
- **Verify**: Run `premake5 --version` in a new terminal

#### 2. "Build errors"
- **Check**: Your compiler supports C++23
- **Windows**: Use Visual Studio 2022+ or MinGW-w64 GCC 13+
- **Linux**: Use GCC 13+ or Clang 15+

#### 3. "Permission denied" (Linux)
- **Solution**: Make build script executable
- ```bash
  chmod +x build.sh
  ```

#### 4. "Project files not generated"
- **Check**: You're running from the project root directory
- **Verify**: `scripts/premake/config.lua` exists

### Getting Help
- Check the generated project files for build errors
- Verify all prerequisites are installed correctly
- Ensure you're using the correct Premake action for your target IDE

---

## Next Steps

1. **Explore the code**: Check `src/main.cpp` to see how it works
2. **Add dependencies**: See [USAGE.md](USAGE.md) for adding libraries
3. **Customize**: Modify `scripts/premake/config.lua` for your needs
4. **Extend**: Add new source files to the `src/` directory

---

## Related Documentation

- **[USAGE.md](USAGE.md)** - How to use and customize the template
- **[STRUCTURE.md](STRUCTURE.md)** - Understanding the project organization
- **[DEPENDENCIES.md](DEPENDENCIES.md)** - Adding external libraries
