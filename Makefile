GSC = gsc
EXEC = bh
SCM_SRC_FILES = bh.scm \
		src/blackhole.scm \
		src/cli.scm \
		src/compile-load.scm \
		src/core-forms.scm \
		src/deventry.scm \
		src/expr.scm \
		src/extras.scm \
		src/help.scm \
		src/hygiene.scm \
		src/lib.scm \
		src/loaded-module.scm \
		src/loader.scm \
		src/location.scm \
		src/module-info.scm \
		src/module-macroexpansion.scm \
		src/module-reference.scm \
		src/namespace.scm \
		src/packages.scm \
		src/resolvers.scm \
		src/syntactic-tower.scm \
		src/syntax-rules.scm \
		src/tree.scm \
		src/util.scm
OBJS = bh_.o bh.o
C_SRC_FILES = bh_.c bh.c
GAMBC_LIB_DIR = $(shell gsc -e "(display (path-expand \"~~/lib\"))")

$(EXEC): $(OBJS)
	$(GSC) -exe -ld-options "$(GAMBC_LIB_DIR)/libgambcgsc.a" $(OBJS)

$(OBJS): $(C_SRC_FILES)
	$(GSC) -obj $(C_SRC_FILES)

$(C_SRC_FILES): $(SCM_SRC_FILES)
	$(GSC) -link -l "$(GAMBC_LIB_DIR)/_gambcgsc" bh.scm

clean:
	rm -f $(EXEC) $(OBJS) $(C_SRC_FILES)
