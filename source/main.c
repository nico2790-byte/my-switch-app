#include <switch.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
    // Initialize the console for text output
    consoleInit(NULL);

    printf("Hello from the Cloud!\n");
    printf("This was compiled on mobile via GitHub.\n");
    printf("\nPress PLUS to exit.");

    // Main loop
    while (appletMainLoop()) {
        hidScanInput();

        // Get button presses
        u64 kDown = hidKeysDown(CONTROLLER_P1_AUTO);

        if (kDown & KEY_PLUS) break; // Break loop to return to Homebrew Menu

        consoleUpdate(NULL);
    }

    consoleExit(NULL);
    return 0;
}