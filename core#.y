/*
completed : basic io,expressions,ifelse,loops,functions,comments,array declarations,switchcases,arrays usage inside the body,functioncalls,
(semantics) : printing strings

yet to do : using parathesis..(semantics): evaluating expression and printing alue



test program is running successfully
*/

%{
#include <stdlib.h>
#define YYSTYPE char *

%}

%token SET SHOW EQUAL SWITCH PLUS MINUS STATE MODE MULT DIV GET STRING EOLN FUN_STOP HASH NUM DOUBLEQ INT FLOAT DOUBLE  SPACE
%token COMMA IF THEN ELSE STOP ELIF FOR WHILE DO A COLON SEMICOLON SEMISEMICOLON CASE CUT DEFAULT BRO BRC BOOL CHAR
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE LT GT
 
%%

start:Declarations HASH Body HASH Functions  
      |Comments
      ;
 
Comments:SEMICOLON expr1 start
        |SEMISEMICOLON expr1 SEMISEMICOLON start
        ;
               
        
Functions: Functions datatype  SPACE STRING COLON Declarations COLON Body STOP
          |
          ;
Declarations:vardec
             |arrdec
             |
             ;

vardec: datatype SPACE STRING COMMA Declarations
        ;
arrdec: datatype SPACE STRING COMMA A COMMA Declarations
        ;
             
 
datatype:INT
        |FLOAT
        |DOUBLE
        |CHAR
        |BOOL
        ;

Body:
     |expr
     |condstmts
     |loopstmts Body
     |switch
     |funcall 
     ;

funcall: STRING COLON parameters COLON
        ;

parameters:STRING COMMA 
           |parameters STRING COMMA
          ;
switch: SWITCH SPACE STRING COLON case default STOP
        ;
 
case: 
      |case CASE SPACE NUM COLON Body CUT 
      ;

default: DEFAULT COLON Body CUT
        ; 

stmts:io
     ;

io:	SHOW SPACE DOUBLEQ expr1 DOUBLEQ 
    |SHOW SPACE expr
 	  ;

expr1:	STRING
      |STRING SPACE expr1
      ; 


expr :
      |cond_expr expr Body
      |ass_expr Body
      |ass_expr COMMA A EQUAL ass_expr Body
      |ass_expr expr Body
      |stmts Body
     ; 
     
cond_expr :cond_expr LE cond_expr
           |cond_expr GE cond_expr
           |cond_expr NE cond_expr
           |cond_expr EQ cond_expr
           |cond_expr GT cond_expr
           |cond_expr LT cond_expr
           |STRING 
           |NUM  
           ;
           
ass_expr :  STRING EQUAL ass_expr 
          | STRING EQUAL ass_expr PLUS ass_expr 
          | STRING EQUAL ass_expr MINUS ass_expr
          | STRING EQUAL ass_expr MULT ass_expr
          | STRING EQUAL ass_expr DIV ass_expr  
          |'(' ass_expr ')' 
          |NUM
          |STRING
          ;

condstmts : IF SPACE cond_expr SPACE THEN Body STOP Body
          | ELIF SPACE cond_expr SPACE THEN Body
          | IF SPACE cond_expr SPACE THEN Body ELSE Body STOP Body
          | Body
          ;

loopstmts :FOR SPACE ass_expr COMMA cond_expr COMMA ass_expr condstmts STOP
          |FOR SPACE ass_expr COMMA cond_expr COMMA ass_expr loopstmts STOP
          |FOR SPACE ass_expr COMMA cond_expr COMMA ass_expr io STOP
          |WHILE SPACE cond_expr condstmts STOP
          |WHILE SPACE cond_expr loopstmts STOP
          |DO SPACE condstmts WHILE cond_expr STOP
          |DO SPACE loopstmts WHILE cond_expr STOP
          |DO SPACE io WHILE cond_expr STOP
          ;
          
%%

#include <stdio.h>
char *progname;
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	
   if(!yyparse()){
		printf("\nParsing complete\n");}
	else

		printf("\nParsing failed\n");
	
	fclose(yyin);
    return 0;
}
         
yyerror(char *s) {
	printf("%d : %s %s\n", yylineno, s, yytext );
}  
