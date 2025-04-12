[BITS 16]
[ORG 0x7C00]

start:
    mov ah, 0x0     ; Changer le mode vidéo (efface l'écran)
    mov al, 0x03
    int 0x10

    mov si, HELLO_MSG
.print:
    lodsb
    cmp al, 0
    je .done
    mov ah, 0x0E
    int 0x10
    jmp .print

.done:
    jmp $

HELLO_MSG:
    db "Bienvenue sur MyOS V1 !", 0

times 510-($-$$) db 0
dw 0xAA55
