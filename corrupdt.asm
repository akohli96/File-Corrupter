section .bss
  buffer : resb 1 ; Reserve one byte
section .text
  global _start ; To keep linker happy :)

  L1:
    mov ebx, 1 ; FD writing to STDOUT for now
    mov eax, 4 ; Action to perform
    mov ecx, buffer ;what to write to
    mov edx, 1 ; sizeof(buffer)
    int 0x80 ; Linux does the magic

  _start:
  	mov ax,0x6789
    cmp ah,al
    jl L1

    mov eax,1
    int 0x80


;;jb true
; ja false
; jg true
; jl false
; jc true
