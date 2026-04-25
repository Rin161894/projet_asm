.data
algo:        .asciz "Algorithme de tri à bulles, taille tableau : "
msg1:        .asciz "Avant tri : \n"
msg2:        .asciz "\nAprès tri : \n"

.text
main:
    li   s7, 1 # Affiche (1) ou n'affiche pas (0) l'algorithme et la taille du tableau
    li   s8, 0 # Affiche (1) ou n'affiche pas (0) les tableaux

    beqz s7, no_header
    # Affichage des informations concernant le tri.
    la   a0, algo
    lw   a1, tab_len
    jal  ra, print_header

no_header:
    beqz s8, no_tab1
    # Affichage du tableau original 
    la   a0, msg1
    li   a7, 4                # print_string
    ecall

    la   a0, tab              # a0 = adresse du tableau
    lw   a1, tab_len          # a1 = taille du tableau
    jal  ra, print_tab        # Impression du tableau

no_tab1:
    # --- Appel bubble_sort(tab, tab_len) ---
    la   a0, tab
    lw   a1, tab_len
    jal  ra, bubble_sort

    beqz s8, no_tab2

    # Affichage du tableau trié 
    la   a0, msg2
    li   a7, 4
    ecall

    la   a0, tab
    lw   a1, tab_len
    jal  ra, print_tab

no_tab2:
    # --- Sortie ---
    li   a7, 10               # exit
    ecall

# --- Dépendances ---
.include "tab.asm"
.include "header.asm"
.include "print_tab.asm"
.include "swap.asm"
.include "tri_bulle.asm"
