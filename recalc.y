%{
#include<stdio.h>
int x;
%}

/* declarations */

%token INT STRING PRINT

%start program

%%
/* parsing ruleset definitions 

CFG

program -> id
id -> is
is -> comp
comp -> {ST}

ST -> statement | statement ST
statement -> id = expr; | id = string literal;
statement -> print V;
statement -> declaration;

V -> value | value, V
value -> integer constant | string literal | id

declaration -> I :: VAL
I -> id | id, I
VAL -> int | string

expr -> T | -T
T -> term | term + T | term - T

term -> F
F -> factor | factor * F | factor / F

factor -> integer constant | id | (expr)
*/

program : id ;
id : is ;
is : comp ;
comp : '{' ST '}' ;

ST : statement
   | statement ST
   ;
statement : id '=' expr ';'
		  | id '=' STRING ';'
		  | PRINT V
		  | declaration
		  ;
V : value
  | value ',' V
  ;
value : INT 
	  | STRING
	  | id
	  ;

declaration : I ':' ':' VAL ;

I : id
  | id ',' I
  ;
VAL : INT
    | STRING
    ;
expr : T
     | '-' T
     ;
T : term
  | term '+' T
  | term '-' T
  ;
term : F ;
F : factor
  | factor '*' F
  | factor '/' F
  ;
factor : INT
       | id
       | '(' expr ')'
       ;

%%

main()
{
 return(yyparse());
}

yyerror(s)
char *s;
{
  fprintf(stderr, "%s\n",s);
}

yywrap()
{
  return(1);
}