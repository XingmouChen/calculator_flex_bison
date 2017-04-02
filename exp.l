%{
#include <string.h>
#include "exp.tab.h"
extern double yylval;
int my_input;
%}
numbers ([0-9])+|\.([0-9])+|([0-9])+\.([0-9])+
plus "+"
minus "-"
times "*"
divide "/"
lp "("
rp ")"
raise "^"
delim [ \t]
ws {delim}*
newline "\n"
%%
{numbers} {
	sscanf(yytext, "%lf", &yylval); 
	//printf("my_input == %d\n", my_input); 
	//yylval = my_input; 
	//printf("yylval == %lf\n", yylval); 
	printf("{numbers} yytext == %s\n", yytext);
	return REALNUM;
	}
{plus} {return PLUS;}
{minus} {return MINUS;}
{times} {return TIMES;}
{divide} {return DIVIDE;}
{lp} {return LP;}
{rp} {return RP;}
{raise} {return RAISE;}
{ws} ;
{newline} {return NEWLINE;}
. {printf("Error!\n"); exit(1);}
%%

int yywrap()
{
	return 1;
}
