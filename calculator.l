%{
 #include <stdio.h>
 #include "y.tab.h"
 extern YYSTYPE yylval;
%}

%%

[0-9]+(\.[0-9]+)?  { yylval.val = atof(yytext); return NUMBER; } 
\+             { return PLUS; }
\-             { return MINUS; }
\*             { return TIMES; }
\/             { return DIVIDE; }
\(             { return LPAREN; }
\)             { return RPAREN; }
\*\*            { return EXPONENT; }
[ \t\r]+       { /* ignore whitespaces */ }
\n             { return 0;}
.              { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
