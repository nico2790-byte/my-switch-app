# Paths
DEVKITPRO := /opt/devkitpro
LIBNX     := $(DEVKITPRO)/libnx
CC        := $(DEVKITPRO)/devkitA64/bin/aarch64-none-elf-gcc
ELF2NRO   := $(DEVKITPRO)/tools/bin/elf2nro

# Application Settings
TARGET    := MySwitchApp
SOURCES   := source/main.c

# Compilation Flags
CFLAGS    := -g -O2 -march=armv8-a+crc+crypto -mtune=cortex-a57 -mtp=soft -fPIE -I$(LIBNX)/include
LDFLAGS   := -specs=$(LIBNX)/switch.specs -L$(LIBNX)/lib -lnx

all: $(TARGET).nro

$(TARGET).nro: $(TARGET).elf
	$(ELF2NRO) $< $@

$(TARGET).elf: $(SOURCES)
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@

clean:
	rm -f $(TARGET).elf $(TARGET).nro