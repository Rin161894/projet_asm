# Le tri par sélection (*selection sort*)

## Principe

On parcourt la partie non triée du tableau pour y trouver le minimum, puis on
l'échange avec le premier élément de cette partie. La zone triée en tête
grandit d'un élément à chaque passe.

## Pseudo-code

```
selection_sort(v, n):
    pour i de 0 à n-2:
        min_idx = i
        pour j de i+1 à n-1:
            si v[j] < v[min_idx]:
                min_idx = j
        si min_idx != i:
            échanger v[i] et v[min_idx]
```

## Complexité

| Critère | Valeur |
|---|---|
| Comparaisons (toujours) | `n·(n-1)/2` → O(n²) |
| Échanges, pire cas | `n-1` → O(n) |
| Meilleur cas | O(n²) — non adaptatif |
| Mémoire auxiliaire | O(1) — en place |
| Stable | non (version classique) |

## Références

- Wikipédia (FR) — *Tri par sélection* :
  <https://fr.wikipedia.org/wiki/Tri_par_s%C3%A9lection>
- Wikipedia (EN) — *Selection sort* :
  <https://en.wikipedia.org/wiki/Selection_sort>
- D. E. Knuth, *The Art of Computer Programming*, vol. 3: *Sorting and
  Searching*, section 5.2.3 « Sorting by Selection ».
- T. H. Cormen, C. E. Leiserson, R. L. Rivest, C. Stein, *Introduction to
  Algorithms* (CLRS), chap. 2.
- L. Bloch, *Assembleur RISC-V : maintenant les tris* :
  <https://www.laurentbloch.net/MySpip3/Assembleur-RISC-V-maintenant-les-tris>
- *Rosetta Code* — *Sorting algorithms/Selection sort* :
  <https://rosettacode.org/wiki/Sorting_algorithms/Selection_sort>
