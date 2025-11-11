; size_t strlen(const char *s);
; in 64bit cpu size_t is 8byte
; so if you want return size_t Data Type you set rax 8byte(use 64bit)
; it'mean use origianl and Do must init 0.
; mem arch
; RAX register accumulator extended
; RBX register base extended
; RCX register Count extended
; RDX register Data extended
; RSI register Source index
; RDI register Destination index
; RSP register Stack pointer
; RBP register Base pointer
; R8~R15
section .text
  global ft_strlen

ft_strlen:
  xor rcx, rcx ; clearing register count extened now rcx is 0
  jmp .loop

.loop:
  cmp byte [rdi + rcx], 0 ; if (str[index] == '\0')
  je .done
  inc rcx
  jmp .loop

.done:
  xor rax, rax ; clearing register accumulator extended now rax is 0
  mov rax, rcx
  ret