%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
int temp_count = 0;

extern FILE *yyin;

FILE *tac_file;

char* new_temp() {
    char* temp = (char*)malloc(5);
    sprintf(temp, "t%d", temp_count++);
    return temp;
}

%}

%union {
    char* str;
    int num;
}

%token <str> ID
%token <num> NUM
%token BCSMAIN INT BOOL IF ELSE WHILE ASSIGN PLUS MULT RELOP LBRACE RBRACE SEMICOLON

%type <str> aexpr term factor

%%

program     : BCSMAIN LBRACE declist stmtlist RBRACE { printf("Parsing Successful\n"); }
            ;

declist     : declist decl
            | decl
            ;

decl        : type ID SEMICOLON { fprintf(tac_file, "%s = 0\n", $2); }
            ;

type        : INT
            | BOOL
            ;

stmtlist    : stmtlist stmt SEMICOLON
            | stmt SEMICOLON
            ;

stmt        : ID ASSIGN aexpr { fprintf(tac_file, "%s = %s\n", $1, $3); }
            ;

aexpr       : aexpr PLUS term {
                char* t = new_temp();
                fprintf(tac_file, "%s = %s + %s\n", t, $1, $3);
                $$ = t;
            }
            | term { $$ = $1; }
            ;

term        : term MULT factor {
                char* t = new_temp();
                fprintf(tac_file, "%s = %s * %s\n", t, $1, $3);
                $$ = t;
            }
            | factor { $$ = $1; }
            ;

factor      : ID { $$ = $1; }
            | NUM {
                char* t = (char*)malloc(10);
                sprintf(t, "%d", $1);
                $$ = t;
            }
            ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    tac_file = fopen("output.txt", "w");
    if (!tac_file) {
        perror("Error opening output file");
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }

    yyin = input_file;
    yyparse();

    fclose(input_file);
    fclose(tac_file);

    return 0;
}
