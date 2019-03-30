```Andromaque_c.xml``` est le doc "allégé" au niveau du code pour garder le document le plus lisible posible. L'essentiel des modifications possibles est contenu encodé dans ```c``` via des attributs.

```without_c.xsl``` permet de retirer le tag ```c``` est d'obtenir un texte encore plus lisible. On pourrait aussi envisager de retirer ```persName```, ```placeName``` ou ```anchor```.

```addingChoices_c.xsl``` permet de transformer les ```c``` en ```choice``` avec ```orig``` et ```reg``` ou ```abbr``` et ```expan``` suivant les cas, avec ```reg``` ou ```expan```déjà complétés.

```addingAppInLine.xsl```permet d'injecter les notes et l'apparat critique (qui sont dans le ```back```) au bon endroit dans le texte à partir des ```anchor``` dans le texte.

```toHTML_orig.xsl``` et ```toHTML_reg.xsl``` permettent de créer deux pages HTML au design somptueux (Matthias est corresponsable). Il y a de la marge pour améliorer le résultats (<-litote).

J'ai laissé  le fichier ```.xpr```: tout les scénarios sont prêts. Il n'y a qu'à cliquer sur play!
