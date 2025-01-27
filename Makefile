CFLAGS = -ansi -pedantic-errors -Wall -g
CPPFLAGS += -MMD -MP # Generate .d makefiles
LDLIBS = -lm
SRC = demo.c arraylib.c intlib.c

OBJ = ${SRC:.c=.o}
DEP = $(OBJ:.o=.d)

# Final EXE name
# We store it a variable because we reference it multiple times
# It didn't need to be called EXE
# Other popular choices for this variable are TARGET, EXECUTABLE, and PROGRAM
EXE = demo

# Rule for building $(EXE)
#
# Since this is the first rule in the makefile, it is the default goal that
# will be executed if no target is specified when `make` is invoked.
#

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
# link all of `demo`'s prerequisites (object files) into an executable named
# `demo`.
#
# Implicit rules essentially let Make deduce recipes.
#
# It is a clever mechanism.
#
# Note that, for this implicit rule to be applied, the project needs to follow
# the convention of having a `PROG.c` file if the executable file will be
# `PROG`. That's easy enough to follow. It is a good convention.
#
# $@ is a special automatic variable in Make that represents the target
# of the current rule. In this case, it's equivalent to $(EXE).
#
# $^ s a special automatic variable that expands to the list of all
# prerequisites (dependencies) of the target. In this case, it's equivalent to
# $(OBJ).

# We don't need to specify these prerequisites for object files anymore because
# we switched to using the -MMD option to have the compiler do this work for us
# (see the .d files that are generated).

#intlib.o : intlib.c intlib.h
#arraylib.o : arraylib.c arraylib.h intlib.h
#demo.o : demo.c arraylib.h

clean:
	rm -f $(OBJ) *.d $(EXE)

# Include the .d makefiles.
# The - at the front suppresses the errors of missing Makefiles. Initially, all
# the .d files will be missing, and we don't want those errors to stop the build.
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
