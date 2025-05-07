%{
#include <stdio.h>
int yylex();
int yyerror(char* s);
extern int yylineno;
extern FILE *yyin;
%}

%token BcsMain
%token NUM
%token ID
%token INT BOOL
%token IF ELSE WHILE
%token LT GT LE GE EQ NE  
%left '+'
%left '*'

%%

program : BcsMain '{' declist stmtlist '}' { printf("Parsing Successful\n"); }
        ;

declist : declist decl 
        | decl
        ;

decl    : type ID ';'
        ;

type    : INT
        | BOOL
        ;

stmtlist : stmtlist ';' stmt
         | stmt
         ;

stmt    : ID '=' aexpr
        | IF '(' expr ')' '{' stmtlist '}' ELSE '{' stmtlist '}'
        | WHILE '(' expr ')' '{' stmtlist '}'
        ;

expr    : aexpr relop aexpr 
        | aexpr
        ;

relop   : LT | GT | LE | GE | EQ | NE  
        ;

aexpr   : aexpr '+' aexpr 
        | term
        ;

term    : term '*' factor 
        | factor
        ;

factor  : ID
        | NUM
        ;

%%

int yyerror(char* s) {
    printf("Syntax Error\n");
    return 0;
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }

    yyin = file;  
    yyparse();   
    fclose(file);
    return 0;
}

