CFLAGS = -std=c17 -pedantic-errors -Wall -g
CPPFLAGS += -MMD -MP # Generate .d makefiles
LDLIBS = -lm
SRC = person_database.c

OBJ = ${SRC:.c=.o}
DEP = $(OBJ:.o=.d)

EXE = person_database

$(EXE): $(OBJ)

clean:
	rm -vf $(OBJ) $(DEP) $(EXE)

-include $(DEP)

.PHONY: clean


# Discussion
# ==========
#
# gdb
# break calculate_age
# run
# backtrace
# bt
# bt full
# info locals
#
