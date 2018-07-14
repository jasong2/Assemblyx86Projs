;;; ;  ;  **************************************************************
;;; ; ; ;  Jason Gorelik
;;; ; ; ;  Email: jasong2@umbc.edu
;;; ; ; ;  CMSC313 Assembly
;;; ; ; ;  Proj4
;;; ; ; ;                       Proj4
;;; ; ; ;  File: bookcmp.asm
;;; ; ; ;  Compare book subroutine
;;; ; ; ;  ***************************************************************


	                 %define STDIN 0
	                 %define STDOUT 1
	                 %define STDERR 2
	                 %define SYSCALL_EXIT  1
	                 %define SYSCALL_READ  3
	                 %define SYSCALL_WRITE 4
	                 %define BUFLEN 256

			 %define TITLE_OFFSET 0
			 %define AUTHOR_OFFSET 33  
			 %define SUBJECT_OFFSET 54 
			 %define YEAR_OFFSET 68
	SECTION .data

msg1:	            db "Enter String: " ; user prompt
len1:	            equ $-msg1


	        [SECTION .bss]

buf:	                resb BUFLEN ; buffer for read
newstr:	            resb BUFLEN	    ; converted string
readlen:	       resb 4 ; storage for the length of string we read

	        [SECTION .text]
	        global bookcmp
		extern book1, book2
	        global _start

	bookcmp:
	
	 	mov ebx, [book1] ;read book1
	 	mov ecx, [book2] ;read book2 
		
		push ebx
		push ecx
		push edi
		push edx
		push esi
		
		lea edi, [ebx+YEAR_OFFSET] ;get year of book1
		lea esi, [ecx+YEAR_OFFSET] ;get year of book2

		XOR ebx, ebx  
		XOR ecx, ecx
		
		mov ebx, [edi]	;holds book1 year
		mov ecx, [esi]  ;holds book2 year

		cmp ecx, ebx 	; cmp if they are equal
		je .equal
	
		cmp ecx, ebx  	; cmp if less than
		jl .lessThan

		jmp .greaterThan ; jmp if neither equal ot less than

		.lessThan:	
			mov eax, -1
			jmp .handleReg
		.greaterThan:
			mov eax, 1
			jmp .handleReg
		.equal:
			XOR ebx, ebx
			XOR ecx, ecx
			XOR edi, edi
			XOR esi, esi
	
			mov ebx, [book1] ;get book2
			mov ecx, [book2] ;get book1 
	
			lea edi, [ebx+TITLE_OFFSET] ; get book1 title
			lea esi, [ecx+TITLE_OFFSET] ; get book2 title
			XOR ebx, ebx
			XOR ecx, ecx
			.loop:
				mov dh, [edi] ;get first letter of book1 title
				mov ch, [esi] ;get first letter of book2 title
				cmp ch, dh    ;cmp letters
				jl .lessThan

				cmp ch, dh
				je .equalTitle

				cmp ch, dh
				jg .greaterThan
	
				.equalTitle: ;if first letters are equal, next letter.
					inc edi
					inc esi
					jmp .loop
			
			jmp .handleReg
		.handleReg:
			xor ebx, ebx
			xor ecx, ecx
			pop esi
			pop edx
			pop edi
			pop ecx
			pop ebx
			ret

		
	