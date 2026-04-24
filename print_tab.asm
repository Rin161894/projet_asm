# ---------------------------------------------------------------
# print_tab(v, n) : affiche n entiers du tableau v, séparés par
#                   un espace (sans saut de ligne final).
#
#   Entrées : a0 = v  (adresse du tableau)
#             a1 = n  (nombre d'éléments à afficher)
#   Sortie  : aucune
#   Convention : ra, s0, s1 sauvés sur la pile -> appel réentrant
# ---------------------------------------------------------------
.text
print_tab:
    addi sp, sp, -12
    sw   ra, 0(sp)
    sw   s0, 4(sp)
    sw   s1, 8(sp)

    mv   s0, a0             # s0 = pointeur courant dans le tableau
    mv   s1, a1             # s1 = compteur d'éléments restants
pt_boucle:
    beqz s1, pt_fin         # plus rien à afficher ?

    lw   a0, 0(s0)          # a0 = *pointeur
    li   a7, 1              # print_int
    ecall

    la   a0, pt_sep         # a0 = " "
    li   a7, 4              # print_string
    ecall

    addi s0, s0, 4          # passe au mot suivant
    addi s1, s1, -1
    j    pt_boucle
pt_fin:
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    lw   s1, 8(sp)
    addi sp, sp, 12
    ret

.data
# Définition du séparateur pour l'affichage du tableau.
pt_sep:     .asciz " "
