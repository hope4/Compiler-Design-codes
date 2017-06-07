%{
#include "stdio.h"
#include "y.tab.c"
%}
%%
"show"                          {return SHOW;}
"int"                           {return INT;}
"float"                         {return FLOAT;}
"double"                        {return DOUBLE;}
"stop"                          {return STOP;}
"if"                            {return IF;}
"then"                          {return THEN;}
"for"                           {return FOR;}
"else"                          {return ELSE;}
"while"                         {return WHILE;}
"exit"                          {return exit_command;}
"A"                             {return a;}
,                               {return COMMA;}
;                               {return SEMICOLON;}
:                               {return COLON;}
";;"                            {return SEMISEMICOLON;}
"<"                             {return LE;}
">"                             {return GE;}
"<="                            {return LEQ;}
">="                            {return GEQ;}
"=="                            {return EEQ;}
[ ]                            {return SPACE;}
#                               {return HASH;}
[a-zA-Z]+                       {yylval.id=yytext[0];return identifier;}
[0-9]+                          {yylval.num=atoi(yytext); return  number;}
[ \t\n]                         {;}
[-+=*/%^;]                      {return yytext[0];}
.                               {ECHO; yyerror("unexpected character");}
%%

int yywrap (void)               {return 1;}







