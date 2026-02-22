.global exit

.type exit, @function

exit:
  mov x8, #93
  svc #0
