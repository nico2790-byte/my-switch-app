# Root directory of devkitPro
ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO in your environment. export DEVKITPRO=<path to>/devkitpro")
endif

include $(DEVKITPRO)/libnx/switch_rules

# Target name (your app name)
TARGET := MySwitchApp
BUILD  := build
SOURCES := source

# Libraries to link
LIBS := -lnx

# Compiler flags
CFLAGS := -g -Wall -O2 -march=armv8-a+crc+crypto -mtune=cortex-a57 -mtp=soft -fPIE -I$(LIBNX)/include
LDFLAGS := -specs=$(LIBNX)/switch.specs -g -march=armv8-a+crc+crypto -mtune=cortex-a57 -Wl,-Map,$(notdir $*.map)

# Build rules
.PHONY: all clean

all: $(TARGET).nro

$(TARGET).nro: $(TARGET).elf

$(TARGET).elf: $(SOURCES)/main.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) $(LDFLAGS) $< $(LIBS) -o $@

clean:
	rm -rf $(BUILD) $(TARGET).elf $(TARGET).nro