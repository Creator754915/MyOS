/* Interface graphique kernel.c */
#define VIDEO_MEMORY 0xb8000
#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25
#define WHITE_ON_BLACK 0x07

int cursor_x = 35;  // Position du curseur dans le carré (x => horizontale)
int cursor_y = 12;  // Position du curseur dans le carré (y => verticale)

void clear_screen() {
    char *video_memory = (char *)VIDEO_MEMORY;  // Récupérer l'adresse de la mémoire vidéo avec un pointeur
    for (int i = 0; i < SCREEN_WIDTH * SCREEN_HEIGHT * 2; i += 2) {
        video_memory[i] = ' ';
        video_memory[i + 1] = WHITE_ON_BLACK;
    }
}

void draw_square() {
    char *video_memory = (char *)VIDEO_MEMORY;

    // Dessiner un carré au centre de l'écran (10x5)
    for (int y = 10; y < 15; y++) {
        for (int x = 30; x < 50; x++) {
            int offset = (y * SCREEN_WIDTH + x) * 2;
            if (y == 10 || y == 14 || x == 30 || x == 49) {
                video_memory[offset] = '#';  // Bords du carré (plein)
            } else {
                video_memory[offset] = ' ';  // Intérieur du carré (vide)
            }
            video_memory[offset + 1] = WHITE_ON_BLACK;
        }
    }
}

void put_char(char c) {
    int offset = (cursor_y * SCREEN_WIDTH + cursor_x) * 2;
    char *video_memory = (char *)VIDEO_MEMORY;

    video_memory[offset] = c;
    video_memory[offset + 1] = WHITE_ON_BLACK;

    cursor_x++;
    if (cursor_x > 48) {
        cursor_x = 35;
        cursor_y++;
    }
}

void kmain() {
    clear_screen();
    draw_square();

    // Exemple d'écriture dans le carré
    put_char('H');
    put_char('e');
    put_char('l');
    put_char('l');
    put_char('o');
    // Affiche sur l'écran => H e l l o
}
