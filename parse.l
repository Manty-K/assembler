%{
#include "parse.tab.h"
char *label;
char *value;
%}

SECTION "section"
NUMBER 	[0-9]+
ALPNUM	[a-zA-Z_]+[a-zA-Z0-9_]*
SPACE	[ \t]+
%%


{SECTION}{SPACE}".data"		{return SEC_DATA;}
"db"				{return DB_TYPE;}
"dw"				{return DW_TYPE;}
"dd"				{return DD_TYPE;}
{ALPNUM}			{label = strdup(yytext); return LABEL;}
{NUMBER}			{value = strdup(yytext); return VALUE;}
\n		{return NEWLINE;}
{SPACE}		{}
.		{}
%%
