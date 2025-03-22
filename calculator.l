%{
#include <stdio.h>
#include "y.tab.h"
%}

%%

[0-9]+         { yylval = atoi(yytext); return NUMBER; }
\+             { return PLUS; }
\-             { return MINUS; }
\*             { return TIMES; }
\/             { return DIVIDE; }
\(             { return LPAREN; }
\)             { return RPAREN; }
[ \t\n]+       { /* ignore whitespaces */ }
.              { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

