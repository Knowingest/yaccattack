%{
#include<stdio.h>
int yyline = 1;
int yycolumn = 1;
%}

/* declarations */

%union { int sv;
	char* s; 
	struct{ char s[1000]; 
		int sv;} struck;
	}

%token ICONSTnumber PRINTnumber
%token PROGRAMnumber ISnumber
%token VARINTnumber VARSTRnumber
%token DIVnumber DOTnumber
%token SEMInumber LPARENnumber
%token MINUSnumber TIMESnumber
%token COMMAnumber RPARENnumber
%token PLUSnumber EQnumber
%token BEGINnumber ENDnumber
%token TYPESEPnumber STRINGnumber
%token IDnumber


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
value -> integer constant | string literal | IDnumber

declaration -> I :: VAL
I -> id | id, I
VAL -> int | string

expr -> T | -T
T -> term | term + T | term - T

term -> F
F -> factor | factor * F | factor / F

factor -> integer constant | id | (expr)
*/

program : PROGRAMnumber IDnumber ISnumber comp
	{printf("program accepted\n");}
comp : BEGINnumber ST ENDnumber ;

ST : statement
   | ST statement
   ;
statement : IDnumber EQnumber expr SEMInumber
		  | IDnumber EQnumber STRINGnumber SEMInumber
		  | PRINTnumber V SEMInumber
		  | declaration SEMInumber
		  ;
V : value
  | V COMMAnumber value
  ;
value : STRINGnumber
	  | expr
	  ;

declaration : I TYPESEPnumber VAL ;

I : IDnumber
  | I COMMAnumber IDnumber
  ;
VAL : VARINTnumber
    | VARSTRnumber
    ;
expr : T
     | MINUSnumber T
     ;
T : term
  | T PLUSnumber term
  | T MINUSnumber term
  ;
term : F ;
F : factor
  | F TIMESnumber factor
  | F DIVnumber factor
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
  fprintf(stderr, "%s at line %d \n",s, yyline);
}

yywrap()
{
  return(1);
}
