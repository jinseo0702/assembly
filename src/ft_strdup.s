; glibc/string/strdup.c
;  char *strdup(const char *s)
; /* Duplicate S, returning an identical malloc'd string.  */
; char *
; __strdup (const char *s)
; {
;   size_t len = strlen (s) + 1;
;   void *new = malloc (len);

;   if (new == NULL)
;     return NULL;

;   return (char *) memcpy (new, s, len);
; }
; rdi == const char *s

extern malloc, __errno_location
extern ft_strlen, ft_strcpy

section .text
  global ft_strdup

ft_strdup:
  xor rax, rax
  xor r9, r9
  mov r9, rdi 
  call ft_strlen
  inc rax
  mov rdi, rax
  call malloc wrt ..plt
  cmp rax, 0
  jz .errcontrol
  mov rdi, rax
  mov rsi, r9
  call ft_strcpy
  ret

.errcontrol:
  xor r8, r8
  neg rax
  mov r8, rax
  call __errno_location wrt ..plt
  mov [rax], r8
  xor rax, rax
  ret

