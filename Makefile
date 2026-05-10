HLS        := vitis_hls
TCL        := run_hls.tcl
PROJECT    := video_gray_live_prj
BOARD_DIR  := selected_motion_regions/pyzq

.PHONY: all csim synth hls board init hw pfm app status clean

# Default target for this submission:
# run the root-level HLS verification flow
all: csim synth

# Run only HLS C simulation for the root-level files
csim:
	$(HLS) -f $(TCL) -tclargs csim

# Run only HLS C synthesis for the root-level files
synth:
	$(HLS) -f $(TCL) -tclargs synth

# Run both HLS C simulation and synthesis
hls:
	$(HLS) -f $(TCL) -tclargs all

# Keep the old board-level flow available, but not as the default grading path
board: init hw pfm app

init:
	git submodule update --init --recursive

hw:
	$(MAKE) -C $(BOARD_DIR)/hw all

pfm:
	$(MAKE) -C $(BOARD_DIR)/baremetal pfm

app:
	$(MAKE) -C $(BOARD_DIR)/baremetal app

status:
	git status

clean:
	if exist $(PROJECT) rmdir /s /q $(PROJECT)