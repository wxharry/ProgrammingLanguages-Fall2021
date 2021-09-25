filename=xw2788.calc

all: build run

$(filename).tab.c $(filename).tab.h: $(filename).y
	bison -d $(filename).y

lex.yy.c: $(filename).l $(filename).tab.h
	flex $(filename).l

bin: 
	mkdir bin

build: bin lex.yy.c $(filename).tab.c $(filename).tab.h
	g++ lex.yy.c $(filename).tab.c -o bin/$(filename)

bin/$(filename): bin lex.yy.c $(filename).tab.c
	make build

xw2788.input.txt:
	touch xw2788.input.txt

cmd: xw2788.input.txt
	@mv xw2788.input.txt ../xw2788.input.txt
	make
	@mv ../xw2788.input.txt xw2788.input.txt

# run program
run: bin bin/$(filename)
	./bin/$(filename)

clean:
	@rm lex.yy.c *.tab.h *.tab.c
