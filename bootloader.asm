; bootloader.asm
[org 0x7c00]

start:
    cli                   ; Désactiver les interruptions
    mov ax, 0x07C0        ; Charger l'adresse du bootloader en mémoire
    add ax, 288           ; Déplacer le pointeur de pile
    mov ss, ax
    mov sp, 4096

    ; Afficher un caractère à l'écran (pour tester si le bootloader fonctionne)
    mov ah, 0x0E          ; Appel du service vidéo BIOS pour afficher un caractère
    mov al, 'B'           ; Caractère à afficher
    int 0x10              ; Interruption du BIOS

    ; Charger le noyau (1 secteur) à partir du disque
    mov bx, 0x1000        ; Charger le noyau à l'adresse 0x1000
    mov ah, 0x02          ; Fonction BIOS : lire un secteur
    mov al, 1             ; Lire 1 secteur
    mov ch, 0             ; Cylindre 0
    mov dh, 0             ; Tête 0
    mov cl, 2             ; Secteur 2 (car le secteur 1 contient le bootloader)
    int 0x13              ; Appel BIOS : lecture du disque

    jmp 0x1000:0000       ; Sauter à l'adresse du noyau

times 510 - ($-$$) db 0   ; Remplir jusqu'à 510 octets
dw 0xAA55                 ; Signature du bootloader
