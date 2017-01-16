%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "parser.h"

%}

%%

[ \t\n]	;
[0-9]+\.[0-9]+ 	{yylval.fval = atof(yytext); return T_NUM;}
[0-9]+		{yylval.fval = atof(yytext); return T_NUM;}
"+"		{return T_PLUS;}
"-"		{return T_MINUS;}
"*"		{return T_MULTIPLY;}
"/"		{return T_DIVIDE;}
"("		{return T_LEFT;}
")"		{return T_RIGHT;}

%%
