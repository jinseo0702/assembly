;void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));


; void ft_list_remove_if(void *data_ref, t_list **head){
;   t_list *node = *head;
;   t_list *prev = NULL;
;   t_list *cur;
;   t_list *next;
;   while(node){
;     cur = node;
;     next = cur->next;
;     if(cmp(cur->data, (char *)data_ref) == 0){
;       if (prev == NULL) {
;         *head = next;
;       }
;       else{
;         prev->next = next;
;       }
;       free_fct(cur->data);
;       node = next;
;       free(cur);
;     }
;     else{
;       prev = node;
;       node = next;
;     }
;   }
; }


extern free

%define PTRSIZE 8

%macro LOAD_NODE 2
  mov %1, [%2]
%endmacro

%macro LOAD_NODE_RESERVED 2
  mov [%1], %2
%endmacro

%macro LOAD_NODE_VALUE 2
  mov %1, %2
%endmacro


%macro LOAD_DATA_PAIR 1
  xor rdi, rdi
  xor rsi, rsi
  mov rdi, [%1]
  mov rdi, [rdi]
  mov rsi, r13
  mov rax, r14
  call rax
%endmacro

section .bss
  node resq 1; 16 byte reserved
  prev resq 1; 16 byte reserved
  cur resq 1; 16 byte reserved
  next resq 1; 16 byte reserved

default rel

section .text
  global ft_list_remove_if

ft_list_remove_if:
  push r12
  push r13
  push r14
  push rbx
  LOAD_NODE_VALUE r12, rdi ; t_list **begin_list
  LOAD_NODE_VALUE r13, rsi ; void *data_ref
  LOAD_NODE_VALUE r14, rdx ; int (*cmp)()
  LOAD_NODE_VALUE rbx, rcx ; void (*free_fct)(void *)
  LOAD_NODE rax, r12 ; rax = *begin_list
  LOAD_NODE_RESERVED rel node, rax ; t_list *node = *head
  mov qword [rel prev], 0 ; t_list *prev = NULL

.loop:
  cmp qword [rel node], 0
  je .done
  LOAD_NODE rax, rel node ; rax = node
  LOAD_NODE_RESERVED rel cur, rax; cur = node
  LOAD_NODE rcx, rax + PTRSIZE ; rcx = cur->next
  LOAD_NODE_RESERVED rel next, rcx; next = cur->next
  LOAD_DATA_PAIR rel cur
  cmp rax, 0 ; return value is == 0
  je .delete_check
  LOAD_NODE rcx, rel node ; rcx = node
  LOAD_NODE_RESERVED rel prev, rcx ; prev = node
  LOAD_NODE rax, rel next ; rax = next
  LOAD_NODE_RESERVED rel node, rax ; node = next
  jmp .loop

.delete_check:
  cmp qword [rel prev], 0
  je .delete_head
  LOAD_NODE rax, rel prev ; rax = prev
  LOAD_NODE rcx, rel next; rcx = next
  LOAD_NODE_RESERVED rax + PTRSIZE, rcx ; prev->next = next;
  jmp .delete

.delete_head:
  LOAD_NODE rax, rel next
  LOAD_NODE_RESERVED r12, rax
  jmp .delete
  

.delete:
  LOAD_NODE rax, rel cur ; rax = cur
  LOAD_NODE rdi, rax
  LOAD_NODE_VALUE rax, rbx
  call rax ; free_fct(cur->data);
  LOAD_NODE rax, rel node ; rax = node
  LOAD_NODE rcx, rel next ; rcx = next
  LOAD_NODE_RESERVED rel node, rcx ; node = next
  LOAD_NODE rax, rel cur ; rax = cur
  LOAD_NODE_VALUE rdi, rax
  call free wrt ..plt ; free(cur);
  jmp .loop




.done:
  pop rbx
  pop r14
  pop r13
  pop r12
  ret
