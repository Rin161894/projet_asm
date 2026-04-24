# ref : https://www.laurentbloch.net/MySpip3/Assembleur-RISC-V-maintenant-les-tris
# ---------------------------------------------------------------
# swap(v, k) : échange v[k] et v[k+1] dans un tableau de mots (int)
#
#   Entrées : a0 = v  (adresse de base du tableau)
#             a1 = k  (indice du 1er élément à échanger)
#   Sortie  : aucune  (tableau modifié en mémoire)
#   Détruit : t0, t1, t2
# ---------------------------------------------------------------
.text
swap:
    slli t1, a1, 2     # t1 = k * 4            (indice -> décalage en octets)
    add  t1, a0, t1    # t1 = v + k*4          (adresse de v[k])
    lw   t0, 0(t1)     # t0 = v[k]             (sauvegarde ancienne valeur)
    lw   t2, 4(t1)     # t2 = v[k+1]
    sw   t2, 0(t1)     # v[k]   <- t2          (= ancien v[k+1])
    sw   t0, 4(t1)     # v[k+1] <- t0          (= ancien v[k])
    ret   	       # retour à l'appelant
