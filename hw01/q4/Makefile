filename=xw2788.calc
inputfile=xw2788.input.txt

all: build run

$(filename).tab.c $(filename).tab.h: $(filename).y
	@bison -d $(filename).y

lex.yy.c: $(filename).l $(filename).tab.h
	@flex $(filename).l

bin: 
	mkdir bin

build: bin lex.yy.c $(filename).tab.c $(filename).tab.h
	g++ lex.yy.c $(filename).tab.c -o bin/$(filename)

bin/$(filename): bin lex.yy.c $(filename).tab.c
	make build

cmd: bin bin/$(filename)
	@./bin/$(filename) -c

file: bin bin/$(filename)
	@./bin/$(filename) -f$(inputfile)

# run program
run: file

clean:
	@rm lex.yy.c *.tab.h *.tab.c
