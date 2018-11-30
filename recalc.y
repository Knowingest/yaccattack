%{
#include<stdio.h>
int x;
yyline = 1;
yycolumn = 1;
%}

/* declarations */

%token ICONSTnumber PRINTnumber PROGRAMnumber ISnumber VARINTnumber VARSTRnumber DIVnumber DOTnumber SEMInumber LPARENnumber MINUSnumber TIMESnumber COMMAnumber RPARENnumber PLUSnumber EQnumber BEGINnumber ENDnumber TYPESEPnumber STRINGnumber IDnumber

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
comp : BEGINnumber ST ENDnumber ;

ST : statement
   | statement ST
   ;
statement : id EQnumber expr SEMInumber
		  | id EQnumber STRINGnumber SEMInumber
		  | PRINTnumber V
		  | declaration
		  ;
V : value
  | value COMMAnumber V
  ;
value : ICONSTnumber 
	  | STRINGnumber
	  | IDnumber
	  ;

declaration : I TYPESEPnumber VAL ;

I : id
  | id COMMAnumber I
  ;
VAL : VARINTnumber
    | VARSTRnumber
    ;
expr : T
     | MINUSnumber T
     ;
T : term
  | term PLUSnumber T
  | term MINUSnumber T
  ;
term : F ;
F : factor
  | factor TIMESnumber F
  | factor DIVnumber F
  ;
factor : ICONSTnumber
       | IDnumber
       | LPARENnumber expr RPARENnumber
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