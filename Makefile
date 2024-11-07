all: yoo
	./yoo < src.s

yoo: lex.yy.c parse.tab.c
	gcc  parse.tab.c lex.yy.c -ll -o yoo

lex.yy.c: parse.l
	flex parse.l

parse.tab.c: parse.y
	bison -d parse.y

clean:
	rm -rf yoo *.tab.* lex.yy.c
