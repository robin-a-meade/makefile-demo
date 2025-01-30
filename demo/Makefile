CFLAGS = -ansi -pedantic-errors -Wall -g
CPPFLAGS += -MMD -MP # Generate .d makefiles
LDLIBS = -lm
SRC = demo.c arraylib.c intlib.c

OBJ = ${SRC:.c=.o}
DEP = $(OBJ:.o=.d)

# The name of the executable file that we are making
# We store it a variable because we reference it multiple times
# It didn't need to be called EXE
# Other popular choices for this variable are NAME, TARGET, EXECUTABLE, and PROGRAM
EXE = demo

# Rule for building $(EXE)
#
# Since this is the first rule in the makefile, it is the default goal that
# will be executed if no target is specified when `make` is invoked
# (assuming the .DEFAULT_GOAL special variable was not set.)

$(EXE): $(OBJ)

# You'll notice that there is no recipe specified.
# We are specifying here only the prerequisites.
# How then does Make know how to build the target?
#
# There exists this built-in implicit rule:
#
# %: %.o
#        $(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@
#
# From this implicit rule, Make is able to deduce that when it encounters a
# target like `demo` with `demo.o` as one of its dependencies, that it needs to
# link all of `demo`'s prerequisites (all the object files) into an executable
# named `demo`.
#
# $^  Expands to the names of all the prerequisites
# $@  Expands to the file name of the target of the rule
#
# Implicit rules essentially let Make deduce recipes.
#
# It is a clever mechanism.
#
# Note that, for this implicit rule to be applied, the project needs to follow
# the convention that a c project that builds an executable named `prog` should
# have a source file named `prog.c`.
#
# After the expansions, we end up with:
#
#     demo: demo.o intlib.o arraylib.o
#
#     demo: demo.o
#             gcc -ansi -pedantic-errors -Wall -g demo.o intlib.o arraylib.o -lm -o demo
#
# The demo target is listed twice. That's OK, as long as only one of the rules
# has a recipe. When a target is listed multiple times, the prerequisites
# of those rules accumulate.
#
# In our case, the result is:
#
#     demo: demo.o demo.o intlib.o arraylib.o
#             gcc -ansi -pedantic-errors -Wall -g demo.o intlib.o arraylib.o -lm -o demo
#
# You'll see that in the output of `make -p`. (The variables won't be expanded, though.)
#
# Notice that `demo.o` is listed twice. The prerequisites accumulated. It might
# seem strange to have a prerequisite listed multiple times, but it makes no
# difference to the operation of make.

# We don't need to specify the prerequisites for object files anymore because
# we switched to using the -MMD option to have the compiler do this work for us
# (see the .d files that are generated). We comment them out:

#intlib.o : intlib.c intlib.h
#arraylib.o : arraylib.c arraylib.h intlib.h
#demo.o : demo.c arraylib.h

# NOTES:
# - I changed *.d to $(DEP) because I'm not a fan of globs in Makefiles because
#   they are imprecise and they resolve to the pattern if no much (unless you
#   set the nullglob shell option).
# - I added the leading hyphen to not report an error about a missing file when
#   cleaning; this could also be handled by adding the `-f` option to `rm`. I'm
#   not sure which method of suppressing error I like better
# - Update: I decided to use `-v` and `-f` options. The `-f` option suppresses
#   error messages about non-existent files. The `-v` option prints which files
#   are deleted. That helps me be confident that the `clean` target is working
#   correctly.
clean:
	rm -vf $(OBJ) $(DEP) $(EXE)

# Include the .d Makefiles.
# The - at the front suppresses the errors of missing Makefiles. Initially, all
# the .d Makefiles will be missing, and we don't want those errors to stop the
# build. The -MMD -MP options we set in CPPFLAGS instruct the gcc compiler to
# generate the .d Makefiles when the .c files are compiled.
-include $(DEP)

# NOTES
# =====
#
# In this Makefile, we tried to make maximum use of make's default variable
# definitions and rules.
#
# Execute `make -p` in an empty directory to see make's default variable
# definitions and rules
#
# For example, we are relying on this default rule:
#
#     CC = cc
#
# This means, the c compiler will be the `cc` program that is found on your PATH.
#
# Other default variables and rules that we depend on are:
#
# %.o: %.c
#        $(COMPILE.c) $(OUTPUT_OPTION) $<
#
# COMPILE.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
#
# LINK.o = $(CC) $(LDFLAGS) $(TARGET_ARCH)

# Create a .tar.gz archive
# =========================
#
# Typically, each `.c` file will have a corresponding `.h` file
# Exception: the `.c` file for the EXE will not have a corresponding `.h` file
HDR = $(filter-out $(EXE).h, $(SRC:.c=.h))
# Or, you could KISS and list each .h file

VERSION = 0.0.2
archive:
	@if [ -f "source_files_$(VERSION).tar.gz" ]; then \
	    echo "Error: Archive file source_files_$(VERSION).tar.gz already exists."; \
	    echo "Please update the VERSION variable in the Makefile."; \
	    exit 1; \
	fi
	tar -czvf source_files_$(VERSION).tar.gz $(SRC) $(HDR)

.PHONY: all clean archive
