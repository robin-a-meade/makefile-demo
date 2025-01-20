CFLAGS = -ansi -pedantic-errors -Wall -g
CPPFLAGS += -MMD -MP # Generate .d makefiles
LDLIBS = -lm
SRCS = demo.c arraylib.c intlib.c

OBJS = ${SRCS:.c=.o}
DEPS = $(OBJS:.o=.d)

# Final executable name
# We store it a variable because we reference it multiple times
# It didn't need to be called EXECUTABLE
# Other popular choices for this variable are TARGET, EXE, and PROGRAM
EXECUTABLE = demo

# Rule for building $(EXECUTABLE)
#
# Since this is the first rule in the makefile, it will be executed by default
# when no target is specified when `make` is invoked.
#
# $@ is a special automatic variable in Make that represents the target
# of the current rule. In this case, it's equivalent to $(EXECUTABLE).
#
# $^ s a special automatic variable that expands to the list of all
# prerequisites (dependencies) of the target. In this case, it's equivalent to
# $(OBJ).

$(EXECUTABLE): $(OBJS)

# We don't need to specify these prerequisites anymore because we switched to
# using the -MMD option to have the compiler do this work for us (see the .d
# files that are generated).

#intlib.o : intlib.c intlib.h
#arraylib.o : arraylib.c arraylib.h intlib.h
#demo.o : demo.c arraylib.h

.PHONY: clean
clean:
	rm -f *.o *.d $(EXECUTABLE)

# Include the .d makefiles.
# The - at the front suppresses the errors of missing Makefiles. Initially, all
# the .d files will be missing, and we don't want those errors to stop the build.
-include $(DEPS)

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
# %: %.o
#        $(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@
#
# COMPILE.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
#
# LINK.o = $(CC) $(LDFLAGS) $(TARGET_ARCH)
#
