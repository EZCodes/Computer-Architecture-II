option casemap:none             ; case sensitive
 
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

p:			mov


public gcd						; export function name


public q						; export function name

end