//Harrison Hill  -  hmh16c

//Due to time constraints within my other classes, 
//this yacc program will only recognize syntactically correct and incorrect programs.

//semantic analysis and interpretation has not been implemented.

//I'm usually not this lazy, I promise.  It's just been a busy semester.

//tests and errors 1, 2, and 3 all are detected correctly.  

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
/*
ST, V, VAL, I, T, F, etc.  are all intermediary steps in the CFG
If I was re designing the CFG I would re name them to more exact names.
this is just how I wrote it when I first made the CFG.

"program accepted" will print upon recognizing a syntactically correct program.

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
