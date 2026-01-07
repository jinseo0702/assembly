; typedef struct s_list
; {
;   void *data;
;   struct s_list *next;
; } t_list;
; void    ft_list_push_front(t_list **begin_list, void *data);
; rdi == t_list **begin_list
; rsi == void *data;

extern malloc, __errno_location

section .text
  global ft_list_push_front

ft_list_push_front:
  push r12
  push r13
  mov r12, rdi
  mov r13, rsi
  mov rdi, 16
  call malloc wrt ..plt
  cmp rax, 0
  jz .errcontrol
  mov QWORD [rax], r13
  mov r8, [r12]
  mov QWORD [rax + 8], r8
  mov QWORD [r12], rax
  pop r13
  pop r12
  ret

.errcontrol:
  xor r8, r8
  neg rax
  mov r8, rax
  call __errno_location wrt ..plt
  mov [rax], r8
  xor rax, rax
  pop r13
  pop r12
  ret