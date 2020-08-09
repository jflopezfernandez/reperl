
vpath %.l src
vpath %.y src
vpath %.c src
vpath %.h include

MKDIR    := mkdir -p
RM       := rm -f

DOXYGEN  := doxygen docs/Doxyfile

LEX      := flex
LEXFLAGS := --full --yylineno --verbose --perf-report --align --posix-compat --nodefault

YACC     := bison
YACCFLAGS:= --feature=all --warnings=all --color=auto --language=C --report=all --verbose -d

AS       := nasm
ASFLAGS  := -f elf64 -Ox

CC       := gcc
CFLAGS   := -O3 -march=native -std=c17 -Wall -Wextra -Wpedantic
CPPFLAGS := -Iinclude -D_POSIX_C_SOURCE -D_GNU_SOURCE
LDFLAGS  := 
LIBS     :=

LEXS     := $(notdir $(wildcard src/*.l))
SRCS     := $(notdir $(wildcard src/*.c)) $(notdir $(wildcard src/*.asm)) $(notdir $(wildcard src/*.l))
OBJS     := $(filter %.o, $(patsubst %.c,%.o,$(SRCS)) $(patsubst %.asm,%.o,$(SRCS)) $(patsubst %.l,%.o,$(SRCS)))

TARGET   := perl

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

perl.o: perl.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -c -o $@ $^

perl.c: perl.l ;
	$(LEX) $(LEXFLAGS) -o $@ $<\

#$(TARGET): lex.yy.c calc.tab.c
#	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

#lex.yy.c: tokens.l
#	$(LEX) $(LEXFLAGS) $^

#calc.tab.c: calc.y
#	$(YACC) $(YACCFLAGS) $^

# $(TARGET): $(OBJS)
# 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

# main.c: main.l
# 	$(LEX) $(LEXFLAGS) --outfile=src/$@ $^

# %.o: main.c | %.c
# 	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $^

# %.o: %.asm
# 	$(AS) $(ASFLAGS) -o $@ $^

.PHONY: docs
docs: $(TARGET) | html-docs

.PHONY: html-docs
html-docs:
	$(DOXYGEN)

.PHONY: clean
clean:
	$(RM) $(LEXS) $(patsubst %.l,%.c,$(LEXS)) $(OBJS) $(TARGET)

.PHONY: clean-docs
clean-docs:
	$(RM) -r docs/html/

.PHONY: dist-clean
dist-clean: clean-docs clean
