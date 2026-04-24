# ref : Patterson & Hennessy, Computer Organization and Design (RISC-V)
# bubble_sort(tab, n) : tri à bulles d'un tableau de n mots (int)
#
#   Entrées : a0 = tab   (adresse de base du tableau)
#             a1 = n     (nombre d'éléments)
#   Sortie  : a0 = tab   (même adresse, tableau trié sur place)
# ---------------------------------------------------------------
.text
bubble_sort:
    # Prologue : réserve 5 mots sur la pile + sauvegarde
    addi sp, sp, -20       # alloue 5 mots : sauvegarde ra + s3/s4/s5/s6
    sw   ra, 16(sp)        # sauve l'adresse de retour
    sw   s6, 12(sp)
    sw   s5,  8(sp)
    sw   s4,  4(sp)
    sw   s3,  0(sp)
    
    # s3 = i   (compteur de la boucle externe)
    # s4 = j   (compteur de la boucle interne)
    # s5 = tab (adresse du tableau)
    # s6 = n   (taille du tableau)
    # Chaque élément du tableau occupe 4 octets en mémoire (taille d'un mot)
    # On copie les paramètres dans les registres sauvés
    mv   s5, a0            # s5 = tab          (adresse du tableau)
    mv   s6, a1            # s6 = n            (taille du tableau)
    li   s3, 0             # i  = 0            (On initialise le compteur de la boucle externe)
    
    # Structure des deux boucles :
    #   - boucle externe : i part de 0 et augmente jusqu'à n-1. A la fin de la passe i, les i premières cases sont triées.
    #   - boucle interne : j part de i-1 et diminue jusqu'à 0, on fait "descendre" le nouvel élément vers sa place.
    # Variante de Patterson & Hennessy : contrairement au tri à bulles classique où les deux indices augmentent.
    # Ici l'indice interne décroit.
tb_boucle_ext:             # Boucle externe : i de 0 à n-1
    bge  s3, s6, tb_fin    # si i >= n  -> fin de la fonction
    addi s4, s3, -1        # j = i - 1         (On initialise le compteur de la boucle interne)

tb_boucle_int:             # Boucle interne : j de i-1 à 0
    bltz s4, tb_sortie_int # si j < 0  -> On sort de la boucle interne
    slli t0, s4, 2         # t0 = j * 4        (décalage en octets)
    add  t0, s5, t0        # t0 = &tab[j]      (t0 contient l'adresse mémoire de tab[j])
    lw   t1, 0(t0)         # t1 = tab[j]
    lw   t2, 4(t0)         # t2 = tab[j+1]
    ble  t1, t2, tb_sortie_int # si tab[j] <= tab[j+1] -> déjà trié, on passe au suivant.
    mv   a0, s5            # arg 1 de swap : tab
    mv   a1, s4            # arg 2 de swap : j
    addi a2, s4, 1         # arg 3 de swap : j+1
    jal  swap              # swap(tab, j, j+1)   (échange tab[j] et tab[j+1])
    addi s4, s4, -1        # j = j - 1 (on remonte d'une case vers le début)
    j    tb_boucle_int     # On passe à l'élément suivant de la boucle interne

tb_sortie_int:             # Sortie boucle interne
    addi s3, s3, 1         # i = i + 1
    j    tb_boucle_ext     #  On passe à l'élément suivant de la boucle externe

tb_fin:                    # Epilogue : restauration des registres et retour
    mv   a0, s5            # a0 = v            (valeur de retour)
    lw   s3,  0(sp)
    lw   s4,  4(sp)
    lw   s5,  8(sp)
    lw   s6, 12(sp)
    lw   ra, 16(sp)
    addi sp, sp, 20        # libère la pile
    ret                    # retour à l'appelant
