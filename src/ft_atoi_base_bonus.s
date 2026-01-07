;int ft_atoi_base(char *str, char *base)
; int
; atoi (const char *nptr)
; {
;   return (int) strtol (nptr, (char **) NULL, 10);
; }
; libc_hidden_def (atoi)
; %% 매크로 호출마다 고유하게 바뀌는 지역 라벨(Local Label)

extern ft_strlen

%macro ISSPACE 1
  cmp BYTE [%1], 0x20 ; if ([%1]  == ' ')
  je %%found ; true
  cmp BYTE [%1], 0x09 ; if ([%1]  == '\t')
  je %%found ; true
  cmp BYTE [%1], 0x0A ; if ([%1]  == '\n')
  je %%found ; true
  cmp BYTE [%1], 0x0B ; if ([%1]  == '\v')
  je %%found ; true
  cmp BYTE [%1], 0x0C ; if ([%1]  == '\f')
  je %%found ; true
  cmp BYTE [%1], 0x0D ; if ([%1]  == '\r')
  je %%found ; true
  jmp %%nfound
%%found:
  inc %1
  test %1, 0 
%%nfound:
%endmacro

%macro ISSIGN 2
  cmp BYTE [%1], 0x2D ; if ([%1]  == '-')
  je %%neg ; true
  cmp BYTE [%1], 0x2B ; if ([%1]  == '+')
  je %%pos ; true
  jmp %%end
%%neg:
  mov %2, 1 ; %2 = r15b
  inc %1
  jmp %%end
%%pos:
  inc %1
  jmp %%end
%%end:
%endmacro

%macro FINDPOS 3 ; %1 is char *str, %2 is rcx %3 is rdi find flag
  xor %2, %2
  xor %3, %3
%%loopfind:
  cmp byte [r13 + %2], 0
  je %%end
  movzx rax, byte [%1] ; 
  cmp byte [r13 + %2], al
  je %%find
  inc %2
  jmp %%loopfind
%%find:
  mov %3, 1
%%end:
%endmacro

section .text
  global ft_atoi_base
; first check base and check str
; base 체크후 -> str 체크
; base 체크 알고리즘 256 개의 배열에 base 를 한칸씩 이동하면서 넣는다.
; 배열은 ascii 코드의 값과 같다. 만약 있지 않아 야하는 값에 1이 있다면 fail
; 만약 2 중복이라면 fail 이다.
ft_atoi_base:
  push r12
  push r13
  push r14 ; return value
  push r15 ;negative flag
  push rbx ; is base
  mov r12, rdi ;r12 == char *str
  mov r13, rsi ;r13 == char *base
  xor r15, r15
  xor r14, r14
  jmp .is_valid_base

.succese:
  add rsp, 256
  mov rdi, r13
  call ft_strlen
  xor rbx, rbx
  mov rbx, rax ; base len

.is_space:
  ISSPACE r12
  jz .is_space

.is_signd:
  ISSIGN r12, r15b

.calculate:
  movzx rax, byte [r12]
  test rax, rax
  jz .check_signed
  FINDPOS r12, rcx, rdi
  test rdi, rdi ; find not in base
  jz .check_signed 
  imul r14, rbx
  add r14, rcx
  inc r12
  jmp .calculate

.check_signed:
  cmp r15, 0
  jz .done
  imul r14, -1

.done:
  mov rax, r14
  pop rbx
  pop r15
  pop r14
  pop r13
  pop r12
  ret



.is_valid_base: ; check
  sub rsp, 256
  mov rdi, rsi
  call ft_strlen
  cmp  rax, 1
  jb .error ; base is below 1
  mov rdi, rsp
  xor rcx, rcx
  mov ecx, 256
  xor rax, rax
  rep stosb ; rsp[256] 0 으로 초시화
  mov rdi, r13

.check_loop:
  movzx rax, byte [rdi]
  test al, al; *base == '\0'
  jz .succese
  cmp rax, 0x20 ; below space 
  jb .error
  cmp rax, 0x2D ; rax == '-'
  je .error
  cmp rax, 0x2D ; rax == '+'
  je .error
  cmp rax, 0x7B ; rax == 'DEL'
  je .error
  cmp byte [rsp + rax], 1
  je .error ; 중복이라면
  mov byte [rsp + rax], 1
  inc rdi
  jmp .check_loop

.error: 
  add rsp, 256
  mov r14d, 0
  jmp .done