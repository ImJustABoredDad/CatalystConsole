# Catalyst - Console - Build Script (PowerShell)
# =============================================

Write-Host "Catalyst - Console - Build Script" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Check if premake5 is available
try {
    $null = Get-Command premake5 -ErrorAction Stop
} catch {
    Write-Host "ERROR: premake5 not found in PATH" -ForegroundColor Red
    Write-Host "Please install Premake 5 and add it to your PATH" -ForegroundColor Yellow
    Write-Host "Download from: https://premake.github.io/download" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "On Windows, you can also use Chocolatey:" -ForegroundColor Yellow
    Write-Host "choco install premake5" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Available build targets:" -ForegroundColor Green
Write-Host "1. Visual Studio Solution" -ForegroundColor White
Write-Host "2. Makefile (GNU Make)" -ForegroundColor White
Write-Host "3. Fast Build (Parallel + Optimized)" -ForegroundColor White
Write-Host "4. Rename Project (Customize Template)" -ForegroundColor White
Write-Host "5. Clean generated files" -ForegroundColor White
Write-Host ""

# Display system information for parallel builds
$cpuCores = (Get-WmiObject -Class Win32_Processor).NumberOfCores
if ($cpuCores -gt 1) {
    $optimalJobs = [Math]::Min($cpuCores - 1, 8)
    Write-Host "[INFO] System Info: $cpuCores CPU cores detected" -ForegroundColor Blue
    Write-Host "[FAST] Optimal parallel jobs: $optimalJobs" -ForegroundColor Green
} else {
    $optimalJobs = 1
    Write-Host "[INFO] System Info: Single core detected, using safe defaults" -ForegroundColor Blue
}
Write-Host ""

$choice = Read-Host "Select build target (1-5)"

switch ($choice) {
    "1" {
        Write-Host "Select target architecture:" -ForegroundColor Green
        Write-Host "1. x64 (64-bit - Recommended for modern systems)" -ForegroundColor White
        Write-Host "2. x86 (32-bit - Legacy compatibility)" -ForegroundColor White
        
        $archChoice = Read-Host "Select architecture (1-2)"
        
        switch ($archChoice) {
            "1" {
                Write-Host "Generating Visual Studio Solution (x64)..." -ForegroundColor Green
                premake5 --file=scripts/premake/config.lua vs2022
                Write-Host ""
                Write-Host "Visual Studio Solution generated successfully!" -ForegroundColor Green
                Write-Host "Open CppConsoleTemplate.sln in Visual Studio 2022" -ForegroundColor White
                Write-Host "Select x64 platform for 64-bit builds" -ForegroundColor White
            }
            "2" {
                Write-Host "Generating Visual Studio Solution (x86)..." -ForegroundColor Green
                premake5 --file=scripts/premake/config.lua vs2022
                Write-Host ""
                Write-Host "Visual Studio Solution generated successfully!" -ForegroundColor Green
                Write-Host "Open CatalystConsole.sln in Visual Studio 2022" -ForegroundColor White
                Write-Host "Select x86 platform for 32-bit builds" -ForegroundColor White
            }
            default {
                Write-Host "Invalid architecture choice. Using x64 (default)." -ForegroundColor Yellow
                premake5 --file=scripts/premake/config.lua vs2022
                Write-Host ""
                Write-Host "Visual Studio Solution generated successfully!" -ForegroundColor Green
                Write-Host "Open CatalystConsole.sln in Visual Studio 2022" -ForegroundColor White
            }
        }
    }
    "2" {
        Write-Host "Select target architecture:" -ForegroundColor Green
        Write-Host "1. x64 (64-bit - Recommended for modern systems)" -ForegroundColor White
        Write-Host "2. x86 (32-bit - Legacy compatibility)" -ForegroundColor White
        
        $archChoice = Read-Host "Select architecture (1-2)"
        
        switch ($archChoice) {
            "1" {
                Write-Host "Generating Makefile (x64)..." -ForegroundColor Green
                premake5 --file=scripts/premake/config.lua gmake2
                Write-Host ""
                Write-Host "Makefile generated successfully!" -ForegroundColor Green
                Write-Host "Use 'make config=debug platform=x64' or 'make config=release platform=x64' to build" -ForegroundColor White
                Write-Host ""
                Write-Host "Build commands:" -ForegroundColor White
                Write-Host "  make config=debug platform=x64    # Build debug version (64-bit)" -ForegroundColor White
                Write-Host "  make config=release platform=x64  # Build release version (64-bit)" -ForegroundColor White
                Write-Host "  make clean                        # Clean build files" -ForegroundColor White
            }
            "2" {
                Write-Host "Generating Makefile (x86)..." -ForegroundColor Green
                premake5 --file=scripts/premake/config.lua gmake2
                Write-Host ""
                Write-Host "Makefile generated successfully!" -ForegroundColor Green
                Write-Host "Use 'make config=debug platform=x86' or 'make config=release platform=x86' to build" -ForegroundColor White
                Write-Host ""
                Write-Host "Build commands:" -ForegroundColor White
                Write-Host "  make config=debug platform=x86    # Build debug version (32-bit)" -ForegroundColor White
                Write-Host "  make config=release platform=x86  # Build release version (32-bit)" -ForegroundColor White
                Write-Host "  make clean                        # Clean build files" -ForegroundColor White
            }
            default {
                Write-Host "Invalid architecture choice. Using x64 (default)." -ForegroundColor Yellow
                premake5 --file=scripts/premake/config.lua gmake2
                Write-Host ""
                Write-Host "Makefile generated successfully!" -ForegroundColor Green
                Write-Host "Use 'make config=debug platform=x64' or 'make config=release platform=x64' to build" -ForegroundColor White
                Write-Host ""
                Write-Host "Build commands:" -ForegroundColor White
                Write-Host "  make config=debug platform=x64    # Build debug version (64-bit)" -ForegroundColor White
                Write-Host "  make config=release platform=x64  # Build release version (64-bit)" -ForegroundColor White
                Write-Host "  make clean                        # Clean build files" -ForegroundColor White
            }
        }
    }
    "3" {
        Write-Host "[FAST] Fast Build Mode - Parallel + Optimized" -ForegroundColor Green
        Write-Host "Select target architecture:" -ForegroundColor Green
        Write-Host "1. x64 (64-bit - Recommended for modern systems)" -ForegroundColor White
        Write-Host "2. x86 (32-bit - Legacy compatibility)" -ForegroundColor White
        
        $archChoice = Read-Host "Select architecture (1-2)"
        
        # Default to x64 if invalid choice
        if ($archChoice -ne "1" -and $archChoice -ne "2") {
            $archChoice = "1"
            Write-Host "Invalid architecture choice. Using x64 (default)." -ForegroundColor Yellow
        }
        
        $platform = if ($archChoice -eq "2") { "x86" } else { "x64" }
        
        Write-Host "Generating optimized project files for $platform..." -ForegroundColor Green
        
        # Generate project files first
        $result = premake5 --file=scripts/premake/config.lua gmake2
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "Project files generated! Building with parallel optimization..." -ForegroundColor Green
            
            # Build with parallel optimization
            $startTime = Get-Date
            Push-Location build
            $buildResult = make -j$optimalJobs config=release platform=$platform
            $buildExitCode = $LASTEXITCODE
            Pop-Location
            $endTime = Get-Date
            $duration = ($endTime - $startTime).TotalSeconds
            
            if ($buildExitCode -eq 0) {
                Write-Host ""
                Write-Host "[OK] Build completed successfully!" -ForegroundColor Green
                Write-Host "[TIME] Build time: $([Math]::Round($duration, 2)) seconds" -ForegroundColor Green
                Write-Host "[EXE] Executable: build\bin\Release\$platform\CatalystConsole.exe" -ForegroundColor Green
            } else {
                Write-Host "[ERROR] Build failed!" -ForegroundColor Red
            }
        } else {
            Write-Host "[ERROR] Failed to generate project files!" -ForegroundColor Red
        }
    }
    "4" {
        Write-Host "[RENAME] Project Renaming Tool" -ForegroundColor Green
        Write-Host "This will customize the template for your new project" -ForegroundColor White
        Write-Host ""
        
        # Get new project details
        $newProjectName = Read-Host "Enter your new project name (e.g., MyGame, ServerApp)"
        if ([string]::IsNullOrWhiteSpace($newProjectName)) {
            Write-Host "Project name cannot be empty. Aborting rename." -ForegroundColor Red
            exit 1
        }
        
        $newSolutionName = Read-Host "Enter solution name (or press Enter for '$newProjectName')"
        if ([string]::IsNullOrWhiteSpace($newSolutionName)) {
            $newSolutionName = $newProjectName
        }
        
        $newExecutableName = Read-Host "Enter executable name (or press Enter for '$newProjectName')"
        if ([string]::IsNullOrWhiteSpace($newExecutableName)) {
            $newExecutableName = $newProjectName
        }
        
        $companyName = Read-Host "Enter company/organization name (or press Enter to skip)"
        
        Write-Host ""
        Write-Host "Renaming project with the following settings:" -ForegroundColor Green
        Write-Host "  Project Name: $newProjectName" -ForegroundColor White
        Write-Host "  Solution Name: $newSolutionName" -ForegroundColor White
        Write-Host "  Executable: $newExecutableName" -ForegroundColor White
        Write-Host "  Company: $companyName" -ForegroundColor White
        Write-Host ""
        
        $confirm = Read-Host "Proceed with renaming? (y/N)"
        if ($confirm -ne "y" -and $confirm -ne "Y") {
            Write-Host "Renaming cancelled." -ForegroundColor Yellow
            exit 0
        }
        
        Write-Host "Starting project rename..." -ForegroundColor Green
        
        # Update Premake config
        $configPath = "scripts/premake/config.lua"
        if (Test-Path $configPath) {
            (Get-Content $configPath) | 
                ForEach-Object { 
                    $_ -replace 'workspace "CppConsoleTemplate"', "workspace `"$newSolutionName`"" `
                    -replace 'project "CppConsoleApp"', "project `"$newExecutableName`""
                } | Set-Content $configPath
            
            # Add company info if provided
            if (-not [string]::IsNullOrWhiteSpace($companyName)) {
                $content = Get-Content $configPath
                $newContent = @()
                foreach ($line in $content) {
                    if ($line -match "-- C\+\+ standard") {
                        $newContent += "-- Company: $companyName"
                    }
                    $newContent += $line
                }
                $newContent | Set-Content $configPath
            }
            Write-Host "✓ Updated Premake configuration" -ForegroundColor Green
        }
        
        # Update README
        $readmePath = "README.md"
        if (Test-Path $readmePath) {
            (Get-Content $readmePath) | 
                ForEach-Object { 
                    $_ -replace 'C\+\+ Console Application Template', $newProjectName `
                    -replace 'CppConsoleTemplate', $newSolutionName `
                    -replace 'CppConsoleApp', $newExecutableName
                } | Set-Content $readmePath
            
            # Update company info
            if (-not [string]::IsNullOrWhiteSpace($companyName)) {
                (Get-Content $readmePath) | 
                    ForEach-Object { 
                        $_ -replace 'This template is provided as-is', "This project is provided by $companyName"
                    } | Set-Content $readmePath
            }
            Write-Host "✓ Updated README.md" -ForegroundColor Green
        }
        
        # Update build scripts
        $buildScripts = @("build.ps1", "build.sh")
        foreach ($script in $buildScripts) {
            if (Test-Path $script) {
                (Get-Content $script) | 
                    ForEach-Object { 
                        $_ -replace 'C\+\+ Console Application Template', $newProjectName `
                        -replace 'CppConsoleTemplate', $newSolutionName `
                        -replace 'CppConsoleApp', $newExecutableName
                    } | Set-Content $script
                Write-Host "✓ Updated $script" -ForegroundColor Green
            }
        }
        
        # Update main.cpp
        $mainPath = "src/main.cpp"
        if (Test-Path $mainPath) {
            (Get-Content $mainPath) | 
                ForEach-Object { 
                    $_ -replace 'CppConsoleTemplate', $newProjectName `
                    -replace 'CppConsoleApp', $newExecutableName
                } | Set-Content $mainPath
            Write-Host "✓ Updated main.cpp" -ForegroundColor Green
        }
        
        # Update .gitignore if it exists
        $gitignorePath = ".gitignore"
        if (Test-Path $gitignorePath) {
            (Get-Content $gitignorePath) | 
                ForEach-Object { 
                    $_ -replace 'CppConsoleTemplate', $newSolutionName `
                    -replace 'CppConsoleApp', $newExecutableName
                } | Set-Content $gitignorePath
            Write-Host "✓ Updated .gitignore" -ForegroundColor Green
        }
        
        # Update documentation files
        $docsDir = "docs"
        if (Test-Path $docsDir) {
            Get-ChildItem -Path $docsDir -Filter "*.md" -Recurse | ForEach-Object {
                $docFile = $_.FullName
                (Get-Content $docFile) | 
                    ForEach-Object { 
                        $_ -replace 'C\+\+ Console Application Template', $newProjectName `
                        -replace 'CppConsoleTemplate', $newSolutionName `
                        -replace 'CppConsoleApp', $newExecutableName
                    } | Set-Content $docFile
                Write-Host "✓ Updated $($_.Name)" -ForegroundColor Green
            }
        }
        
        Write-Host ""
        Write-Host "[SUCCESS] Project renamed successfully!" -ForegroundColor Green
        Write-Host "Your template is now customized for: $newProjectName" -ForegroundColor White
        Write-Host ""
        Write-Host "Next steps:" -ForegroundColor White
        Write-Host "1. Run the build script again to generate project files" -ForegroundColor White
        Write-Host "2. Start coding in the src/ directory" -ForegroundColor White
        Write-Host "3. Update documentation and add your own features" -ForegroundColor White
        Write-Host ""
        Write-Host "Note: You may want to update the docs/ folder with project-specific information" -ForegroundColor White
    }
    "5" {
        Write-Host "Cleaning generated files..." -ForegroundColor Green
        # Remove entire build directory
        if (Test-Path "build") {
            Remove-Item -Recurse -Force "build"
        }
        Write-Host "Cleanup completed!" -ForegroundColor Green
    }
    default {
        Write-Host "Invalid choice. Please run the script again." -ForegroundColor Red
    }
}

Write-Host ""
Read-Host "Press Enter to continue..."
