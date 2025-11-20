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
;           swap(cur, swap)
;         } else {
;             prev = cur;
;             cur = cur->next;
;         }
;     }
; } while (swapped);
;****************************************************************************
;void swap(int sawp, t_list *prev, t_list *cur, t_list *next, t_list **head){
;  swap = 1;
;  if (prev == NULL){
;    *head = next;
;  }
;  else{
;    prev->next = next;
;  }
;  cur->next = next->next;
;  next->next = cur;
;  prev = next;
;}
;****************************************************************************
;****************************************************************************
;void swap(){
;  //분기가 처음인경우
;  next = cur->next;
;  if (prev == NULL){
;    head = next;
;  }
;  else{
;    prev->next = next;
;  }
;  cur->next = next->next;
;  next->next = cur;
;  prev = next;
;}
;****************************************************************************

extern ft_list_size
%define PTRSIZE 8

%macro LOAD_NODE 2
  mov %1, [%2]
%endmacro

%macro LOAD_NODE_RESERVED 2
  mov [%1], %2
%endmacro


%macro LOAD_DATA_PAIR 2
  xor rdi, rdi
  xor rsi, rsi
  mov rdi, [%1]
  mov rdi, [rdi]
  mov rsi, [%2]
  mov rsi, [rsi]
  mov rax, r13
  call rax
%endmacro

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
  push r12
  push r13
  push rbx
  push r14
  xor r14, r14
  xor r8, r8
  mov r8, rdi
  mov rdi, [r8]
  call ft_list_size
  mov DWORD [rel cnt], eax ; 예외 처리 안함
  mov r12, r8; insert head address
  mov r13, rsi; insert function pointer address
  ;prev == NULL

.out_loop:
  inc r14
  mov DWORD [rel swapped], 0
  mov qword [rel prev], 0
  LOAD_NODE rax, r12
  LOAD_NODE_RESERVED rel cur, rax

.inner_loop:
  LOAD_NODE rbx, rel cur ;if(cur) check : rbx = cur
  test rbx, rbx
  jz .after_inner
  LOAD_NODE rax, rbx + PTRSIZE ; rax = cur->next
  test rax, rax ;if(cur->next) check
  jz .after_inner
  LOAD_NODE_RESERVED rel next, rax ; next = rax(cur->next)
  LOAD_DATA_PAIR rel cur, rel next
  cmp eax, 0
  jg .swap_condition

.no_swap:
    LOAD_NODE_RESERVED rel prev, rbx ; prev = cur;
    LOAD_NODE rax, rel next
    LOAD_NODE_RESERVED rel cur, rax
    jmp .inner_loop

.after_inner:
  cmp DWORD [rel swapped], 0
  je .done
  jmp .out_loop

.swap_condition:
  LOAD_NODE rbx, rel cur
  LOAD_NODE rcx, rel next
  mov DWORD [rel swapped], 1
  cmp qword [rel prev], 0
  je .swap_head
  LOAD_NODE rax, rel prev ; rax = prev
  LOAD_NODE_RESERVED rax + PTRSIZE, rcx ;prev->next = next
  jmp .swap_list

.swap_head:
  LOAD_NODE_RESERVED r12, rcx ; *head = next 
  jmp .swap_list

.swap_list:
  LOAD_NODE rax, rcx + PTRSIZE ; rax -> next->next
  LOAD_NODE_RESERVED rbx + PTRSIZE, rax ; cur->next = next->next;
  LOAD_NODE_RESERVED rcx + PTRSIZE, rbx ; next->next = cur;
  LOAD_NODE_RESERVED rel prev, rcx ;prev = next;
  jmp .inner_loop

.done:
  pop r14
  pop rbx
  pop r13
  pop r12
  ret