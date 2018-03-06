/**
* Bison file to define grammar of Zoomjoystrong language.
* 
* @author Edric Lin
* @author Austin Maley
* @version 3/5/2018
*/

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "zoomjoystrong.h"

	/**
	* Print interpreter errors.
	*
	* @param msg the error message to print.
	*/
	void yyerror(const char* msg);

	/**
	* Called to invoke the lexer (or scanner).
	*
	* @return 1
	*/
	int yylex();
%}

%error-verbose
%start program

%union { int i; float f; }

%token END
%token END_STMT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT

%%

program:	END		{exit(EXIT_SUCCESS);} /* https://www.youtube.com/watch?v=__-wUHG2rfM */
	|	stmt_list
	|	stmt_list END	{exit(EXIT_SUCCESS);}

stmt_list:	stmt
	|	stmt stmt_list

stmt:		point_cmd 
	|	line_cmd
	|	circle_cmd
	|	rectangle_cmd
	|	set_color_cmd

point_cmd:	POINT INT INT END_STMT
		{
			if ($2 >= 0 && $2 <= WIDTH && $3 >= 0 && $3 <= HEIGHT) {
				point($2, $3);
			} else {
				yyerror("Out of bounds.");
			}
		};


line_cmd:	LINE INT INT INT INT END_STMT
		{
			if ($2 >= 0 && $2 <= WIDTH && $3 >= 0 && $3 <= HEIGHT &&
				$4 >= 0 && $4 <= WIDTH && $5 >= 0 && $5 <= HEIGHT) {
				line($2, $3, $4, $5);
			} else {
				yyerror("Out of bounds.");
			}
		};

circle_cmd:		CIRCLE INT INT INT END_STMT
		{
			if ($2 >= 0 && $2 <= WIDTH && $3 >= 0 && $3 <= HEIGHT) {
				circle($2, $3, $4);
			} else {
				yyerror("Out of bounds.");
			}
		};

rectangle_cmd:	RECTANGLE INT INT INT INT END_STMT
		{
			if ($2 >= 0 && $2 <= WIDTH && $3 >= 0 && $3 <= HEIGHT &&
				$4 >= 0 && $4 <= WIDTH && $5 >= 0 && $5 <= HEIGHT) {
				rectangle($2, $3, $4, $5);
			} else {
				yyerror("Out of bounds.");
			}
		};

set_color_cmd:	SET_COLOR INT INT INT END_STMT
		{
			if ($2 >= 0 && $2 <= 255 && $3 >= 0 && $3 <= 255 && $4 >= 0 && $4 <= 255) {
				set_color($2, $3, $4);
			} else {
				yyerror("Out of bounds.");
			}
		};
%%

/**
* Run the interpreter for Zoomjoystrong.
*
* @param argc number of command line arguments
* @param argv command line arguments
*/
int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
	return 0;
}

/**
* Print interpreter errors.
*
* @param msg the error message to print.
*/
void yyerror(const char* msg){
	fprintf(stderr, "ERROR! %s\n", msg);
}