#include <print>
#include <string>
#include <iostream>

int main(int argc, char* argv[])
{
    std::print("Catalyst - Console\n");
    std::print("==================\n\n");
    
    std::print("Welcome to your new C++ project!\n");
    std::print("This template provides a solid foundation for console applications.\n\n");
    
    std::print("Command line arguments: {}\n", argc - 1);
    if (argc > 1)
    {
        std::print("Arguments:\n");
        for (int i = 1; i < argc; ++i)
        {
            std::print("  [{}]: {}\n", i, argv[i]);
        }
    }
    
    std::print("\nPress Enter to continue...");
    std::cin.get();
    return 0;
}
