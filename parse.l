%{
#include "parse.tab.h"
#include "utils.h"
char *label;
char *value;
%}

SECTION "section"
NUMBER 	[0-9]+
ALPNUM	[a-zA-Z_]+[a-zA-Z0-9_]*
SPACE	[ \t]+
RES	"res"[bwtqd]
%%


{SECTION}{SPACE}".data"		{return SEC_DATA;}
{SECTION}{SPACE}".bss"		{return SEC_BSS;}
"db"				{return DB_TYPE;}
"dw"				{return DW_TYPE;}
"dd"				{return DD_TYPE;}
"dq"				{return DQ_TYPE;}
"dt"				{return DT_TYPE;}
"resb"				{return RESB_TYPE;}
"resw"				{return RESW_TYPE;}
"resd"				{return RESD_TYPE;}
"resq"				{return RESQ_TYPE;}
"rest"				{return REST_TYPE;}

{ALPNUM}			{label = strdup(yytext); return LABEL;}
{NUMBER}			{value = strdup(yytext); return VALUE;}
\n		{return NEWLINE;}
{SPACE}		{}
.		{}
%%
