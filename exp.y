%{
#define YYSTYPE double 
#include <stdio.h>
#include "lex.yy.c"
#include <math.h>
int yyparse(void);
%}
%token NEWLINE REALNUM PLUS MINUS TIMES DIVIDE LP RP RAISE NEG
%%

commands: command {printf("DONE\n");}

command: command exp NEWLINE { printf("Result == %lf\n", $2); }
|exp NEWLINE { printf("Result == %lf\n", $1); }

exp : exp PLUS term {$$ = $1 + $3; }
|exp MINUS term {$$ = $1 - $3; }
|term {$$ = $1;}

term : term TIMES factor {$$ = $1 * $3;}
|term DIVIDE factor {$$ = $1 / $3;}
|factor {$$ = $1;}

/*factor : REALNUM {$$ = $1;}
|LP exp RP {$$ = $2;}*/

factor : num RAISE factor {$$ = pow($1, $3);}
|num {$$ = $1;}

num : REALNUM {$$ = $1;}
|MINUS REALNUM {$$ = -$2;}
|MINUS parenthesised {$$ = -$2;}
|parenthesised {$$ = $1;}

parenthesised : LP exp RP {$$ = $2;}


%%

int main() {
	return yyparse();
}

int yyerror(char* s) {
	fprintf(stderr, "%s\n", s);
}
