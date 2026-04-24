# ref : Patterson & Hennessy, Computer Organization and Design (RISC-V)
# ---------------------------------------------------------------
# bubble_sort(v, n) : tri à bulles d'un tableau de n mots (int)
#
#   Entrées : a0 = v   (adresse de base du tableau)
#             a1 = n   (nombre d'éléments)
#   Sortie  : a0 = v   (même adresse, tableau trié sur place)
#   Détruit : t0, t1, t2
#   Sauvés  : ra, s3, s4, s5, s6 (empilés puis restaurés)
# ---------------------------------------------------------------
.text
bubble_sort:
    # --- Prologue : réserve 5 mots sur la pile + sauvegarde ---
    addi sp, sp, -20       # alloue 5 * 4 octets
    sw   ra, 16(sp)        # sauve l'adresse de retour
    sw   s6, 12(sp)
    sw   s5,  8(sp)
    sw   s4,  4(sp)
    sw   s3,  0(sp)

    # --- Copie des paramètres dans des registres sauvés ---
    mv   s5, a0            # s5 = v            (adresse du tableau)
    mv   s6, a1            # s6 = n            (taille)
    li   s3, 0             # i  = 0            (compteur boucle externe)

tb_boucle_ext:             # ---- Boucle externe : i de 0 à n-1 ----
    bge  s3, s6, tb_fin    # si i >= n  -> fin de la fonction
    addi s4, s3, -1        # j = i - 1         (init boucle interne)

tb_boucle_int:             # ---- Boucle interne : j de i-1 à 0 ----
    bltz s4, tb_sortie_int # si j < 0  -> sort boucle interne
    slli t0, s4, 2         # t0 = j * 4        (décalage en octets)
    add  t0, s5, t0        # t0 = &v[j]        (adresse de v[j])
    lw   t1, 0(t0)         # t1 = v[j]
    lw   t2, 4(t0)         # t2 = v[j+1]
    ble  t1, t2, tb_sortie_int # si v[j] <= v[j+1] -> déjà trié, sort
    mv   a0, s5            # arg 1 de swap : v
    mv   a1, s4            # arg 2 de swap : j
    jal  swap              # swap(v, j)        (échange v[j] et v[j+1])
    addi s4, s4, -1        # j = j - 1
    j    tb_boucle_int     # reboucle boucle interne

tb_sortie_int:             # sortie boucle interne
    addi s3, s3, 1         # i = i + 1
    j    tb_boucle_ext     # reboucle boucle externe

tb_fin:                    # ---- Epilogue : restauration + retour ----
    mv   a0, s5            # a0 = v            (valeur de retour)
    lw   s3,  0(sp)
    lw   s4,  4(sp)
    lw   s5,  8(sp)
    lw   s6, 12(sp)
    lw   ra, 16(sp)
    addi sp, sp, 20        # libère la pile
    ret                    # retour à l'appelant
