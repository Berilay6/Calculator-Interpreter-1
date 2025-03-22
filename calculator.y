nclude <stdio.h>
#include <stdlib.h>

// Error handling
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int yylex();
%}

//tokens
%token NUMBER
%token PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN

%%

//grammar rules
expr:
      expr PLUS expr   { $$ = $1 + $3; }
    | expr MINUS expr  { $$ = $1 - $3; }
    | expr TIMES expr  { $$ = $1 * $3; }
    | expr DIVIDE expr {
        if ($3 == 0) {
            yyerror("Divide by zero error");
            exit(1);
        } else {
            $$ = $1 / $3;
        }
      }
    | LPAREN expr RPAREN { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

%%

int main() {
    printf("Calculator Interpreter. Your calculation: \n");
    yyparse();
    return 0;
}
