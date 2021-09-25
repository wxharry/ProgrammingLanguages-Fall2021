filename=calc1

all: build run

$(filename).tab.c $(filename).tab.h: $(filename).y
	bison -d $(filename).y

lex.yy.c: $(filename).l $(filename).tab.h
	flex $(filename).l

build: lex.yy.c $(filename).tab.c $(filename).tab.h
	g++ lex.yy.c $(filename).tab.c -o bin/$(filename)

bin: 
	mkdir bin

bin/$(filename): bin lex.yy.c $(filename).tab.c
	make build

# run program
run: bin/$(filename)
	@bin/$(filename)

clean:
	@rm lex.yy.c *.tab.h *.tab.c
