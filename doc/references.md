# Références
https://www.laurentbloch.net/MySpip3/Mon-premier-programme-en-assembleur-RISC-V
https://www.laurentbloch.net/MySpip3/Nouvel-episode-de-programmation-en-assembleur-RISC-V
https://www.laurentbloch.net/MySpip3/Assembleur-RISC-V-maintenant-les-tris
https://fr.wikipedia.org/wiki/Tri_%C3%A0_bulles

# Astuces
rars test.asm => compile et lance le programme en console.
Attention, lorsqu'on « include » un fichier les étiquettes doivent rester uniques. Le mieux est de les préfixer avec le nom de la fonction.
Générer un tableau aléatoire de 20 entrées (pour tab.asm):
```bash
python3 -c "import random; random.seed(); print(', '.join(str(random.randint(-99, 99)) for in range(20)))"
```

# Méthode mesures
## dans RARS
* Ouvrir le fichier asm à tester.
* Tools - Instruction Counter, puis "Connect to program"
* Settings - Hexadecimal Values
* Settings - Hexadecimal Addresses

 1. Assemble (F3).
 2. Clic sur Reset dans la fenêtre Instruction Counter (important : vider entre deux tests).
 3. Run (F5) jusqu'à la fin.
 4. Relève les chiffres :

 Exécution
 Dans Instruction Counter :
 - Ligne Instructions so far → métrique principale
 - Décomposition R / I / S / B / U / J → utile pour distinguer calcul pur vs accès mémoire (les S-type = stores, les loads sont des I-type)
 Mémoire — lecture directe dans RARS 
 - Text Segment → scroll jusqu'à la dernière instruction de ta fonction, note l'adresse de bubble_sort et l'adresse juste après ret. Différence = taille du code en octets.
 - Data Segment → idem pour tab + constantes. Tu vois le tableau avant/après le tri, utile pour vérifier.
 - Pile : regarde sp dans la fenêtre Registers avant l'appel et mets un breakpoint sur la 1ʳᵉ instruction de la fonction pour voir sp après le prologue. La différence = octets consommés sur la pile par appel. Pour un algo itératif comme le tri à bulles, ça ne grandit jamais au-delà. 

# Résultats
* Les appels des fonctions communes sont considérées négligeables. Par exemple print_tab est appelée de la même manière sur tous les algorithmes.

| Algorithme        | Instructions totales | R   | I      | S   | B   | U   | J   | Pile (o) | Récursif | Complexité théorique |
| -------------------| ---------------------:| ----:| -------:| ----:| ----:| ----:| ----:| ---------:| :--------:| :--------------------:|
| Tri à bulles      | **2 698**            | 709 | 1 097 | 235 | 322 | 48  | 287 | 20       | non      | O(n²)                |
| Tri par sélection |                      |     |        |     |     |     |     |          |          | O(n²)                |
| Tri par insertion |                      |     |        |     |     |     |     |          |          | O(n²)                |
| Tri rapide        |                      |     |        |     |     |     |     |          | oui      | O(n log n) moy.      |
| Tri fusion        |                      |     |        |     |     |     |     |          | oui      | O(n log n)           |
| Tri par tas       |                      |     |        |     |     |     |     |          |          | O(n log n)           |


# VRAC à travailler
  1. Temps (= nombre d'instructions)                   
  Comparaison directe : la colonne Total instr. suffit. Plus petit = plus rapide.
  
  Trois lectures utiles :                           
  ┌────────────────────────┬─────────────────────────────────┬─────────────────────────────────────────────────────────────────────────────────────┐
  │  Type de comparaison   │             Formule             │                                  Ce que ça te dit                                   │                                                                                                
  ├────────────────────────┼─────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────┤
  │ Ratio entre algos      │ total_A / total_B               │ « A est 2,3× plus lent que B »                                                      │                                                                                                
  ├────────────────────────┼─────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────┤
  │ Intensité mémoire      │ (I+S) / total                   │ part des instructions qui touchent la RAM                                           │                                                                                                
  ├────────────────────────┼─────────────────────────────────┼─────────────────────────────────────────────────────────────────────────────────────┤
  │ Vérification théorique │ total / n² ou total / (n·log₂n) │ le coefficient doit rester à peu près constant si tu refais le test avec un autre n │
  └────────────────────────┴─────────────────────────────────┴─────────────────────────────────────────────────────────────────────────────────────┘                                                                                            
  La dernière ligne est la plus intéressante pour un rapport d'archi : elle valide (ou pas) la complexité théorique. Pour bulle avec n=20, le coût « pur tri » ≈ 2698 − print instructions, divisé par 20² = 400 → tu obtiens une constante ~X.     
  Refais avec n=50 → tu dois retomber sur ~X × 1,X.                
  2.Mémoire         
  Là, un seul chiffre ne suffit pas. Il faut distinguer deux composantes :                                       
  a. Mémoire statique (code + données)
  ┌──────────────────────────────┬─────────────────────────────────────────────────────────┐
  │          Composant           │                Comment mesurer dans RARS                │                                                                                                                                                        
  ├──────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ Taille du code de l'algo     │ adresse de ret − adresse du label d'entrée (en octets)  │                                                                                                                                                        
  ├──────────────────────────────┼─────────────────────────────────────────────────────────┤
  │ Données auxiliaires allouées │ regarder .data du fichier : tables de travail, buffers… │                                                                                                                                                        
  └──────────────────────────────┴─────────────────────────────────────────────────────────┘
                                          
  Pour bubble : juste du code, 0 octet de données auxiliaires (tri in-place).                                            
  Pour merge sort : tu alloueras un tableau temporaire → + 4n octets de données.                                                                                                                                                                    
                                                                                                                                                                                                                                                    
  b. Mémoire dynamique (pile) — c'est ça qui diffère vraiment                                                                                                                                                                                       
                                          
  La bonne métrique n'est pas un octet absolu, c'est la fonction de n :                                                                                                                                                                             
                                                                                                                                                                                                                                                    
  ┌────────────────────────────────────────┬─────────────────────┬───────────┬───────────────┐                                                                                                                                                      
  │               Algo type                │   Pile consommée    │ Pour n=20 │  Pour n=1000  │                                                                                                                                                      
  ├────────────────────────────────────────┼─────────────────────┼───────────┼───────────────┤
  │ Itératif (bulle, insertion, sélection) │ constante (1 cadre) │ 20 o      │ 20 o          │                                                                                                                                                      
  ├────────────────────────────────────────┼─────────────────────┼───────────┼───────────────┤
  │ Récursif équilibré (fusion, tas)       │ cadre × log₂(n)     │ ~5 cadres │ ~10 cadres    │                                                                                                                                                      
  ├────────────────────────────────────────┼─────────────────────┼───────────┼───────────────┤
  │ Récursif dégénéré (quicksort pire)     │ cadre × n           │ 20 cadres │ 1000 cadres ! │                                                                                                                                                      
  └────────────────────────────────────────┴─────────────────────┴───────────┴───────────────┘                                                                                                                                                      
                                                                                                                                                                                                                                                    
  Dans RARS tu lis :                                                                                                                                                                                                                                
  - Taille d'un cadre → dans le prologue : addi sp, sp, -N → N octets                                                                                                                                                                               
  - Profondeur max → regarde le registre sp pendant l'exécution (breakpoint à l'intérieur de la fonction récursive), ou l'instrumentation sp_min que je t'avais proposée si tu changes d'avis
                                                                                                                                                                                                                                                    
  Résumé : ce qu'il faut présenter dans le rapport
                                                                                                                                                                                                                                                    
  Deux tableaux, pas un :                 
                                                                                                                                                                                                                                                    
  Tableau 1 — Temps                                                                                                                                                                                                                                 
  | Algo | Total instr. | Ratio vs plus rapide | Coefficient total / n² ou / n log n |                                                                                                                                                              
                                                                                                                                                                                                                                                    
  Tableau 2 — Mémoire                                                                                                                                                                                                                               
  | Algo | Code (o) | Données aux. (o) | Pile/cadre (o) | Profondeur pile | Pile max (o) |
                                                                                                                                                                                                                                                    
  La colonne Pile max (= cadre × profondeur) est la métrique clé pour comparer l'empreinte mémoire dynamique entre algos.                                                                                                                           
                                                                                                                                                                                                                                                    
  Conclusion qualitative attendue                                                                                                                                                                                                                   
                                                                                                                                                                                                                                                    
  Tu devrais retrouver dans tes chiffres :                                                                                                                                                                                                          
  - Bulle : lent (O(n²)) mais mémoire minimale (20 o fixes).                                                                                                                                                                                        
  - Fusion : rapide (O(n log n)) mais paye en mémoire (4n o de buffer + pile log₂ n).
  - Quicksort : rapide en moyenne, mais pile variable selon les données → risqué sur gros n.     