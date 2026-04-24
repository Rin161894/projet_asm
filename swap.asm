# ref : adapté de Patterson & Hennessy / Laurent Bloch
# swap(tab, i, j) : échange tab[i] et tab[j] dans un tableau de mots
#
#   Entrées : a0 = tab  (adresse de base du tableau)
#             a1 = i    (premier indice)
#             a2 = j    (second indice)
#   Sortie  : aucune    (tableau modifié en mémoire)
# Cette fonction est réutilisable dans les tris, elle ne fait 
# qu'échanger deux éléments du tableau tab[i] <-> tab[j]
# ---------------------------------------------------------------
.text
swap:
    slli t0, a1, 2     # t0 = i * 4            (décalage en octets de tab[i])
    add  t0, a0, t0    # t0 = &tab[i]          (adresse de tab[i])
    slli t1, a2, 2     # t1 = j * 4            (décalage en octets de tab[j])
    add  t1, a0, t1    # t1 = &tab[j]          (adresse de tab[j])
    lw   t2, 0(t0)     # t2 = tab[i]           (sauvegarde de l'ancienne valeur)
    lw   t3, 0(t1)     # t3 = tab[j]           (sauvegarde de l'ancienne valeur)
    sw   t3, 0(t0)     # tab[i] <- t3          (= ancien tab[j])
    sw   t2, 0(t1)     # tab[j] <- t2          (= ancien tab[i])
    ret                # retour à l'appelant
