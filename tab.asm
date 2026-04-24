# ---------------------------------------------------------------
# tab.asm : tableau d'entiers utilisé pour tester swap/print_tab
#
# Expose :
#   tab     : adresse du 1er mot du tableau
#   tab_len : adresse d'un mot contenant la taille (nb d'éléments)
#             -> à charger avec `lw` avant de la passer en argument
# ---------------------------------------------------------------
.data
tab:        .word 1, 64, -16, -75, 62, -40, -13, 0, -87, 47, -11, -97, 41, -17, -30, -32, 30, 54, -87, -48
tab_len:    .word 20
