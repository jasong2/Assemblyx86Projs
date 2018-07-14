;;;  ;  **************************************************************
;;; ; ;  Jason Gorelik
;;; ; ;  Email: jasong2@umbc.edu
;;; ; ;  CMSC313 Assembly
;;; ; ;  Proj3
;;; ; ;                       Proj3
;;; ; ;	 File: prt_dec.asm
;;; ; ;  Print decimal Subroutine
;;; ; ;  ***************************************************************


		 %define STDIN 0
	         %define STDOUT 1
	         %define STDERR 2
	         %define SYSCALL_EXIT  1
	         %define SYSCALL_READ  3
	         %define SYSCALL_WRITE 4
	         %define BUFLEN 256
SECTION .data

msg1:	         db "Enter String: " ; user prompt
len1:	         equ $-msg1
count:	db '0'

	[SECTION .bss]

buf:	            resb BUFLEN	; buffer for read
newstr:		   resb BUFLEN ; converted string
readlen:	         resb 4	; storage for the length of string we read
decimal:	 resb 4

	[SECTION .text]
	global prt_dec
	global _start


	
	prt_dec:
		push eax
		push ebx
		push ecx
		push edx
		push esi

		mov esi, newstr	;esi refreences newstr
		mov ebx, count  ;counter for length
		;; start at end of esi
	 	add esi, 9
		
	
		mov ecx, 10 	;move 10 into edx for dividened
	
		add esp, 24	;memory location of number
		mov eax,[esp]	;put number in eax

		.loop:
			inc ebx
			mov edx, 0	;move 0 into edx
			div ecx		;div by ecx(10)
			add edx, 48	;convert to number
			mov [esi], dl ;mov remaineder into esi(newstr)
	
			sub esi, 1	;sub esi by 1
	
			cmp eax, 0     ;compare eax to quotient
			je .done

			jmp .loop
		.done:
		;;; print newstr
	
	 	mov eax, SYSCALL_WRITE
	 	mov ebx, STDOUT
	 	mov ecx, newstr
		mov edx, [count]
	 	int 080h

		
		;;;;;clear memory in newstr
		
		AND Dword[newstr], 0h
		AND dword[esi], 0h
		inc esi
		AND dword[esi], 0h
		inc esi
		AND dword[esi], 0h
		inc esi
		AND dword[esi], 0h
		inc esi
		AND dword[esi], 0h
		inc esi
		AND dword[esi], 0h
		inc esi
		AND dword[esi], 0h
		
	
		sub esp, 24 
		pop esi
		pop edx
		pop ecx
		pop ebx
		pop eax
		
		ret
