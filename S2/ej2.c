#include <dos.h>
#define BYTE unsigned char

void video_mode (BYTE modo){
    union REGS inregs, outregs;
    inregs.h.ah = 0x00;
    inregs.h.al = modo;
    int86(0x10,&inregs, &outregs);
    return;
}

void pause(){
    union REGS inregs, outregs;
    inregs.h.ah = 1;
    int86(0x21, &inregs, &outregs);
}

int main(){
    video_mode(3); // Texto 80x25-16Cotones
    printf("\nPulsa una tecla: ");

    pause();
    
    video_mode(4); // Grafico 320x200 4Colores
    printf("\nPulsa una tecla para finalizar");
    
    pause();
    video_mode(3); // Texto 80x25-16Cotones
    return 0;
}