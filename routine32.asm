global add

section .text
add:
    mov eax, [esp + 4]
    add eax, [esp + 8]
    ret
