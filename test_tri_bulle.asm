.data
msg1:   .asciz "Avant tri : "
msg2:   .asciz "\nApres tri : "

.text
main:
    # --- Affichage "Avant" ---
    la   a0, msg1
    li   a7, 4                # print_string
    ecall

    la   a0, tab              # a0 = adresse du tableau
    lw   a1, tab_len          # a1 = taille du tableau
    jal  ra, print_tab

    # --- Appel bubble_sort(tab, tab_len) ---
    la   a0, tab
    lw   a1, tab_len
    jal  ra, bubble_sort

    # --- Affichage "Apres" ---
    la   a0, msg2
    li   a7, 4
    ecall

    la   a0, tab
    lw   a1, tab_len
    jal  ra, print_tab

    # --- Sortie ---
    li   a7, 10               # exit
    ecall

# --- Dépendances ---
.include "tab.asm"
.include "print_tab.asm"
.include "swap.asm"
.include "tri_bulle.asm"
