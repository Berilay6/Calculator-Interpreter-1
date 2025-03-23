%{
 #include <stdio.h>
 #include "y.tab.h"
 extern int yylval;
%}

%%

[0-9]+         { yylval = atoi(yytext); return NUMBER; }
\+             { return PLUS; }
\-             { return MINUS; }
\*             { return TIMES; }
\/             { return DIVIDE; }
\(             { return LPAREN; }
\)             { return RPAREN; }
[ \t\r]+       { /* ignore whitespaces */ }
\n             { return 0;}
.              { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

