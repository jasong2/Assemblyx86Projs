;; ;  **************************************************************
;;; ;  Jason Gorelik
;;; ;  Email: jasong2@umbc.edu
;;; ;  CMSC313 Assembly
;;; ;  Proj2
;;; ;                       Proj2 - Escape Seqs
;;; ;
;;; ;  This program takes a string and converts it using escape seq.
;;; ;  ***************************************************************

	        %define STDIN 0
	        %define STDOUT 1
	        %define STDERR 2
	        %define SYSCALL_EXIT  1
	        %define SYSCALL_READ  3
	        %define SYSCALL_WRITE 4
	        %define BUFLEN 256

	[SECTION .data]

msg1:	      db "Enter String: "; user prompt
len1:	      equ $-msg1

msg2:	      db "Original: "; your string
len2:	      equ $-msg2

msg3:	      db 10, "Convert: "; converted string
len3:	      equ $-msg3

msg4:	      db "Unknown escape sequence: " ;error message
len4:	      equ $-msg4

msg5:	      db 10, "Ocatal value overflow in: " ; error messeage
len5:	      equ $-msg5


table:        db 7, 8, -1, -1, -1, 12, -1, -1, -1, -1, -1, -1, -1, 10, -1, -1, -1, 13, -1, 9, -1, 11, -1, -1, -1, -1

	[SECTION .bss]

buf:	     resb BUFLEN	; buffer for read
newstr:	  resb BUFLEN		; converted string
readlen:	 resb 4         ; storage for the length of string we read
errorstr:	 resb BUFLEN
unknown:	resb BUFLEN
	
	[SECTION .text]

	global _start	; globalstart

_start:

;;; ;  prompt
	        mov eax, SYSCALL_WRITE
	        mov ebx, STDOUT
	        mov ecx, msg1
	        mov edx, len1
	        int 80H

;;; ;  read user input
	        mov eax, SYSCALL_READ
	        mov ebx, STDIN
	        mov ecx, buf
	        mov edx, BUFLEN
		mov [ecx + edx-1], byte 0
 	        int 80H

		mov [readlen], eax
		sub eax, 1
			
		mov esi, buf
		mov edi, newstr	 	
;; string loop started
		.loop:

			cmp eax, 0
			je .done
	
			mov bh, [esi]
	
			cmp bh, 5Ch
			je .handle
			mov [edi], bh
			inc esi
			inc edi
			dec eax
			jmp .loop
	
		.handle:
			call handle_ESQ
			jmp .loop
	
		.done:
		mov eax, SYSCALL_WRITE
	        mov ebx, STDOUT
	        mov ecx, msg2
	        mov edx, len2
	        int 80H
	
		mov eax, SYSCALL_WRITE
	        mov ebx, STDOUT
	        mov ecx, buf
	        mov edx, [readlen]
	        int 80H

		mov eax, SYSCALL_WRITE
	        mov ebx, STDOUT
	        mov ecx, msg4
	        mov edx, len4
	        int 80H

		mov eax, SYSCALL_WRITE
	        mov ebx, STDOUT
	        mov ecx, unknown
	        mov edx, 5
	        int 80H
	

		mov eax, SYSCALL_WRITE
	        mov ebx, STDOUT
	        mov ecx, msg5
	        mov edx, len5
	        int 80H
	
		mov eax, SYSCALL_WRITE
	        mov ebx, STDOUT
	        mov ecx, errorstr
	        mov edx, 5
	        int 80H
	
	
         	mov eax, SYSCALL_WRITE
	        mov ebx, STDOUT
	        mov ecx, msg3
	        mov edx, len3
	        int 80H
	
		mov eax, SYSCALL_WRITE
		mov ebx, STDOUT
		mov ecx, newstr
		mov edx, 100
		int 80H
	.end:
;; Exit
	        mov eax, SYSCALL_EXIT 
	        mov ebx, 0            
	        int 80H             


;;Handle subroutine 
	handle_ESQ:
		
		mov ch, [esi] 	
	        inc esi
		
		mov bh, [esi]  
		dec eax
		jmp .checkOctal	; jump to check octal 
;;; ocatal digit check
	.checkOctal:
		cmp bh, '7'
	        jg .lowercaseCheck
	        cmp bh, '0'
	        jl .lowercaseCheck
	
		mov cl, 0
		mov dh, 3 	
		jmp .convertOctal
;;; lowercase handle
	.lowercaseCheck:
		cmp bh, 5Ch 	;check for slash
		je .slashHandle
		cmp bh, 'a'
		jl .unknownEscape ;unknown escape jump
		cmp bh, 'z'
		jg .unknownEscape
	
		sub bh, 97
		mov cl, 0
		movzx ebx, bh
		mov cl, [table + ebx]
		cmp cl, -1
		je .badIndex
		dec eax
 		inc esi
		
		jmp .done
;;; handle slash
	.slashHandle:
		mov cl, bh
		inc esi
		jmp .done
;;; conert to octal
	.convertOctal:
		
		sub bh, '0'
		mov bl, cl
	 	shl cl, 3

		cmp cl, bl
		jl .overflowError
	
	 	add cl, bh
	
		inc esi
		mov bh, [esi]
	
		dec eax
		cmp bh, 5Ch
	        je .done	
	
		cmp bh, '7'
		jg .done
		cmp bh, '0'
		jl .done
	
		dec dh
	
		cmp dh, 0	;loop comparison
	        je .done
		
		jmp .convertOctal
;;; overflow handle
	.overflowError:
		mov cl, ch
		sub esi, 3
		mov ch, [esi]
		mov ebp, errorstr
		mov [ebp], ch
		inc esi
		inc ebp
		mov ch, [esi]
		mov [ebp], ch
		inc esi
		inc ebp
		mov ch, [esi]
		mov [ebp], ch
		inc esi
		inc ebp
		mov ch, [esi]
		mov [ebp], ch
		inc esi

		mov [edi], cl
		inc edi
		jmp .loopReturn
;;; unknown escape sequence
	.unknownEscape:
		mov cl, ch
		mov ebp, 0
		mov ebp, unknown
		sub esi, 1
		
	 	mov ch, [esi]
	 	mov [ebp], ch
	 	inc esi
		inc ebp
		mov ch, [esi]
		mov [ebp], ch

		
		inc esi
		dec eax
	 	mov [edi], cl
		inc edi
		jmp .loopReturn
;;; -1 from table handle
	.badIndex:
		mov cl, ch
		inc esi
		jmp .done
;;; loop return exit
	.loopReturn:
		ret
;;;  loop return exit
	.done:
	 	mov [edi], cl
		inc edi
		
		ret

	
	          
	                
	