;Written by Ayush Kohli and Utsav Dhungel

  ;To Do List:
  ;Instead of writing to STDOUT write to file itself
  ;Create random function to generate ramdom ASCII
  ;Try to impliment CALL and RETURN
  ;Try to make a better buffer
  ;Beautify the Code

  ;MOST IMP
  ;http://docs.cs.up.ac.za/programming/asm/derick_tut/#procedures
  ;READ ABOVE LINK

; This is reserved memory
section .bss
  buffer : resw 1 ; Reserve one byte

;Store all constants to make code more readable
section .data
SYS_EXIT equ 1
SYS_WRITE equ 4
SYS_READ equ 3
READWRITE_MODE equ 2
SYS_OPEN equ 5
KERNAL equ 0x80
FILE_FD dw -1 ; Assume it failed to open

section .text
  global _start ; To keep linker happy :)

;Exit Procedure
  exit:
   mov eax, SYS_EXIT
   mov ebx, 0 ; EXIT STATUS FOR SUCESS
   int KERNAL

   EXITFALIURE:
      mov eax,SYS_EXIT
      mov ebx,1
      int KERNAL

;
  _start:

   pop ebx
   ;add ebx,'0'\
   cmp ebx,2
   je EXITFALIURE

  ; pop ebx ;ARGC Value gets popped off the stack
   pop ebx ;ARGV[0] gets popped off the stack
   pop ebx ;ARGV[1] gets popped off the stack
  jmp open ; goto open



;open(argv[1],O-RDWR);
  open:
   mov eax, SYS_OPEN
   mov ecx, READWRITE_MODE
   int KERNAL ; LINUX magically does its thing
   test eax,eax ; Dont destroy value of eax because that is the fd
   mov dword [FILE_FD], eax
   jns read ; If there is no error (-1) then go to read

  ; ret

;read(eax,*buff,1)
  read:
   mov ebx, 3 ; Hardcoded fd, ; NEED TO CHANGE

   mov eax, SYS_READ
   mov ecx, buffer
   mov edx, 1
   int KERNAL
   cmp eax, 0 ; 0 gets returned if read did not return anything
   je exit ; if eax == 0 exit
  ; jmp write ;else write

  write:
  movzx eax,byte [buffer];
  push eax
  call xxx
  mov [buffer],al
  ;or byte [buffer], 0x20
  
   mov ebx, 1 ; FD writing to STDOUT for now
   mov eax, SYS_WRITE ; Action to perform
   ;mov byte [buffer],cl
   mov ecx, buffer ;what to write to
   ;mov dword [buffer],ch;
   ;ov dword [buffer + 1], cl
  ; mov byte [buffer],
   mov edx, 1 ; sizeof(buffer)

   int KERNAL ; Linux does the magic
   jmp read ; Unconditinal jump to read to continue loop

  ;rand: Need to generate random character
