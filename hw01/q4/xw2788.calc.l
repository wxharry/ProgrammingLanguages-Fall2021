%{
#include <iostream>
#include <stdlib.h>
#include "xw2788.calc.tab.h"  /* We want the tokens defined in calc2.y. */
%}

%option noyywrap

%%

                        /* 'val' in 'yylval.val' is the field declared in
                           calc2.y with the %union directive. */
[0-9]+                  { yylval.val = atoi(yytext); return NUMBER; }
"+"                     { return ADD; }
"-"                     { return SUB; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { return L_BRACKET; }
")"                     { return R_BRACKET; }
[ \t\r]+                { /* Ignore white characters. */ }
[ \n]                   { return EOL;}
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%