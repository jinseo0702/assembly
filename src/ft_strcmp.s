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

se

section .text
  global ft_strcmp

ft_strcmp:
  xor rax, rax
  xor rcx, rcx
  xor r8, r8

  jmp .loop

.loop:
  mov r8, byte [rdi + rcx]
  cmp r8, r8

  cmp 

.done
  ret
