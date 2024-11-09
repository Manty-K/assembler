     1                                  section .data
     2                                  	
     3 00000000 2D00                    	hello_23 dw 45
     4 00000002 0C000000                	boom23 dd 12
     5 00000006 61626364                	hii2 db "abcd"
     6 0000000A 616263640A00            	hii3 db  "abcd", 10,0
     7 00000010 2D00                    	hello_24 dw 45
     8 00000012 2D00000000000000        	hello_25 dq 45
     9                                  section .bss
    10                                  	
    11 00000000 <res Dh>                	yoo10 resb 13
    12 0000000D ????                    	yoo12 resb 2
    13 0000000F ??????                  	yoo14 resb 3
    14 00000012 ????????????????        	yoo18 resb 8
    15 0000001A <res 9h>                	yoo20 resb 9
    16 00000023 <res Eh>                	yoo19 resb 14
    17 00000031 <res Fh>                	yoo15 resb 15
    18 00000040 <res 10h>               	yoo16 resb 16
    19 00000050 <res 11h>               	yoo17 resb 17
    20                                  
    21 00000061 ????????                	yoo2 resd 1
    22 00000065 ????????????????        	yoo21 resd 2
    23 0000006D <res Ch>                	yoo22 resd 3
    24 00000079 ????????????            	yoo3 resw 3
    25 0000007F <res 32h>               	yoo4 rest 5
    26 000000B1 ????????????????        	yoo5 resq 1
    27 000000B9 <res 14h>               	yoo6 rest 2
