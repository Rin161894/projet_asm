A partir d'un programme en C:
Pour générer du code plus détaillé :
riscv64-linux-gnu-gcc -S -O0 bubble.c -o bubble.s

Pour générer du code simplifié :
riscv64-linux-gnu-gcc -c -S -Os -o bubble.s bubble.c
