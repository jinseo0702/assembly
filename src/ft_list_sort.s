; void    ft_list_sort(t_list **begin_list, int (*cmp)())
; rdi = t_list **begin_list, rsi = int (*cmp)()
;(*cmp)(list_ptr->data, list_other_ptr->data);
; bubble sort on list
; do {
;     swapped = 0;
;     prev = NULL;
;     cur = head;

;     while (cur && cur->next) {
;         next = cur->next;
;         if (cmp(cur->data, next->data) > 0) {
;             // swap(cur, next)
;             swapped = 1;
;         } else {
;             prev = cur;
;             cur = cur->next;
;         }
;     }
; } while (swapped);

extern ft_list_size
%define PTRSIZE 8
section .bss
  prev resq 1; 16 byte reserved
  cur resq 1; 16 byte reserved
  next resq 1; 16 byte reserved
  cnt resd 1; 4 byte reserved
  swapped resd 1;1 byte reserved flag

default rel
section .text
  global ft_list_sort

ft_list_sort:
  xor r8, r8
  mov r8, rdi
  mov rdi, [r8]
  call ft_list_size
  mov DWORD [rel cnt], eax ; 예외 처리 안함
  push r12
  push r13
  mov r12, r8; insert head address
  mov r13, rsi; insert function pointer address
  ;prev == NULL

.out_loop:
  mov DWORD [rel swapped], 0
  mov qword [rel prev], 0
  mov rax, [r12]
  mov [rel cur], rax
  jmp .inner_loop

.inner_loop:
  cmp qword [rel cur], 0
  jz .after_inner
  cmp qword [rel cur + PTRSIZE], 0
  jz .after_inner
  mov rax, [rel cur + PTRSIZE]
  mov [rel next], rax
  mov rdi, [rel cur]
  mov rsi, [rel next]
  mov rax, r13
  call rax
  cmp rax, 0
  jg .swap

.after_inner:
  cmp DWORD [rel swapped], 1
  jl .done
  jmp .out_loop

.swap:
  cmp qword [rel prev], 0
  je .swap_head
  mov rax, [rel next + PTRSIZE]
  mov [rel cur + PTRSIZE], rax
  mov rax, [rel next]
  mov [rel prev + PTRSIZE], rax
  mov rax, [rel cur]
  mov [rel next + PTRSIZE], rax
  mov DWORD [rel swapped], 1
  mov rax, [rel next]
  mov [rel prev], rax
  mov rax, [rel next + PTRSIZE]
  mov [rel cur], rax
  jmp .after_inner

.swap_head:
  mov rax, [rel next]
  mov [r12], rax
  mov rax, [rel next + PTRSIZE]
  mov [rel cur + PTRSIZE], rax
  mov rax, [rel cur]
  mov [rel next + PTRSIZE], rax
  mov DWORD [rel swapped], 1
  mov rax, [rel next]
  mov [rel prev], rax
  mov rax, [rel next + PTRSIZE]
  mov [rel cur], rax
  jmp .after_inner

.done:
  pop r13
  pop r12
  ret