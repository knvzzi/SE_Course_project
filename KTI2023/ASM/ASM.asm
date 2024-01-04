.586
.model flat, stdcall
includelib ..\Debug\StandartLib.lib
includelib kernel32.lib
includelib libucrt.lib

ExitProcess PROTO : DWORD
copystr PROTO : DWORD, : DWORD
joinst PROTO : DWORD, : DWORD
outstr PROTO : DWORD
outint PROTO : SDWORD 
.stack 4096
.const
	overflow db 'ERROR: VARIABLE OVERFLOW', 0 
	null_division db 'ERROR: DIVISION BY ZERO', 0
	L1 SDWORD 5
	L2 SDWORD 1
	L3 BYTE " chisla ", 0
	L4 BYTE " fibonachi ", 0
	L7 BYTE " chislo ", 0
	L8 BYTE " other ", 0
	L9 SDWORD 9
	L10 SDWORD 3
	L11 SDWORD 0
.data
	Funcx SDWORD 0
	Funcprev SDWORD 0
	Funccur SDWORD 0
	Functemp SDWORD 0
	majorrez SDWORD 0
	majorother SDWORD 0
	majorm BYTE 255 DUP(0)
	majorn BYTE 255 DUP(0)
	majorq BYTE 255 DUP(0)
	majore BYTE 255 DUP(0)
	majors BYTE 255 DUP(0)
	majoroct SDWORD 0
	majorbin SDWORD 0
.code

Func_proc PROC, Funcp : SDWORD, Funcc : SDWORD
	push Funcp
	pop Funcprev
	push Funcc
	pop Funccur
	CYCLE: 
	push Funccur
	pop Functemp
	push Functemp
	push Funcprev
	pop eax
	pop ebx
	add eax, ebx
	jo EXIT_OVERFLOW
	push eax
	pop Funccur
	push Functemp
	pop Funcprev
	push Funcx
	push L2
	pop eax
	pop ebx
	add eax, ebx
	jo EXIT_OVERFLOW
	push eax
	pop Funcx
	cmp eax,L1
	jg NEXTL
	je NEXT
	loop CYCLE
	NEXTL:
	push L1
	NEXT:
	push Funccur
	pop eax
	ret 8


	jmp EXIT
	EXIT_DIV_ON_NULL:
	push offset null_division
	call outstr
	push - 1
	call ExitProcess

	EXIT_OVERFLOW:
	push offset overflow
	call outstr
	push - 2
	call ExitProcess

	EXIT:
	pop eax
	ret 0

Func_proc ENDP

main PROC
	push offset L3
	push offset majorm
	call copystr

	push offset L4
	push offset majorn
	call copystr

	push offset majorm
	push offset majorn
	call joinst
	push eax
	push offset majorq
	call copystr

	push offset majorq
	call outstr

	push L2
	push L2
	call Func_proc
	push eax
	pop majorrez
	push majorrez
	call outint

	push offset L7
	push offset majorn
	call copystr

	push offset L8
	push offset majorm
	call copystr

	push offset majorm
	push offset majorn
	call joinst
	jo EXIT_OVERFLOW
	push eax
	push offset majorq
	call copystr

	push offset majorq
	call outstr

	push L9
	pop majoroct
	push majoroct
	push majorrez
	pop eax
	pop ebx
	add eax, ebx
	jo EXIT_OVERFLOW
	push eax
	pop majorother
	push majorother
	call outint

	push offset majorm
	push offset majore
	call copystr
	push eax
	push offset majors
	call copystr

	push offset majors
	call outstr

	push L10
	pop majorbin
	push majorbin
	push majorrez
	pop eax
	pop ebx
	add eax, ebx
	jo EXIT_OVERFLOW
	push eax
	pop majorother
	push majorother
	call outint

	push L11
	push 0
	call ExitProcess


	jmp EXIT
	EXIT_DIV_ON_NULL:
	push offset null_division
	call outstr
	push - 1
	call ExitProcess

	EXIT_OVERFLOW:
	push offset overflow
	call outstr
	push - 2
	call ExitProcess

	EXIT:
	push 0
	call ExitProcess

main ENDP
end main