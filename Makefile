
vpath %.c src

MKDIR    := mkdir -p
RM       := rm -f

AS       := nasm
ASFLAGS  := -f elf64 -Ox

CC       := gcc
CFLAGS   := -O3 -march=native -std=c17 -Wall -Wextra -Wpedantic -Wfatal-errors
CPPFLAGS := -Iinclude -D_POSIX_C_SOURCE -D_GNU_SOURCE
LDFLAGS  := 
LIBS     :=

SRCS     := $(notdir $(wildcard src/*.c)) $(notdir $(wildcard src/asm/x86-64/*.asm))
OBJS     := $(filter %.o, $(patsubst %.c,%.o,$(SRCS)) $(patsubst %.asm,%.o,$(SRCS)))

TARGET   := perl

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $^

%.o: %.asm
	$(AS) $(ASFLAGS) -o $@ $^

.PHONY: clean
clean:
	$(RM) $(OBJS) $(TARGET)
