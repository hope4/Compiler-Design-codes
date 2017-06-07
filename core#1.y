/*
Completed : arithmetic expressions with + - * / % ^ , ifelse with < > <= >=, show numbers,while and for with < > <= >= ==,undeclared variables checking

yet to do : printing strings , precedence ,arrays, functions,

Errors in completed : showing strings, redundancy in grammar, show operator not working in between,combined giving error for undeclared variables checking individually it is coming out to be perfect.

*/



%{
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<string.h>
char s[20];
int val;
int symbols[52];
int symbolexist[52];
int increment(char symbol);
int decrement(char symbol);
int symbolVal(char symbol);
int declcheck(char symbol);
void updateSymbolVal(char symbol,int val);
void decVal(char symbol,int val);
int flag=11;
%}

%union {int num; char id;}
%start program
%token SHOW HASH INT FLOAT a EEQ IF WHILE identifier FOR THEN ELSE LE GE LEQ GEQ DOUBLE COMMA SEMICOLON SEMISEMICOLON STOP SPACE COLON
%token exit_command
%token <num> number

%type <num> Body exp term cond_expr Body1 
%type <id> assignment identifier


%%

program :Declarations HASH Body HASH Functions
        |Comments 
        ;
 
Comments:SEMICOLON SPACE temp_identifier program  
        |SEMISEMICOLON SPACE temp_identifier SEMISEMICOLON program
        ;
           
           
temp_identifier :identifier
                |identifier SPACE temp_identifier
                ;
Declarations:
             |Declarations arrdec COMMA
             |Declarations datatype SPACE identifier COMMA  {decVal($4,1);}
             ;

Functions: datatype SPACE identifier COLON Declarations COLON Body STOP
         |
        ;

arrdec : datatype SPACE identifier COMMA a 
       ;         
 
datatype:INT            
        |FLOAT          
        |DOUBLE 
        ;    

Body :    assignment                    {;}
          |funcall                      {;}
          |exit_command                 {exit(EXIT_SUCCESS);}
	  |SHOW SPACE exp  	                {if (flag==11){
	                                        printf("%d\n",$3);}}
	  |Body assignment  
	  |Body SHOW SPACE exp                {if (flag==11)
	                                printf("%d\n",$4);}
	  |Body condstmts               {;}
	  |Body loopstmts               {;}
	  |                             {;}

funcall :identifier COLON parameters COLON
        ;

parameters:identifier COMMA 
           |parameters identifier COMMA
          ;

Body2 :    assignment                   {;}
          |exit_command                 {exit(EXIT_SUCCESS);}
	  |SHOW SPACE exp  	                {if (flag==101){
	                                printf("%d\n",$3);}}
	  |Body assignment  
	  |Body SHOW SPACE exp                {if (flag==101)
	                                printf("%d\n",$4);}
	  |condstmts                    {;}
	  |Body loopstmts               {;}
	  |                             {;}
	  
cond_expr :  cond_expr LE cond_expr     {if(declcheck($1)==1)
                                        {if(symbolVal($1) < symbolVal($3)){
                                                flag=1;}
                                                else{
                                                 flag=101;}
                                        }
                                        else{
                                         printf("Oops!! Undeclared variable\n");
                                        }
                                        }
                                        
           |cond_expr GE cond_expr      {if(declcheck($1)==1)
                                                {if(symbolVal($1) > symbolVal($3)){
                                                flag=1;}
                                        else{
                                                flag=101;}
                                        }
                                        else{
                                                 printf("Oops!! Undeclared variable\n");
                                            }
                                        }
                                        
           |cond_expr LEQ cond_expr     {if(declcheck($1)==1)
                                                {if(symbolVal($1) <= symbolVal($3)){
                                                 flag=1;}
                                        else{
                                                flag=101;}
                                        }
                                        else{
                                                 printf("Oops!! Undeclared variable\n");
                                        }
                                        }
           
           |cond_expr GEQ cond_expr     {if(declcheck($1)==1)
                                                {if(symbolVal($1) >= symbolVal($3)){
                                                flag=1;}
                                                else{
                                                flag=101;}
                                        }
                                        else{
                                                 printf("Oops!! Undeclared variable\n");
                                                }
                                        }
                                        
           |cond_expr EEQ cond_expr     {if(declcheck($1)==1)
                                                {if(symbolVal($1) == symbolVal($3)){
                                                flag=1;}
                                                else{
                                                flag=101;}
                                                }
                                        else{
                                                 printf("Oops!! Undeclared variable\n");
                                        }
                                        }
           |identifier                  {$$=$1;}
                
           |number                      {$$=$1;}
           ;
           
condstmts :IF SPACE cond_expr SPACE THEN Body1        
              ELSE  Body2                                     
             STOP                                      
          ;
         
Body1 :    assignment                   {;}
          |exit_command                 {exit(EXIT_SUCCESS);}
	  |SHOW SPACE exp  	                {if (flag==1)
	                                        printf("%d\n",$3);}
	 
	  |Body assignment              {;}
	  |Body SHOW SPACE exp                {if (flag==1)
	                                        printf("%d\n",$4);}
	  |Body condstmts               {;}
	  |Body loopstmts               {;}
	  |                             {;}
	  ;
	  
	  
loopstmts :FOR SPACE assignment COMMA identifier LE exp       {printf("%d\n",symbolVal($5));}  
           COMMA assignment                             {while(symbolVal($5)< $7){
                                                                printf("%d\n",symbolVal($3));
                                                                val=increment($5);
                                                                updateSymbolVal($5,val);
                                                         } ;                                       
                                                         }
          SHOW SPACE exp STOP 
          |FOR SPACE assignment COMMA identifier GE exp       {printf("%d\n",symbolVal($5));}  
           COMMA assignment                             {while(symbolVal($5) > $7){
                                                                printf("%d\n",symbolVal($3));
                                                                val=decrement($5);
                                                                updateSymbolVal($5,val);
                                                         };                                       
                                                        }
          SHOW SPACE exp STOP 
          
          |WHILE SPACE identifier LE exp
               SHOW SPACE exp                                 {printf("%d\n",symbolVal($3));}   
                 assignment STOP                        {while(symbolVal($3)< $5){
                                                                 printf("%d\n",symbolVal($3));
                                                                 val=increment($3);
                                                                 updateSymbolVal($3,val);
                                                        };                                       
                                                        } 
          |WHILE SPACE identifier GE exp
               SHOW SPACE exp                                 {printf("%d\n",symbolVal($3));
                                                        }   
                 assignment STOP                        {while(symbolVal($3) > $5){
                                                                printf("%d\n",symbolVal($3));
                                                                val=decrement($3);
                                                                updateSymbolVal($3,val);
                                                        };                                       
                                                        } 
          |WHILE SPACE identifier LEQ exp
               SHOW SPACE exp                                 {printf("%d\n",symbolVal($3));}   
                 assignment STOP                        {while(symbolVal($3)<=$5){
                                                                printf("%d\n",symbolVal($3));
                                                                val=increment($3);
                                                                updateSymbolVal($3,val);
                                                        };                                       
                                                        } 
          |WHILE SPACE identifier GEQ exp
               SHOW SPACE exp                                 {printf("%d\n",symbolVal($3));}   
                 assignment STOP                        {while(symbolVal($3)>=$5){
                                                        printf("%d\n",symbolVal($3));
                                                                val=decrement($3);
                                                                updateSymbolVal($3,val);
                                                        };                                       
                                                        }      
          
          ;
assignment : identifier  '=' exp                        {if(declcheck($1)==1){
                                                        updateSymbolVal($1,$3);
                                                        $$=$1;}
                                                        else 
	                                                 printf("Undeclared variable!! \n");
                                                        }
           

exp  : term		                                {$$ = $1;}
	 | exp '+' term                                 {$$ = $1+$3;}
	 | exp '-' term                                 {$$ = $1-$3;}
         | exp '*' term                                 {$$ = $1*$3;}
	 | exp '/' term                                 {if($3!=0){$$ = $1/$3;}
	                                                else if($3==0){printf("Divided by Zero\n");}}
	 | exp '%' term                                 {$$ = $1%$3;}
	 | exp '^' term                                 {$$ = pow($1,$3);}
term : number                                           {$$=$1;}
	 | identifier                                   {if(declcheck($1)==1)
	                                                $$=symbolVal($1);
	                                                else 
	                                                printf("Undeclared variable !!");
	                                                }

%%

int computeSymbolIndex(char token){
	
	int idx=-1;
	if(islower(token)){
	idx=token - 'a' +26;
	}
	else if(isupper(token)){
	idx=token - 'A';
	}
	return idx;
}

int symbolVal(char symbol){
	int bucket = computeSymbolIndex(symbol);
	return symbols[bucket]; 
}

int increment(char symbol){
	int bucket = computeSymbolIndex(symbol);
	int c;
	c=symbols[bucket]; 
        c=c+1;
        return c;
}
int decrement(char symbol){
	int bucket = computeSymbolIndex(symbol);
	int c;
	c=symbols[bucket]; 
        c=c-1;
        return c;
}

int declcheck(char symbol){
	int bucket = computeSymbolIndex(symbol);
	return symbolexist[bucket];
	         
}

void updateSymbolVal(char symbol,int val){
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket]=val;
}

void decVal(char symbol,int val){
	int bucket = computeSymbolIndex(symbol);
	symbolexist[bucket]=val;
}


#include <stdio.h>
char *progname;
int main(int argc, char *argv[])
{
	yyin = fopen(argv[1], "r");
	int i;
	for(i=0;i<52;i++){
		symbols[i]=0;
	}
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

