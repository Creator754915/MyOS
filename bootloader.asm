[BITS 16]
[ORG 0x7C00]

start:
	mov ah, 0x0                ; Effacer l'écran
	mov al, 3
	int 0x10

	mov bx, HELLO_MSG          ; Mettre l'adresse de HELLO_MSG dans le registre BX
	call print_string          ; Appele de la fonction pour afficher la chaine de caractères

hang:
	jmp hang                   ; Boucle infie

times 510-($-$$) db 0          ; Remplir jusqu'à 510 octets
dw 0xAA55                      ; Signature du boot

HELLO_MSG: 
	db 'Hello, World!', 0      ; Chaine de caractères

print_string:
	mov al, [bx]
	cmp al, 0
	je done
	mov ah, 0x0E
	int 0x10
	inc bx
	jmp print_string           ; Afficher le prochain caractères

done:
	ret
