#!/usr/bin/env bash
# ---------------------------------------------------------------
# x2abi.sh : convertit les noms de registres RISC-V xN (x0..x31)
#            en leur équivalent ABI (zero, ra, sp, gp, tp, t*, s*, a*)
#
# Usage :
#   ./x2abi.sh fichier.asm [autre.asm ...]   # en place (backup .bak)
#   ./x2abi.sh < in.asm > out.asm            # filtre stdin -> stdout
#
# Remarques :
#   - \b (word boundary) évite de toucher aux identifiants contenant
#     un xN (ex. "maxval", "0x10", "xorl" ne sont pas modifiés).
#   - Les labels nommés comme un registre (ex. "x10:") SERAIENT
#     convertis -- cas très rare, à vérifier si tu en as.
# ---------------------------------------------------------------
set -euo pipefail

sed_expr=(
    -e 's/\bx0\b/zero/g'
    -e 's/\bx1\b/ra/g'
    -e 's/\bx2\b/sp/g'
    -e 's/\bx3\b/gp/g'
    -e 's/\bx4\b/tp/g'
    -e 's/\bx5\b/t0/g'
    -e 's/\bx6\b/t1/g'
    -e 's/\bx7\b/t2/g'
    -e 's/\bx8\b/s0/g'
    -e 's/\bx9\b/s1/g'
    -e 's/\bx10\b/a0/g'
    -e 's/\bx11\b/a1/g'
    -e 's/\bx12\b/a2/g'
    -e 's/\bx13\b/a3/g'
    -e 's/\bx14\b/a4/g'
    -e 's/\bx15\b/a5/g'
    -e 's/\bx16\b/a6/g'
    -e 's/\bx17\b/a7/g'
    -e 's/\bx18\b/s2/g'
    -e 's/\bx19\b/s3/g'
    -e 's/\bx20\b/s4/g'
    -e 's/\bx21\b/s5/g'
    -e 's/\bx22\b/s6/g'
    -e 's/\bx23\b/s7/g'
    -e 's/\bx24\b/s8/g'
    -e 's/\bx25\b/s9/g'
    -e 's/\bx26\b/s10/g'
    -e 's/\bx27\b/s11/g'
    -e 's/\bx28\b/t3/g'
    -e 's/\bx29\b/t4/g'
    -e 's/\bx30\b/t5/g'
    -e 's/\bx31\b/t6/g'
)

if [ $# -eq 0 ]; then
    sed "${sed_expr[@]}"
else
    sed -i.bak "${sed_expr[@]}" "$@"
    printf 'Converti : %s\n' "$@"
    echo '(backups : <fichier>.bak)'
fi
