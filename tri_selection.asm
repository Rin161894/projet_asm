# ref : https://fr.wikipedia.org/wiki/Tri_par_s%C3%A9lection
# selection_sort(v, n) : tri par sélection d'un tableau de n mots (int)
#
#   Entrées : a0 = tab (adresse de base du tableau)
#             a1 = n   (nombre d'éléments du tableau)
#   Sortie  : a0 = tab (même adresse, tableau trié sur place)
# ---------------------------------------------------------------
.text
selection_sort:
    # Prologue : réserve 5 mots sur la pile + sauvegarde
    addi sp, sp, -20       # alloue 5 mots : sauvegarde ra + s3/s4/s5/s6
    sw   ra, 16(sp)        # sauve l'adresse de retour
    sw   s6, 12(sp)
    sw   s5,  8(sp)
    sw   s4,  4(sp)
    sw   s3,  0(sp)
    
    # s3 = i (compteur de la boucle externe)
    # s4 = j (compteur de la boucle interne)
    # s5 = tab (adresse du tableau)
    # s6 = n (taille du tableau)
    # Chaque élément du tableau occupe 4 octets en mémoire (taille d'un mot)
    # On copie les paramètres dans les registres sauvés
    mv   s5, a0            # s5 = tab          (adresse du tableau)
    mv   s6, a1            # s6 = n            (taille du tableau)
    li   s3, 0             # i  = 0            (On initialise le compteur de la boucle externe)
    
    # Structure des deux boucles :
    #   - boucle externe : i part de 0 et augmente jusqu'à n-1
    #   - boucle interne : j part de i+n et avant jusqu'à n
    # t3 = &min (indice du min en cours) ou min_idx
tsel_boucle_ext:             # Boucle externe : i de 0 à n-1
    bge  s3, s6, tsel_fin    # si i >= n  -> fin de la fonction
    mv t3, s3                   # On stocke i dans le minimum
    addi s4, s3, 1              # j = i + 1    (On initialise le compteur de la boucle interne)

tsel_boucle_int:        # Boucle interne : j de i+1 à n
    bge s4, s6, tsel_sortie_int   # si j >= n -> fin boucle interne
    slli t0, s4, 2         # t0 = j * 4        (décalage en octets)
    add  t0, s5, t0        # t0 = &tab[j]      (t0 contient l'adresse mémoire de tab[j])
    lw   t1, 0(t0)         # t1 = tab[j]       (t1 contient la valeur de tab[j])
    slli t2, t3, 2         # t2 = min_idx * 4                                                                                                                                                                                                          
    add  t2, s5, t2        # t2 = s5 + min_idx * 4 = &tab[min_idx]                                                                                                                                                                                          
    lw   t2, 0(t2)         # t2 = tab[min_idx] soit "min"   
  
    bge  t1, t2, tsel_next_boucle_int  # Si tab[j] >= min (inverse de min < tab[j]), on sort de la boucle interne.
    mv   t3, s4             # Sinon min_idx = j

tsel_next_boucle_int:
    addi s4, s4, 1          # j = j + 1
    j    tsel_boucle_int # On passe à l'élément suivant de la boucle interne

tsel_sortie_int:         # Sortie boucle interne
    mv   a0, s5             # arg 1 de swap : tab
    mv   a1, t3             # arg 2 de swap : min_idx
    mv   a2, s3             # arg 3 de swap : i
    jal  swap               # swap(tab, minx_idx, i)
    addi s3, s3, 1          # i = i + 1
    j    tsel_boucle_ext #  On passe à l'élément suivant de la boucle externe

tsel_fin:                # Epilogue : restauration des registres et retour
    mv   a0, s5             # a0 = tab            (valeur de retour)
    lw   s3,  0(sp)
    lw   s4,  4(sp)
    lw   s5,  8(sp)
    lw   s6, 12(sp)
    lw   ra, 16(sp)
    addi sp, sp, 20         # libère la pile
    ret                     # retour à l'appelant
