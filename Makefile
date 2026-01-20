# Makefile for Dork's Dilemma C16 Game
# Alternative to PlatformIO for quick builds

# Tools
CA65 = ca65
LD65 = ld65
VICE = xplus4

# Directories
SRC_DIR = src
BUILD_DIR = build
INCLUDE_DIR = include

# Files
MAIN_SRC = $(SRC_DIR)/main.s
MAIN_OBJ = $(BUILD_DIR)/main.o
PROGRAM = dorks_dilemma.prg
LISTING = $(BUILD_DIR)/main.lst
LABELS = $(BUILD_DIR)/labels.txt
MAP = $(BUILD_DIR)/map.txt

# Flags
ASFLAGS = -t c16 -g
LDFLAGS = -t c16 -Ln $(LABELS) -m $(MAP)

# Default target
.PHONY: all
all: $(PROGRAM)

# Create build directory
$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Assemble
$(MAIN_OBJ): $(MAIN_SRC) | $(BUILD_DIR)
	@echo "Assembling $(MAIN_SRC)..."
	$(CA65) $(ASFLAGS) -l $(LISTING) -o $@ $<

# Link
$(PROGRAM): $(MAIN_OBJ)
	@echo "Linking $(PROGRAM)..."
	$(LD65) $(LDFLAGS) -o $@ $<
	@echo "Build complete: $(PROGRAM) ($$(wc -c < $(PROGRAM)) bytes)"

# Clean build artifacts
.PHONY: clean
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@rm -f $(PROGRAM)
	@echo "Clean complete"

# Run in VICE emulator
.PHONY: run
run: $(PROGRAM)
	@echo "Launching VICE emulator..."
	$(VICE) -autostart $(PROGRAM) &

# Run with monitor for debugging
.PHONY: debug
debug: $(PROGRAM)
	@echo "Launching VICE with remote monitor..."
	$(VICE) -remotemonitor -autostart $(PROGRAM) &

# Run original binary
.PHONY: run-original
run-original:
	@echo "Running original DORKSDIL.BIN..."
	$(VICE) -autostart DORKSDIL.BIN &

# View build artifacts
.PHONY: map
map: $(PROGRAM)
	@cat $(MAP)

.PHONY: labels
labels: $(PROGRAM)
	@cat $(LABELS)

.PHONY: listing
listing: $(MAIN_OBJ)
	@cat $(LISTING)

# Show help
.PHONY: help
help:
	@echo "Dork's Dilemma Build System"
	@echo ""
	@echo "Targets:"
	@echo "  all          - Build the program (default)"
	@echo "  clean        - Remove build artifacts"
	@echo "  run          - Build and run in VICE emulator"
	@echo "  debug        - Build and run with VICE monitor"
	@echo "  run-original - Run the original binary"
	@echo "  map          - Show memory map"
	@echo "  labels       - Show label definitions"
	@echo "  listing      - Show assembly listing"
	@echo "  help         - Show this help message"
	@echo ""
	@echo "Requirements:"
	@echo "  - cc65 (ca65, ld65)"
	@echo "  - VICE emulator (xplus4)"
	@echo ""
	@echo "Install on macOS:"
	@echo "  brew install cc65 vice"

# Install dependencies (macOS)
.PHONY: install-deps
install-deps:
	@echo "Installing dependencies via Homebrew..."
	@command -v brew >/dev/null 2>&1 || { echo "Homebrew not found. Install from https://brew.sh"; exit 1; }
	brew install cc65 vice
	@echo "Dependencies installed"

# Check if tools are available
.PHONY: check
check:
	@echo "Checking build tools..."
	@command -v $(CA65) >/dev/null 2>&1 && echo "✓ ca65 found" || echo "✗ ca65 not found"
	@command -v $(LD65) >/dev/null 2>&1 && echo "✓ ld65 found" || echo "✗ ld65 not found"
	@command -v $(VICE) >/dev/null 2>&1 && echo "✓ VICE found" || echo "✗ VICE not found"
