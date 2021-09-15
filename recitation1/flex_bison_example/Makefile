filename=calc1
	
# build bison file
bison: $(filename).y
	bison -d $(filename).y

# build flex file
flex: $(filename).l
	flex $(filename).l

# build executable file
build: lex.yy.c $(filename).tab.c
	g++ lex.yy.c $(filename).tab.c -o bin/$(filename)

# build executable file from bison and flex
all: $(filename).l $(filename).y 
	bison -d $(filename).y
	flex $(filename).l
	g++ lex.yy.c $(filename).tab.c -o bin/$(filename)

# run program
run: bin/$(filename)
	@bin/$(filename)

clean:
	@rm lex.yy.c *.tab.h *.tab.c
