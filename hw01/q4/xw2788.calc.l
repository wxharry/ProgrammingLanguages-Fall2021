%{
#include <iostream>
#include <stdlib.h>
#include "xw2788.calc.tab.h"  /* We want the tokens defined in calc2.y. */
%}

%option noyywrap

%%

PI|pi                   { return PI;}
[0-9]+                  { yylval.val = atoi(yytext); return NUMBER; }
"+"                     { return ADD; }
"-"                     { return SUB; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"^"                     { return POW; }
"%"                     { return MOD; }
"("                     { return L_BRACKET; }
")"                     { return R_BRACKET; }
[\n]                    { return EOL;}
[ \t\r]+                { /* Ignore white characters. */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%