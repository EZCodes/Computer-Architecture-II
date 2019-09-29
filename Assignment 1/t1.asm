.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

.data ; start of a data section

public g ; export variable g
g DWORD 4 ; declare global variable g initialised to 4

.code


public min   ; min function export

min:	push ebp
		mov ebp, esp
		push ebx		;save ebx as its non-volatile

		mov eax, [ebp + 8]
		mov ebx, [ebp + 12]
		cmp eax, ebx
		jle else1
		mov eax, ebx
else1:  mov ebx, [ebp + 16]
		cmp eax, ebx
		jle else2
		mov eax, ebx
else2:  
		pop ebx
		mov esp, ebp
		pop ebp
		ret 0


public p   ; p function export

p:		push ebp
		mov ebp, esp
		push ebx	; save ebx as its non-volatile

		mov eax, [ebp + 8]
		mov ebx, [ebp + 12]
		mov ecx, [g]
		push ebx
		push eax
		push ecx
		call min
		add esp, 12
		mov ebx, [ebp + 16]
		mov ecx, [ebp + 20]
		push ecx
		push ebx
		push eax
		call min
		add esp, 12

		pop ebx
		mov esp, ebp
		pop ebp
		ret 0

		

public gcd   ; gcd function export 

gcd:	push ebp
		mov ebp, esp
		push ebx	; save ebx as its non-volatile

		mov eax, [ebp + 8]
		mov ebx, [ebp + 12]
		cmp ebx, 0
		je	skip
		cdq
		idiv ebx
		mov eax, edx
		push eax
		push ebx
		call gcd
		add esp, 8
skip :	
		pop ebx
		mov esp, ebp
		pop ebp
		ret 0
    
end