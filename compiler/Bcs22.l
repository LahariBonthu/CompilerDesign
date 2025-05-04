%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>  
%}

%option noyywrap

letter [a-zA-Z]
digit [0-9]
id {letter}({letter}|{digit})*
num {digit}+

%%
"int"       { return INT; }
"bool"      { return BOOL; }
"BcsMain"   { return BCSMAIN; }
"if"        { return IF; }
"else"      { return ELSE; }
"while"     { return WHILE; }
"="         { return ASSIGN; }
"+"         { return PLUS; }
"*"         { return MULT; }
"<"|"<="|">"|">="|"=="|"!=" { return RELOP; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
";"         { return SEMICOLON; }

{id}        { yylval.str = strdup(yytext); return ID; }
{num}       { yylval.num = atoi(yytext); return NUM; }

[ \t\n]+    ;  /* Ignore whitespace */
.           { printf("Invalid token: %s\n", yytext); }

%%
