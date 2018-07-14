sort_books: sort_books.o bookcmp.o
	gcc -m32 sort_books.o bookcmp.o -o sort_books

bookcmp.o: bookcmp.asm
	nasm -f elf -g bookcmp.asm

sort_books.o: sort_books.c
	gcc -m32 -ansi -Wall -g -c sort_books.c
