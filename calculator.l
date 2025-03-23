%{
 #include <stdio.h>
 #include "y.tab.h"
 extern YYSTYPE yylval;
 
 int invalid_char_count = 0;  
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
.              { //invalid section  
                 printf("Invalid character: %s\n", yytext);
                 invalid_char_count++;
	       }

%%

int yywrap() {
    return 1;
}
