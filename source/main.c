#include <string.h>
#include <stdio.h>
#include <switch.h>

int main(int argc, char **argv) {
    consoleInit(NULL);

    // Configure inputs for a standard controller
    padConfigureInput(1, HidNpadStyleSet_NpadStandard);
    PadState pad;
    padInitializeDefault(&pad);

    // Starting position for our "cursor"
    int x = 40, y = 12;

    printf("\x1b[16;20HMove the Left Stick to change colors!");
    printf("\x1b[17;20HPress PLUS to exit.");

    while(appletMainLoop()) {
        padUpdate(&pad);

        u64 kDown = padGetButtonsDown(&pad);
        if (kDown & HidNpadButton_Plus) break;

        // Read the Left Stick position
        // Values range from -32767 to 32767
        HidAnalogStickState stick_l = padGetStickPos(&pad, 0);

        // Clear the previous character at the old position
        printf("\x1b[%d;%dH ", y, x);

        // Update position based on stick movement (simple threshold)
        if (stick_l.x > 10000) x++;
        if (stick_l.x < -10000) x--;
        if (stick_l.y > 10000) y--; // Y is inverted on screen
        if (stick_l.y < -10000) y++;

        // Keep the cursor within console bounds (80x45 roughly)
        if (x < 1) x = 1; if (x > 79) x = 79;
        if (y < 1) y = 1; if (y > 44) y = 44;

        // Change color based on Stick X position 
        // ANSI Colors: 31=Red, 32=Green, 33=Yellow, 34=Blue, 35=Magenta, 36=Cyan
        int color = 31 + (x % 6); 

        // Draw the "cursor" at the new position with the new color
        // \x1b[%d;%dH sets cursor position, \x1b[%dm sets color
        printf("\x1b[%d;%dH\x1b[%dm@", y, x, color);

        consoleUpdate(NULL);
    }

    consoleExit(NULL);
    return 0;
}