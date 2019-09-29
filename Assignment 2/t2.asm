option casemap:none             ; case sensitive

includelib legacy_stdio_definitions.lib
extrn printf:near

.data ; start of a data section

public g	; export variable g
g QWORD 4	; declare global variable g initialised to 4

fxp2 db		'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n', 0AH, 00H

fqns db		'qns\n', 0AH, 00H
 
.code


public  min                      ; export function name

min:	    mov     rax, rcx        ; 
            cmp     rax, rdx        ;
            jle     skip1           ;
            mov     rax, rdx        ; 
skip1:      cmp     rax, r8         ; 
            jle     skip2		    ;
            mov     rax, r8         ; 
skip2:		ret						;
			
public p						; export function name

p:			push	rbx
			push	r12
			mov		rbx, r8		; save parameter to non-volatile
			mov		r12, r9		; save parameter to non-volatile
			mov		r8, rdx
			mov		rdx, rcx
			mov		rcx, [g]    ;
			sub		rsp, 32		; shadow space
			call	min			;
			add		rsp, 32
			mov		rcx, rax
			mov		rdx, rbx
			mov		r8,  r12
			sub		rsp, 32
			call	min
			add		rsp, 32

			pop r12
			pop rbx
			ret 


public gcd						; export function name

gcd:		cmp		rdx, 0
			je		skip

			mov		rax, rcx		; mov a for div
			mov		rcx, rdx		; copy b to a so div wont mess up
			cdq
			idiv	rcx				; div by b
			sub		rsp, 32			; alloc shadow space
			call	gcd
			add		rsp, 32

skip:		mov		rax, rcx
			ret

			
public q						    ; export function name

 q:			push	rbx			    ; save rbx
			mov		rax, [rsp+48]   ; rax = e
			add		rax, rcx
			add		rax, rdx
			add		rax, r8
			add		rax, r9			; rax = sum
			mov		rbx, rax		; save sum
			mov		r10, [rsp+48]   ; r10 = e;
			push	rax				; sum
			push	r10				; e
			push	r9				; d
			mov		r9, r8
			mov		r8, rdx
			mov		rdx, rcx
			lea		rcx, fxp2	; the string
			sub		rsp, 32
			call	printf
			add		rsp,56
			mov		rax, rbx

			pop		rbx
			ret

public qns							; export function name

qns:		lea		rcx, fqns
			;sub		rsp, 32
			call	printf
			;add		rsp, 32
			mov		rax, 0
			ret


end