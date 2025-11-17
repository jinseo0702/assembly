; ssize_t read(int fd, void *buf, size_t count)
; sysdeps/unix/sysv/linux/write.c
; #include <unistd.h>
; #include <sysdep-cancel.h>
;
; /* Read NBYTES into BUF from FD.  Return the number read or -1.  */
; ssize_t
; __libc_read (int fd, void *buf, size_t nbytes)
; {
;   return SYSCALL_CANCEL (read, fd, buf, nbytes);
; }
; libc_hidden_def (__libc_read)
;
; libc_hidden_def (__read)
; weak_alias (__libc_read, __read)
; libc_hidden_def (read)
; weak_alias (__libc_read, read)

section .text
  global ft_read
extern __errno_location
ft_read:
  xor rax, rax
  mov rax, 0
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
