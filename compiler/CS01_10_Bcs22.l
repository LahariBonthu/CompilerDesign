%{
#include "y.tab.h"
#include <stdio.h>
%}

%option yylineno
letter  [a-zA-Z]        
digit   [0-9]           

%%

"+"                 { return '+'; }
"*"                 { return '*'; }
"="                 { return '='; }
"{"                 { return '{'; }
"}"                 { return '}'; }
"("                 { return '('; }
")"                 { return ')'; }
";"                 { return ';'; }
"=="   { return EQ; }
"!="   { return NE; }
"<="   { return LE; }
">="   { return GE; }
"<"    { return LT; }
">"    { return GT; }

{digit}+            { return NUM; }
"if"                { return IF; }
"else"              { return ELSE; }
"while"             { return WHILE; }
"BcsMain"           { return BcsMain; }
"int"               { return INT; }
"bool"              { return BOOL; }    
({letter})({letter}|{digit})* { return ID; }
[ \n\t]+            { ; }
.                   { printf("Unrecognized token '%s'\n", yytext); return 0; }
%%

int yywrap() {
    return 1;
}

