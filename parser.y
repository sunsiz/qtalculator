%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern YY_BUFFER_STATE yy_scan_string(const char * str);

float result = 0;
char error = 0;

void yyerror(const char* s);
%}

%union {
	float fval;
}

%token<fval> T_NUM
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT T_POW T_SQRT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE
%left T_POW T_SQRT

%type<ival> expression
%type<fval> mixed_expression

%start calculation

%%

calculation:
       | calculation line
;

line:
    mixed_expression { result = $1;}
;

mixed_expression: T_NUM                 		 { $$ = $1; }
	  | mixed_expression T_PLUS mixed_expression	 { $$ = $1 + $3; }
	  | mixed_expression T_MINUS mixed_expression	 { $$ = $1 - $3; }
	  | mixed_expression T_MULTIPLY mixed_expression { $$ = $1 * $3; }
	  | mixed_expression T_DIVIDE mixed_expression	 { $$ = $1 / $3; }
      | T_SQRT T_LEFT mixed_expression T_RIGHT	 { $$ = sqrtf($3); }
      | mixed_expression T_POW mixed_expression	 { $$ = powf($1, $3); }
      | T_LEFT mixed_expression T_RIGHT		 { $$ = $2; }
;


%%

/*float calculate(char* arg) {
    error = 0;

    yy_scan_string(arg);
    
    yyparse();
    return result;
}*/

/*int main() {
    printf("%f\n", calculate("((2+4)+2)\n"));
	return 0;
}*/

void yyerror(const char* s) {
    //fprintf(stderr, "error: %s\n", s);
    error = 1;
}
