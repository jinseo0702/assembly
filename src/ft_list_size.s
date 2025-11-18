; int     ft_list_size(t_list *begin_list)
; typedef struct s_list
; {
;   void *data; 
;   struct s_list *next;
; } t_list;
; rdi == t_list *begin_list

section .text
  global ft_list_size

%define PTRSIZE 8

ft_list_size:
  xor rcx, rcx
  xor rax, rax
  mov rax, rdi

.loop:
  cmp qword [rax + PTRSIZE], 0
  jz .done
  mov rax, [rax + PTRSIZE]
  inc rcx
  jmp .loop

.done:
  mov rax, rcx
  ret

