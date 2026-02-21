BR_VERSION := 2025.11.1
BR_ARCHIVE := buildroot-$(BR_VERSION).tar.xz
BR_DIR := buildroot-$(BR_VERSION)
BR_URL := https://buildroot.org/downloads/$(BR_ARCHIVE)

IMAGE_SRC := $(BR_DIR)/output/images/Image
IMAGE_DST := ./Image

REF_EMU := ref_emu
BINT0H := bintoh

all: buildroot emu

$(BR_ARCHIVE):
	wget $(BR_URL)

$(BR_DIR): $(BR_ARCHIVE)
	tar xf $(BR_ARCHIVE)

setup: $(BR_DIR)
	cp -r custom_configs $(BR_DIR)/
	cp custom_configs/buildroot.config $(BR_DIR)/.config

buildroot: setup
	$(MAKE) -C $(BR_DIR)

Image: buildroot
	cp $(IMAGE_SRC) $(IMAGE_DST)

devicetree.dtb: devicetree.dts
	dtc -I dts -O dtb devicetree.dts -o devicetree.dtb

$(BINT0H): bintoh.c
	gcc -O2 -o $(BINT0H) bintoh.c

dtb_data.h: devicetree.dtb $(BINT0H)
	./$(BINT0H) dtb_data < devicetree.dtb > dtb_data.h

$(REF_EMU): ref_emu.c mini-rv32ima.h dtb_data.h
	gcc -O2 -o $(REF_EMU) ref_emu.c

emu: $(REF_EMU)

clean:
	rm -f $(BR_ARCHIVE)
	rm -f $(IMAGE_DST)
	rm -f devicetree.dtb
	rm -f dtb_data.h
	rm -f $(REF_EMU)
	rm -f $(BINT0H)

.PHONY: all setup buildroot export-image emu clean