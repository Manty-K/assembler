all: yoo
	./yoo < src.s

yoo: lex.yy.c parse.tab.c utils.c utils.h
	gcc  parse.tab.c lex.yy.c utils.c -ll -o yoo

lex.yy.c: parse.l
	flex parse.l

parse.tab.c: parse.y utils.h
	bison -d parse.y

clean:
	rm -rf yoo *.tab.* lex.yy.c
