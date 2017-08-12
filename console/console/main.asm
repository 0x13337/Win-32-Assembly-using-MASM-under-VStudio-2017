; x86 MASM under VC++ 2017
; Hello-world "Console"

.386
.model flat, stdcall
.stack 4096

.data
	endl EQU <0dh, 0ah>							; end of line sequence

	message LABEL BYTE
	BYTE "Hello-world!", endl
	messageSize DWORD($ - message)

	HANDLE TEXTEQU <DWORD>
	; Win32 Console handles
	; predefined Win API constant
	STD_INPUT_HANDLE EQU -10
	STD_OUTPUT_HANDLE EQU -11					
	STD_ERROR_HANDLE EQU -12	

	consoleHandle HANDLE 0						; handle to standard output device
	bytesWritten  DWORD ?						; number of bytes written

GetStdHandle PROTO,               				; get standard handle
	nStdHandle:HANDLE  							; type of console handle

ExitProcess proto, 
	dwExitCode:dword

WriteConsoleA PROTO,
	hConsoleOutput:HANDLE,
	lpBuffer:PTR BYTE,
	nNumberOfCharsToWrite:DWORD,
	lpNumberOfCharsWritten:PTR DWORD,
	lpReserved:DWORD

.code
	main PROC
		; Get the console output handle :
		push	STD_OUTPUT_HANDLE
		call	GetStdHandle
		mov		consoleHandle, eax

		; Write a string to the console :
		push	0								; console output handle
		push    offset bytesWritten				; string pointer
		push    dword ptr [messageSize]			; string length
		push    offset message					; returns num bytes written
		push    dword ptr [consoleHandle]		; not used
		call	WriteConsoleA					
		
		push	0
		call	ExitProcess
	main ENDP
END main