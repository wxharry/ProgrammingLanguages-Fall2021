# HW01-Q4-Extended Calculator

## Basis on Assignment
- [x] Simple arithmetic following BODMAS rules. Example: 4 * (3 + 2) = 20  
- [x] Standard functions (ceil, modulo, ﬂoor, abs)
- [x] Trigonometric functions (sin, cos, tan)
- [x] Logarithmic functions (log2, log10)
- [x] Unit conversions (currency, temperature, distance)
- [x] Memory based variable stores (create and use your own variables)
- [x] Calculator reads input from command line

## Extended Feature

- Read from file. 
  - Use `make file` to read a file as an input.
  - Use `make file inputfile=filename` to specify `filename` as an input file. Remember to put an empty line at the end of the last line a EOL character.
- Input modes switch.
  - Two mode: cmd and file are available, file mode by default.
  - Use `make cmd` or `./bin/filename -c` to switch to cmd mode.
  - Use `make file` or `./bin/filename -ftest` to swith to file mode and specify `test` as a input file. `xw2788.input.txt` by default. 



## How to Run
Simply run `make` to run this program. It will build and run and 

read `xw2788.input.txt` as input by default. 

If you want to use command line to input, use `make cmd`. 


commands `make build` `make run` `make clean` are all available. 