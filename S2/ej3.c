#include <dos.h>
#include <stdio.h>

#define BYTE unsigned char

char read_char();
void write_char(char c);

char read_char() {
    union REGS inregs, outregs;
    inregs.h.ah = 1;
    int86(0x21, &inregs, &outregs);
    return outregs.h.al;  
}

void write_char(char c) {
    union REGS inregs, outregs;
    inregs.h.ah = 2; 
    inregs.h.dl = c;  
    int86(0x21, &inregs, &outregs);
}

int main() {
    char aux; 
    printf("\n Introducir un caracter: ");
    aux = read_char(); 

    printf("\n Caracter introducido: ");
    write_char(aux);

    return 0;
}

