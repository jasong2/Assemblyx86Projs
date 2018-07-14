;; ******************************************************
;; Jason Gorelik
;; CMSC313 Assembly
;; Proj1
;;			Proj1 - ISBN Validation
;;
;; This program will check if the user input is
;; a valid ISBN number.
;; ****************************************************** 

	%define STDIN 0
	%define STDOUT 1
	%define STDERR 2
	%define SYSCALL_EXIT  1
	%define SYSCALL_READ  3
	%define SYSCALL_WRITE 4
	%define BUFLEN 256

[SECTION .data]

msg1:	   db "Enter 10 digit ISBN: "	; user prompt
len1:	   equ $-msg1	 		; length of first message

msg2:	   db "This is NOT a valid ISBN number.", 0Ah   
len2:	   equ $-msg2		                   

msg3:	   db "This is a valid ISBN number.", 0Ah     
len3:	   equ $-msg3

msg4:	   db "Invalid Number.", 0Ah
len4:	   equ $-msg4	

;; loop variables
sum:	 db '0'
t:	db '0'

	
[SECTION .bss]

buf:	         resb BUFLEN		; buffer for read
readlen:	 resb 4		        ; storage for the length of string we read

[SECTION .text]

global _start		; make start global so ld can find it

_start:

	;;  prompt for user input
	mov eax, SYSCALL_WRITE
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 80H

        ;;  read user input
	mov eax, SYSCALL_READ
	mov ebx, STDIN
	mov ecx, buf
	mov edx, BUFLEN
	int 80H
	
	;; check if string has 10 characters 
	mov [readlen], eax
	add eax, '0'
	cmp eax, 3Bh
	jl .invalidNumber
	cmp eax, 3Bh
	jg .invalidNumber
	
	;; string put into esi
	mov esi, buf

	;; sum and t put in registers

	mov ch, [sum]
	mov ah, [t]
	
	;; mov number 9 to register cl for the loop
	mov cl, 39h
	
	.loop:
	;; compare to 0. if less than, jump to done
		cmp cl, 30h	
	 	jl  .done
	
	 	mov bh, [esi]

	;; compare if bh holds Holds, jump to correct method if true
		cmp bh, 58h
		je .calcX
	
		jmp .calcT
	;; check if sum is 1 after checking for X
	 .calcX:
		add ah, 10
		sub ah, 11
	 	add ch, ah
		sub ch, '0'
		sub ch, 11
		
		cmp ch, 30h
		je .validISBN
		jmp .notValidISBN
	;; calculate T
	 .calcT:
	 	add ah, bh
		sub ah, '0'
		
	 	cmp ah, 3Bh
	 	jge .minusElevenT
		jmp .calcSum
	;; subtract 11 from T if T is greater or equal to 11
	 .minusElevenT:
	 	sub ah, 11
	 	jmp .calcSum
	;; calculate sum
	 .calcSum:
	 	add ch, ah
	 	sub ch, '0'

		cmp ch, 3Bh
	 	jge .minusElevenSum
	 	jmp .cycle
	;; subtract 11 from sum if sum is greater or equal to 11
	 .minusElevenSum:
	 	sub ch, 11
	 	jmp .cycle
	;; auto increment loop and next character
	 .cycle:
	 	add esi, 1
	 	sub cl, 1

	 	jmp .loop
	 .done:

	 cmp ch, 30h
	 je .validISBN
	 jmp .notValidISBN
	
	;; valid ISBN write method
	 .validISBN:
		 mov eax, SYSCALL_WRITE
	         mov ebx, STDOUT
	         mov ecx, msg3
	         mov edx, len3
	         int 80H
		 jmp .end
	;; not valid ISBN write method
	 .notValidISBN:
		 mov eax, SYSCALL_WRITE
	         mov ebx, STDOUT
	         mov ecx, msg2
	         mov edx, len2
	         int 80H
		 jmp .end
	
	;; not enough characters
	.invalidNumber:
		 mov eax, SYSCALL_WRITE
	         mov ebx, STDOUT
	         mov ecx, msg4
	         mov edx, len4
	         int 80H
	         jmp .end
	
.end:
;;  call sys_exit to finish things off
	  mov eax, SYSCALL_EXIT 	; sys_exit syscall
	  mov ebx, 0	      		; no error
	  int 80H		        ; kernel interrupt