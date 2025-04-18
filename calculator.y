%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Error handling
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

// invalid characters in lex file
extern int invalid_char_count;

int yylex();
%}

// Define YYSTYPE as a union
%union {
    float val;
}

//tokens
%token <val> NUMBER 
%token PLUS MINUS TIMES DIVIDE EXPONENT
%token LPAREN RPAREN

//associativity for solving ambiguity
%left PLUS MINUS
%left TIMES DIVIDE
%left EXPONENT
%left LPAREN RPAREN

// define expression type
%type <val> expr


//grammar rules
%%
ArithmeticExpression: expr{ 
	// invalid character error
    if (invalid_char_count > 0) {
        yyerror("Invalid characters in input");
        exit(1);
    }
   
    printf("\nResult=%.2f\n", $1); 
    return 0; 
  }; 

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
    | expr EXPONENT expr { $$ = pow($1, $3); } //exponential support
    | LPAREN expr RPAREN { $$ = $2; }
    | NUMBER { $$ = $1; }
    ;

%%

int main() {
    printf("Calculator Interpreter. Enter any Arithmetic Expression: \n");
    yyparse();
    return 0;
}
