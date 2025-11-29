# Portable Makefile for Assignment 3
# Works on macOS, Linux, and potentially Windows (with adjustments)

TARGET=example12

# Detect operating system
UNAME_S := $(shell uname -s 2>/dev/null || echo "Unknown")

# Set platform-specific flags
ifeq ($(UNAME_S),Darwin)
	# macOS - Try to find libraries
	BREW_PREFIX := $(shell brew --prefix 2>/dev/null || echo "/usr/local")
	CXXFLAGS = -I$(BREW_PREFIX)/include -I/usr/local/include -I/opt/homebrew/include
	LDFLAGS = -L$(BREW_PREFIX)/lib -L/usr/local/lib -L/opt/homebrew/lib
	LIBS = -lfreeimage -lglfw -lGLEW -framework OpenGL -framework GLUT -lm
else ifeq ($(UNAME_S),Linux)
	# Linux
	CXXFLAGS = $(shell pkg-config --cflags glfw3 2>/dev/null || echo "-I/usr/include")
	LDFLAGS = $(shell pkg-config --libs-only-L glfw3 2>/dev/null || echo "")
	LIBS = -lfreeimage $(shell pkg-config --libs glfw3 2>/dev/null || echo "-lglfw") -lGLEW -lGLU -lGL -lm
else
	# Default/Windows (adjust as needed)
	CXXFLAGS = 
	LDFLAGS = 
	LIBS = -lfreeimage -lglfw3 -lglew32 -lopengl32 -lm
endif

# Source files
SOURCES = viewer.cpp Shaders.cpp tiny_obj_loader.cc texture.cpp
OBJECTS = $(SOURCES:.cpp=.o)
OBJECTS := $(OBJECTS:.cc=.o)

# Default target with dependency check
$(TARGET): check-deps $(OBJECTS)
	@echo "Linking..."
	$(CXX) -o $(TARGET) $(OBJECTS) $(LDFLAGS) $(LIBS)
	@echo ""
	@echo "✅ Build successful! Run with: ./example12 a b"

# Check dependencies before building
check-deps:
	@echo "Checking dependencies..."
	@if [ "$(UNAME_S)" = "Darwin" ]; then \
		BREW_PREFIX=$$(brew --prefix 2>/dev/null || echo "/usr/local"); \
		if [ ! -f "$$BREW_PREFIX/include/GLFW/glfw3.h" ] && [ ! -f "/opt/homebrew/include/GLFW/glfw3.h" ] && [ ! -f "/usr/local/include/GLFW/glfw3.h" ]; then \
			echo ""; \
			echo "❌ ERROR: GLFW not found!"; \
			echo ""; \
			echo "Install dependencies with:"; \
			echo "  brew install freeimage glfw glew"; \
			echo ""; \
			echo "Or check if installed: ./check_dependencies.sh"; \
			echo ""; \
			exit 1; \
		fi; \
	fi

# Compile object files
%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

%.o: %.cc
	$(CXX) -c $(CXXFLAGS) -o $@ $<

# Dependencies
viewer.o: Shaders.h
Shaders.o: Shaders.h
texture.o: texture.h

clean:
	rm -f $(TARGET) $(OBJECTS)

.PHONY: clean check-deps
