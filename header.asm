# header.asm : affiche un en-tête formaté pour les tests de tris.
# print_header(label, n) : affiche "label (n=X) :\n"
#
#   Entrées : a0 = label (adresse de la chaîne d'introduction)
#             a1 = n     (taille du tableau)
#   Sortie  : aucune
# ---------------------------------------------------------------
.text
print_header:
    # Prologue : réserve 2 mots sur la pile + sauvegarde
    addi sp, sp, -8        # alloue 2 mots : sauvegarde ra + s0
    sw   ra, 0(sp)         # sauve l'adresse de retour
    sw   s0, 4(sp)

    # s0 = n (taille préservée au travers des ecalls)
    # On copie n dans s0
    mv   s0, a1            # s0 = n (taille du tableau)

    # Affichage de la chaîne d'introduction (a0 contient déjà son adresse)
    li   a7, 4             # print_string
    ecall

    # Affichage de la valeur de n
    mv   a0, s0            # a0 = n
    li   a7, 1             # print_int
    ecall

    # Affichage de "\n"
    la   a0, saut_ligne
    li   a7, 4             # print_string
    ecall

    # Epilogue : restauration des registres et retour
    lw   ra, 0(sp)
    lw   s0, 4(sp)
    addi sp, sp, 8         # libère la pile
    ret                    # retour à l'appelant

.data
saut_ligne:    .asciz "\n"
