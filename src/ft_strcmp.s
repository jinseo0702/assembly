; int	ft_strcmp(const char *s1, const char *s2)
; {
; 	unsigned char	*s11;
; 	unsigned char	*s22;
;
; 	s11 = (unsigned char *)s1;
; 	s22 = (unsigned char *)s2;
; 	while ((*s11 || *s22))
; 	{
; 		if (*s11 != *s22)
; 			return (*s11 - *s22);
; 		s22++;
; 		s11++;
; 	}
; 	return (0);
; }

; arg1 -> rdi arg2 -> rsi
; Short Circuit
; test keyword is change flag
;0, if the s1 and s2 are equal;
;a negative value if s1 is less than s2;
;a positive value if s1 is greater than s2.

; | s1 | s2 | 케이스 코드 | 의미                       | 결과         |
; | ---| ---| ---       | ---                       | ---         |
; | 0  | 0  | 00        | 둘 다 끝                   | equal(0)     |
; | 0  | 1  | 01        | s1 먼저 종료                | s1 < s2     |
; | 1  | ?  | 11        | s1이 문자 → s2 상태 따라 처리 | 반복 or diff |


section .text
  global ft_strcmp

ft_strcmp:
.loop:
  mov al, [rdi]
  mov dl, [rsi]
  cmp al, dl ; left - right  case pos neg 0
  jne .diff

  test al, al
  je .equal
  inc rdi
  inc rsi
  jmp .loop


.diff:
  movzx eax, al
  movzx edx, dl
  sub eax, edx
  ret

.equal:
  xor rax, rax
  ret


