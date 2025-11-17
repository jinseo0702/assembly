; ssize_t write(int fd, const void *buf, size_t count);
; SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf, size_t, count)
; write 만들때 내가 고려해야 할 점은 그냥 errno 를 관리를 하는점이다.
; errno 는 systemcall 음수로 들어오기 때문에 neg 로 돌려줘야한다.
; sysdeps/unix/sysv/linux/write.c
;/* Write NBYTES of BUF to FD.  Return the number written, or -1.  */
;ssize_t
;__libc_write (int fd, const void *buf, size_t nbytes)
;{
;  return SYSCALL_CANCEL (write, fd, buf, nbytes);
;}
;libc_hidden_def (__libc_write)
;
;weak_alias (__libc_write, __write)
;libc_hidden_weak (__write)
;weak_alias (__libc_write, write)
;libc_hidden_weak (write)
;
; rax 1 == write num
; rdi == fd rsi == *buf rdx == count

section .text
  global ft_write
extern __errno_location
ft_write:
  xor rax, rax
  mov rax, 1
  syscall
  test rax, rax
  js .errcontrol
  ret

.errcontrol:
  xor r8, r8
  neg rax
  mov r8, rax
  call __errno_location wrt ..plt
  mov [rax], r8
  mov rax, -1
  ret
