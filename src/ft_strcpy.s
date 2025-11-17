; char *strcpy(char *dest, const char *src);
;  char *
;  strcpy(char *dest, const char *src)
;  {
;      size_t i;
;
;      for (i = 0; src[i] != '\0'; i++)
;          dest[i] = src[i];
;      dest[i] = '\0';
;
;      return dest;
;  }

; 사용 해야하는 인자는 두개 dest, src 이 두대를 내가 사용하는 x86_64 에서는
; rdi, rsi 두개의 레지스터에서 받는다.
; errno 는 설정 할 필요가 없다. 
; 비교도 아니다. 그냥 반복문을 타고 바로 끝낼 수 있다.
; 마지막에 주소를 전해주면된다.
; 이코드는 callee save 레지터를 사용하고 복원하지 않아서 터지는 함수다
; section .text
;   global ft_strcpy

; ft_strcpy:
;   xor rax, rax
;   xor rcx, rcx
;   mov rax, rdi ; is equl char *ptr = src 
;   jmp .loop

; .loop:
;   cmp byte [rsi + rcx], 0
;   mov byte bl, [rsi + rcx]
;   mov byte [rax + rcx], bl
;   inc rcx
;   je .done
;   jmp .loop

; .done:
;   ret

section .text
  global ft_strcpy

ft_strcpy:
  xor rax, rax
  xor rcx, rcx
  xor r8, r8
  mov rax, rdi ; is equl char *ptr = src 
  jmp .loop

.loop:
  cmp byte [rsi + rcx], 0
  je .done
  mov r8b, byte [rsi + rcx]
  mov byte [rdi + rcx], r8b
  inc rcx
  jmp .loop

.done:
  mov byte [rdi + rcx], 0
  ret