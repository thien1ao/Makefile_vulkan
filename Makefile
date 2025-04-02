VULKAN_SDK_PATH = ~/vulkansdk
CFLAGS = -std=c++17 -I. -I$(VULKAN_SDK_PATH)/include
LDFLAGS = -L$(VULKAN_SDK_PATH)/lib `pkg-config --static --libs /usr/local/lib/pkgconfig/glfw3.pc` -lvulkan

vertsrc = $(shell find ./shaders -type f -name "*.vert")
vertobj = $(patsubst %.vert, %.vert.spv, $(vertsrc))
fragsrc = $(shell find ./shaders -type f -name "*.frag")
fragobj = $(patsubst %.frag, %.frag.spv, $(fragsrc))

TARGET = ./a.out
$(TARGET): $(vertobj) $(fragobj)
$(TARGET): *.cpp  *.hpp

%.spv: %
	$(GLSLC) $< -o $@

.PHONY: test clean

test: ./a.out
	./a.out

clean:
	rm -f a.out
	rm -f *.spv
	

a.out: *.cpp *.hpp
	g++ $(CFLAGS) -o a.out *.cpp $(LDFLAGS)
 
