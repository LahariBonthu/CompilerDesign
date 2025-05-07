# Compiler Front-End Project

## Objective

This project involves designing and implementing the **front end of a compiler** for a simple example language. The compiler will process source code written in the specified language and produce an **Intermediate Representation (IR)**.

The project is divided into three main stages:

1. **Learning Lex and Yacc**
2. **Building a Lexical Analyzer and Parser**
3. **Implementing Semantic Analysis and Intermediate Code Generation**


###  Stage 1: Learning Lex and Yacc

  - [Using Lex](https://silcnitc.github.io/lex.html)
  - [Using Yacc](https://silcnitc.github.io/yacc.html)
  - [Using Lex with Yacc](https://silcnitc.github.io/ywl.html)

###  Stage 2: Lexical Analyzer and Parser

- Build a lexical analyzer using **Lex**
- Construct a parser using **Yacc**
- Input: Source code file
- Output: `"Parsing Successful"` or `"Syntax Error"`


 
 ###  Bcs22 Language Specification

####  Syntax Rules
 program → BcsMain { declist stmtlist }  
 declist → declist decl | decl  
 decl → type id ;  
 type → int | bool  
 stmtlist → stmtlist ; stmt | stmt  
 stmt → id = aexpr  
 | if ( expr ) { stmtlist } else { stmtlist }  
 | while ( expr ) { stmtlist }  
 expr → aexpr relop aexpr | aexpr- aexpr → aexpr + aexpr | term  
 term → term * factor | factor  
 factor → id | num  

####  Token Specifications

 letter → [a-zA-Z]  
 digit → [0-9]  
 id → letter (letter | digit)*  
 num → digit+  
 relop → < | > | <= | >= | == | !=  


####  Keywords

- `BcsMain`
- `int`
- `bool`
- `if`
- `else`
- `while`

 


###  Stage 3: Semantic Analysis and IR Generation


- Generated **3-address code** for assignment expressions using Yacc semantic actions.
- Output is written to a file.
- Supports expressions with multiple operators.




