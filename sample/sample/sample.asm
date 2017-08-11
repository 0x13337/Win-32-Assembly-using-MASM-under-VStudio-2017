; x86 MASM under VC++ 2017
; Hello-world "Message Box"

.386
.model flat,stdcall
.stack 4096
MessageBoxA proto, hwnd:dword, text:dword, caption:dword, buttons:dword
ExitProcess proto, dwExitCode:dword

.data
	text        db  'Hello world!', 0
	caption     db  'Message', 0
.code
	main proc
		push 0                  ;MB_OK
		push offset caption     ;lpCaption
		push offset text        ;lpText
		push 0                  ;hWnd
		call MessageBoxA
		push 0
		call ExitProcess
	main endp
end main
