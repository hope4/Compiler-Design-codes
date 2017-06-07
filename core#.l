%{
#include <stdio.h>
#include "y.tab.c"
%}

%%
show return SHOW;
int return INT;
float return FLOAT;
double return DOUBLE;
char {return CHAR;}
bool {return BOOL;}
switch return SWITCH;
case return CASE;
default return DEFAULT;
cut return CUT;
#   return HASH;
:   return COLON;
;   return SEMICOLON;
";;"  return SEMISEMICOLON;
if  return IF;
then return THEN;
else return ELSE;
stop return STOP;
elif return ELIF;
for  return FOR;
A    return A;
while return WHILE;
do    return DO;
"="   return EQUAL;
"+"   return PLUS;
"-"   return MINUS;
"*"		{return MULT;}
"/"		{return DIV;}
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
">"	return GT;
"<"	{return LT;}
"{" {return BRO;}
"}" {return BRC;}
","       return COMMA;
[ ] 	{return SPACE;}
\"  return DOUBLEQ; 
[0-9]+ { yylval=strdup(yytext); return NUM; }
[a-zA-Z]+ { yylval=strdup(yytext); return STRING; }
%%

int yywrap()
{
  return 1;
}
