# Makefile for Assignment 3 - Global Illumination
# Works on macOS, Linux, and Windows

# Detect operating system
UNAME_S := $(shell uname -s 2>/dev/null || echo "Unknown")

# Set platform-specific flags
ifeq ($(UNAME_S),Darwin)
	# macOS
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
	# Windows
	CXXFLAGS = 
	LDFLAGS = 
	LIBS = -lfreeimage -lglfw3 -lglew32 -lopengl32 -lm
endif

# Common source files
COMMON_SOURCES = Shaders.cpp tiny_obj_loader.cc texture.cpp
COMMON_OBJECTS = $(COMMON_SOURCES:.cpp=.o)
COMMON_OBJECTS := $(COMMON_OBJECTS:.cc=.o)

# Targets
all: example12 example12_irradiance

# Main viewer (for Part 1 and Part 3)
example12: viewer.o $(COMMON_OBJECTS)
	$(CXX) -o $@ $^ $(LDFLAGS) $(LIBS)

# Irradiance viewer (for Part 2)
example12_irradiance: viewer_irradiance.o $(COMMON_OBJECTS)
	$(CXX) -o $@ $^ $(LDFLAGS) $(LIBS)

# Compile object files
%.o: %.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

%.o: %.cc
	$(CXX) -c $(CXXFLAGS) -o $@ $<

# Dependencies
viewer.o: Shaders.h
viewer_irradiance.o: Shaders.h
Shaders.o: Shaders.h
texture.o: texture.h

clean:
	rm -f example12 example12_irradiance *.o

.PHONY: all clean
