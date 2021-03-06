section .data
    welcomeMsg      db "Hello, there", 0xa, 0xa
    lenWelcomeMsg   equ $-welcomeMsg

    userMsg         db "Write something", 0xa
    lenUserMsg      equ $-userMsg 

    dispMsg         db "You have entered: ", 0xa
    lenDispMsg      equ $-dispMsg

    tooManyChar     db "You have typed too many digits", 0xa
    lenTooManyChar  equ $-tooManyChar
section .bss
    num             resb 5

section .text
    global _start

_start:
    ;; Print welcome message
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, welcomeMsg
    mov     rdx, lenWelcomeMsg
    syscall
  
    call user_input
    
    call exit

user_input: 
    ;; Print instruction to user
    mov     rax, 1 
    mov     rdi, 1
    mov     rsi, userMsg
    mov     rdx, lenUserMsg
    syscall

    ;; Read and store user input
    mov     rax, 0
    mov     rdi, 2
    cmp     rsi, 5
    jg      errMsg
    mov     rsi, num
    mov     rdx, 5
    syscall
    

    ;; Output the message
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, dispMsg
    mov     rdx, lenDispMsg
    syscall

    ; output the number 
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, num
    mov     rdx, 5
    syscall

    ret

errMsg:
    mov     rax, 1
    mov     rdi, 1
    mov     rsi, tooManyChar
    mov     rdx, lenTooManyChar
    syscall
    call    user_input

exit:
    mov     rax, 60
    mov     rdi, 0
    syscall
