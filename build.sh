#!/bin/bash

echo "Catalyst - Console - Build Script"
echo "================================="

# Check if premake5 is available
if ! command -v premake5 &> /dev/null; then
    echo "ERROR: premake5 not found in PATH"
    echo "Please install Premake 5 and add it to your PATH"
    echo "Download from: https://premake.github.io/download"
    echo ""
    echo "On Ubuntu/Debian, you can also try:"
    echo "sudo apt-get install premake5"
    exit 1
fi

echo ""
echo "Available build targets:"
echo "1. Makefile (GNU Make)"
echo "2. CodeBlocks"
echo "3. Fast Build (Parallel + Optimized)"
echo "4. Rename Project (Customize Template)"
echo "5. Clean generated files"
echo ""

# Display system information for parallel builds
CPU_CORES=$(nproc 2>/dev/null || echo "2")
if [ "$CPU_CORES" -gt 1 ]; then
    OPTIMAL_JOBS=$((CPU_CORES - 1))
    # Cap at 8 for stability
    if [ "$OPTIMAL_JOBS" -gt 8 ]; then
        OPTIMAL_JOBS=8
    fi
    echo "[INFO] System Info: $CPU_CORES CPU cores detected"
    echo "[FAST] Optimal parallel jobs: $OPTIMAL_JOBS"
else
    OPTIMAL_JOBS=1
    echo "[INFO] System Info: Single core detected, using safe defaults"
fi
echo ""

read -p "Select build target (1-5): " choice

case $choice in
    1)
        echo "Select target architecture:"
        echo "1. x64 (64-bit - Recommended for modern systems)"
        echo "2. x86 (32-bit - Legacy compatibility)"
        
        read -p "Select architecture (1-2): " arch_choice
        
        case $arch_choice in
            1)
                echo "Generating Makefile (x64)..."
                premake5 --file=scripts/premake/config.lua gmake2
                echo ""
                echo "Makefile generated successfully!"
                echo "Use 'make config=debug platform=x64' or 'make config=release platform=x64' to build"
                echo ""
                echo "Build commands:"
                echo "  make config=debug platform=x64    # Build debug version (64-bit)"
                echo "  make config=release platform=x64  # Build release version (64-bit)"
                echo "  make clean                        # Clean build files"
                ;;
            2)
                echo "Generating Makefile (x86)..."
                premake5 --file=scripts/premake/config.lua gmake2
                echo ""
                echo "Makefile generated successfully!"
                echo "Use 'make config=debug platform=x86' or 'make config=release platform=x86' to build"
                echo ""
                echo "Build commands:"
                echo "  make config=debug platform=x86    # Build debug version (32-bit)"
                echo "  make config=release platform=x86  # Build release version (32-bit)"
                echo "  make clean                        # Clean build files"
                ;;
            *)
                echo "Invalid architecture choice. Using x64 (default)."
                premake5 --file=scripts/premake/config.lua gmake2
                echo ""
                echo "Makefile generated successfully!"
                echo "Use 'make config=debug platform=x64' or 'make config=release platform=x64' to build"
                echo ""
                echo "Build commands:"
                echo "  make config=debug platform=x64    # Build debug version (64-bit)"
                echo "  make config=release platform=x64  # Build release version (64-bit)"
                echo "  make clean                        # Clean build files"
                ;;
        esac
        ;;
    2)
        echo "Select target architecture:"
        echo "1. x64 (64-bit - Recommended for modern systems)"
        echo "2. x86 (32-bit - Legacy compatibility)"
        
        read -p "Select architecture (1-2): " arch_choice
        
        case $arch_choice in
            1)
                echo "Generating CodeBlocks project (x64)..."
                premake5 --file=scripts/premake/config.lua codeblocks
                echo ""
                echo "CodeBlocks project generated successfully!"
                echo "Open Catalyst - Console.cbp in CodeBlocks"
                echo "Select x64 platform for 64-bit builds"
                ;;
            2)
                echo "Generating CodeBlocks project (x86)..."
                premake5 --file=scripts/premake/config.lua codeblocks
                echo ""
                echo "CodeBlocks project generated successfully!"
                echo "Open Catalyst - Console.cbp in CodeBlocks"
                echo "Select x86 platform for 32-bit builds"
                ;;
            *)
                echo "Invalid architecture choice. Using x64 (default)."
                premake5 --file=scripts/premake/config.lua codeblocks
                echo ""
                echo "CodeBlocks project generated successfully!"
                echo "Open Catalyst - Console.cbp in CodeBlocks"
                ;;
        esac
        ;;
    3)
        echo "[FAST] Fast Build Mode - Parallel + Optimized"
        echo "Select target architecture:"
        echo "1. x64 (64-bit - Recommended for modern systems)"
        echo "2. x86 (32-bit - Legacy compatibility)"
        
        read -p "Select architecture (1-2): " arch_choice
        
        # Default to x64 if invalid choice
        if [ "$arch_choice" != "1" ] && [ "$arch_choice" != "2" ]; then
            arch_choice="1"
            echo "Invalid architecture choice. Using x64 (default)."
        fi
        
        platform="x64"
        if [ "$arch_choice" = "2" ]; then
            platform="x86"
        fi
        
        echo "Generating optimized project files for $platform..."
        
        # Generate project files first
        premake5 --file=scripts/premake/config.lua gmake2
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "Project files generated! Building with parallel optimization..."
            
            # Build with parallel optimization
            start_time=$(date +%s)
            cd build && make -j$OPTIMAL_JOBS config=release platform=$platform
            build_exit_code=$?
            end_time=$(date +%s)
            duration=$((end_time - start_time))
            cd ..
            
            if [ $build_exit_code -eq 0 ]; then
                echo ""
                echo "[OK] Build completed successfully!"
                echo "[TIME] Build time: ${duration} seconds"
                echo "[EXE] Executable: build/bin/Release/$platform/Catalyst - Console"
            else
                echo "[ERROR] Build failed!"
            fi
        else
            echo "[ERROR] Failed to generate project files!"
        fi
        ;;
    4)
        echo "[RENAME] Project Renaming Tool"
        echo "This will customize the template for your new project"
        echo ""
        
        # Get new project details
        read -p "Enter your new project name (e.g., MyGame, ServerApp): " new_project_name
        if [ -z "$new_project_name" ]; then
            echo "Project name cannot be empty. Aborting rename."
            exit 1
        fi
        
        read -p "Enter solution name (or press Enter for '$new_project_name'): " new_solution_name
        if [ -z "$new_solution_name" ]; then
            new_solution_name="$new_project_name"
        fi
        
        read -p "Enter executable name (or press Enter for '$new_project_name'): " new_executable_name
        if [ -z "$new_executable_name" ]; then
            new_executable_name="$new_project_name"
        fi
        
        read -p "Enter company/organization name (or press Enter to skip): " company_name
        
        echo ""
        echo "Renaming project with the following settings:"
        echo "  Project Name: $new_project_name"
        echo "  Solution Name: $new_solution_name"
        echo "  Executable: $new_executable_name"
        echo "  Company: $company_name"
        echo ""
        
        read -p "Proceed with renaming? (y/N): " confirm
        if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
            echo "Renaming cancelled."
            exit 0
        fi
        
        echo "Starting project rename..."
        
        # Update Premake config
        config_path="scripts/premake/config.lua"
        if [ -f "$config_path" ]; then
            sed -i "s/workspace \"Catalyst - Console\"/workspace \"$new_solution_name\"/g" "$config_path"
            sed -i "s/project \"Catalyst - Console\"/project \"$new_executable_name\"/g" "$config_path"
            
            # Add company info if provided
            if [ -n "$company_name" ]; then
                sed -i "s/-- C++ standard/-- Company: $company_name\n    -- C++ standard/g" "$config_path"
            fi
            echo "✓ Updated Premake configuration"
        fi
        
        # Update README
        readme_path="README.md"
        if [ -f "$readme_path" ]; then
            sed -i "s/Catalyst - Console/$new_project_name/g" "$readme_path"
            sed -i "s/Catalyst - Console/$new_solution_name/g" "$readme_path"
            sed -i "s/Catalyst - Console/$new_executable_name/g" "$readme_path"
            
            # Update company info
            if [ -n "$company_name" ]; then
                sed -i "s/This template is provided as-is/This project is provided by $company_name/g" "$readme_path"
            fi
            echo "✓ Updated README.md"
        fi
        
        # Update build scripts
        build_scripts=("build.ps1" "build.sh")
        for script in "${build_scripts[@]}"; do
            if [ -f "$script" ]; then
                sed -i "s/Catalyst - Console/$new_project_name/g" "$script"
                sed -i "s/Catalyst - Console/$new_solution_name/g" "$script"
                sed -i "s/Catalyst - Console/$new_executable_name/g" "$script"
                echo "✓ Updated $script"
            fi
        done
        
        # Update main.cpp
        main_path="src/main.cpp"
        if [ -f "$main_path" ]; then
            sed -i "s/Catalyst - Console/$new_project_name/g" "$main_path"
            sed -i "s/Catalyst - Console/$new_executable_name/g" "$main_path"
            echo "✓ Updated main.cpp"
        fi
        
        # Update .gitignore if it exists
        gitignore_path=".gitignore"
        if [ -f "$gitignore_path" ]; then
            sed -i "s/Catalyst - Console/$new_solution_name/g" "$gitignore_path"
            sed -i "s/Catalyst - Console/$new_executable_name/g" "$gitignore_path"
            echo "✓ Updated .gitignore"
        fi
        
        # Update documentation files
        docs_dir="docs"
        if [ -d "$docs_dir" ]; then
            find "$docs_dir" -name "*.md" -type f | while read -r doc_file; do
                sed -i "s/Catalyst - Console/$new_project_name/g" "$doc_file"
                sed -i "s/Catalyst - Console/$new_solution_name/g" "$doc_file"
                sed -i "s/Catalyst - Console/$new_executable_name/g" "$doc_file"
                echo "✓ Updated $(basename "$doc_file")"
            done
        fi
        
        echo ""
        echo "[SUCCESS] Project renamed successfully!"
        echo "Your template is now customized for: $new_project_name"
        echo ""
        echo "Next steps:"
        echo "1. Run the build script again to generate project files"
        echo "2. Start coding in the src/ directory"
        echo "3. Update documentation and add your own features"
        echo ""
        echo "Note: You may want to update the docs/ folder with project-specific information"
        ;;
    5)
        echo "Cleaning generated files..."
        # Remove entire build directory
        rm -rf build
        echo "Cleanup completed!"
        ;;
    *)
        echo "Invalid choice. Please run the script again."
        ;;
esac

echo ""
read -p "Press Enter to continue..."
