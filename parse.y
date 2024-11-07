%{
#include<stdio.h>

void yyerror(const char * e);
int yylex();

extern char * label;
extern char * value;

int loc = 0;
%}

%token SEC_DATA SEC_BSS SEC_TEXT LABEL VALUE DB_TYPE DW_TYPE DD_TYPE NEWLINE 

%start lines

%%

lines: line
	|
	;

line: data_sec	{puts("data parsing done");}
	;

data_sec: SEC_DATA NEWLINE data_lines {puts("parsing data section");}
	;

data_lines: data_line NEWLINE data_lines {puts("line");}
	| NEWLINE data_lines
	|
	;

data_line: LABEL DB_TYPE VALUE {printf("%d\t %s db %s\n",loc,label,value); loc += 1;}
	|  LABEL DW_TYPE VALUE {printf("%d\t %s dw %s\n",loc,label,value); loc += 2;}
	|  LABEL DD_TYPE VALUE {printf("%d\t %s dd %s\n",loc,label,value); loc += 4;}
	;
%%

void yyerror(const char * e){
	printf("Abey: %s\n",e);
}

int main(){
	yyparse();
	return 0;
}
