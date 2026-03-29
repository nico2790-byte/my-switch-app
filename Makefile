# Root directory of devkitPro
DEVKITPRO := /opt/devkitpro
include $(DEVKITPRO)/libnx/switch_rules

TARGET := MySwitchApp
SOURCES := source

all: $(TARGET).nro

$(TARGET).nro: $(TARGET).elf
	$(coord)$(ELF2NRO) $< $@

$(TARGET).elf: $(SOURCES)/main.c
	$(coord)$(CC) -g -O2 -march=armv8-a+crc+crypto -mtune=cortex-a57 -mtp=soft -fPIE \
	-I$(LIBNX)/include \
	-L$(LIBNX)/lib \
	-specs=$(LIBNX)/switch.specs $< -lnx -o $@

clean:
	rm -f $(TARGET).elf $(TARGET).nro