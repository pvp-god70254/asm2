.global write
.type write, @function

.section .text
write:
  mov x0, #0
  mov x8, #64
  svc #0
  ret
