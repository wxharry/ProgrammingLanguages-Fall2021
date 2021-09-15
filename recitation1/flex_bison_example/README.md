# flex_bison_example

## Running the example

### calc1
```
bison -d filename.y
flex filename.l
g++ lex.yy.c filename.tab.c -o filename
./filename

# express, enter, ctrl+d
# ex: input  4+4, enter, ctrl+d
#     output 8
```

### Or you can use makefile
```
make bison
make flex
make build
make all
make run 
make clean
```
