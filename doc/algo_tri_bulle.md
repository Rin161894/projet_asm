# Le tri à bulles (*bubble sort*)

## Principe

On compare les paires adjacentes `v[j]` et `v[j+1]`. Si elles sont dans le
mauvais ordre, on les échange. On répète jusqu'à ce qu'un passage complet sur
le tableau n'ait plus aucun échange à faire.

## Pseudo-code

### Version classique

```
bubble_sort(v, n):
    pour i de 0 à n-2:
        pour j de 0 à n-2-i:
            si v[j] > v[j+1]:
                échanger v[j] et v[j+1]
```

### Version de Patterson & Hennessy (implémentée dans `tri_bulle.asm`)

```
bubble_sort(v, n):
    pour i de 0 à n-1:
        pour j de i-1 à 0 (pas -1):
            si v[j] <= v[j+1]:
                sortir de la boucle interne
            échanger v[j] et v[j+1]
```

## Complexité

| Critère | Valeur |
|---|---|
| Comparaisons, pire cas | `n·(n-1)/2` → O(n²) |
| Échanges, pire cas | `n·(n-1)/2` → O(n²) |
| Meilleur cas (déjà trié, avec sortie anticipée) | O(n) |
| Mémoire auxiliaire | O(1) — en place |
| Stable | oui |

## Références

- Wikipédia (FR) — *Tri à bulles* : <https://fr.wikipedia.org/wiki/Tri_%C3%A0_bulles>
- Wikipedia (EN) — *Bubble sort* : <https://en.wikipedia.org/wiki/Bubble_sort>
- D. A. Patterson, J. L. Hennessy, *Computer Organization and Design: The
  Hardware/Software Interface (RISC-V Edition)*, Morgan Kaufmann.
- D. E. Knuth, *The Art of Computer Programming*, vol. 3: *Sorting and
  Searching*, section 5.2.2.
- T. H. Cormen, C. E. Leiserson, R. L. Rivest, C. Stein, *Introduction to
  Algorithms* (CLRS), chap. 2.
- L. Bloch, *Assembleur RISC-V : maintenant les tris* :
  <https://www.laurentbloch.net/MySpip3/Assembleur-RISC-V-maintenant-les-tris>
- *Rosetta Code* — *Sorting algorithms/Bubble sort* :
  <https://rosettacode.org/wiki/Sorting_algorithms/Bubble_sort>
