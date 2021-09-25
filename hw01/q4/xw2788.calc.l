%{
#include <iostream>
#include <stdlib.h>
#include <cstdio>
#include "xw2788.calc.tab.h"  /* We want the tokens defined in calc2.y. */

int lineNum = 1;
%}

%option noyywrap

%%

"pi"|"PI"               { return PI;}
[0-9]+(\.[0-9])?        { yylval.val = atof(yytext); return NUMBER; }
"+"                     { return ADD; }
"-"                     { return SUB; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"^"                     { return POW; }
"%"|"mod"|"MOD"         { return MOD; }
"("                     { return L_BRACKET; }
")"                     { return R_BRACKET; }
"!"                     { return FACTORIAL; }

"sqrt"|"SQRT"           { return SQRT; }
"abs"|"ABS"             { return ABS; }
"floor"|"FLOOR"         { return FLOOR; }
"ceil"|"CEIL"           { return CEIL; }

"sin"|"SIN"             { return SIN; }
"cos"|"COS"             { return COS; }
"tan"|"TAN"             { return TAN; }

"log2"|"LOG2"           { return LOG2; }
"log10"|"LOG10"           { return LOG10; }

"gbp_to_usd"|"GBP_TO_USD"   { return GBP_TO_USD; }
"usd_to_gbp"|"USD_TO_GBP"   { return USD_TO_GBP; }
"gbp_to_euro"|"GBP_TO_EURO"   { return GBP_TO_EURO; }
"euro_to_gbp"|"EURO_TO_GBP"   { return EURO_TO_GBP; }
"usd_to_euro"|"USD_TO_EURO"   { return USD_TO_EURO; }
"euro_to_usd"|"EURO_TO_USD"   { return EURO_TO_USD; }

"cel_to_fah"|"CEL_TO_FAH"   { return CEL_TO_FAH; }
"fah_to_cel"|"FAH_TO_CEL"   { return FAH_TO_CEL; }

"mi_to_km"|"MI_TO_KM"   { return MI_TO_KM; }
"km_to_mi"|"KM_TO_MI"   { return KM_TO_MI; }

[\n]                    { ++lineNum; return EOL;}
[ \t\r]+                { /* Ignore white characters. */ }
.                       { std::printf("ERROR: Undefined symbol on lineNum %d\n", lineNum); exit(1); }

%%
