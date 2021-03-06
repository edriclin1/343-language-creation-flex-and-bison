/**
* Flex file to define tokens of Zoomjoystrong language.
* 
* @author Edric Lin
* @author Austin Maley
* @version 3/5/2018
*/

%{
	#include "zoomjoystrong.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
%}

%option noyywrap

%%

end				{ printf("END "); return END; }
;				{ printf("END_STMT "); return END_STMT; }
point				{ printf("POINT "); return POINT; }
line				{ printf("LINE "); return LINE; }
circle				{ printf("CIRCLE "); return CIRCLE; }
rectangle			{ printf("RECTANGLE "); return RECTANGLE; }
set_color			{ printf("SET_COLOR "); return SET_COLOR; }
[0-9]+[.][0-9]+			{ printf("FLOAT "); yylval.f = atof(yytext); return FLOAT; }
[0-9]+				{ printf("INT "); yylval.i = atoi(yytext); return INT; }
[ ]				{ printf(" "); }
\t				{ printf("\t"); }
\n				{ printf("\n"); }
.				{ printf("[Invalid token] "); }

%%