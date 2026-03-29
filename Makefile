# Root directory of devkitPro inside the GitHub Container
DEVKITPRO := /opt/devkitpro
DEVKITARM := $(DEVKITPRO)/devkitARM
DEVKITPPC := $(DEVKITPRO)/devkitPPC

include $(DEVKITPRO)/libnx/switch_rules

TARGET := MySwitchApp
SOURCES := source

# Compile everything in the source folder
all: $(TARGET).nro

$(TARGET).nro: $(TARGET).elf
	$(coord)$(ELF2NRO) $< $@

$(TARGET).elf: $(SOURCES)/main.c
	$(coord)$(CC) -g -O2 -march=armv8-a+crc+crypto -mtune=cortex-a57 -mtp=soft -fPIE -I$(LIBNX)/include -specs=$(LIBNX)/switch.specs $< -lnx -o $@

clean:
	$(coord)rm -f $(TARGET).elf $(TARGET).nro