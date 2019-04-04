Cours Cosme 2019

# XSLT: publication

Simon Gabay
Lyon, 23 avril 2019

---
# I. Conditions et tests en XSLT (1ère partie)

---
## I.a Fonctions XPath à deux arguments

Il existe des fonctions XPath, qui sont reconnaissables au fait qu'elles se terminent par ```()```. Ainsi ```contains()```, ```starts-with()```, ```ends-with()```, ```substring-after()```, etc.

Prenons l'exemple de ```contains()```: il permet de contrôler que
1. une chaîne de caractère…
2. … contient un/des caractère(s) précis.

Nous avons donc besoin de préciser:
1. Là où nous cherchons
2. Ce que nous cherchons

Pour cela, nous allons ajouter des *arguments* à la fonction XPath en précisant l'un (```$arg1```) et l'autre (```$arg2```), en suivant la syntaxe suivante:

```XML
contains($arg1, $arg2)
```

---
### Exercice I.a

Quel est le résultat obtenu avec ces expressions XPath?


```XML
contains('test', 's')
```

```XML
starts-with('test', 's')
```

```XML
substring-after('test', 's')
```

Et maintenant dans notre fichier ```andromsque.xml```:

```XML
sp[contains(@who, 'H')]
```

```XML
speaker[starts-with(@., 'H')]
```

---
## I.b ```xsl:if```

L'élément ```xsl:if``` obéit à la syntaxe suivante:

```XML
<xsl:template match="monElement">
  <xsl:if test="conditionQueJeDéfinis">
   ... Si la condition que j'ai posée est validée, alors la règle s'applique.
  </xsl:if>
</xsl:template>
```

```xsl:if``` contient un attribut obligatoire ```@test``` qui contient une expression XPath. Cette expression XPath doit renvoyer une valeur booléenne : *true* ou *false*. Cette valeur est obtenue à partir de trois grands types de données:

1. Un nombre (est-il pair ou impair?)
2. Un fragment de l'arbre XML (est-ce un nœud parent?)
3. Une chaîne de caractère (contient-elle une lettre précise?)

Ce test est notamment fait à partir de fonctions XPath.

---
## Exercice I.b
1. Numérotez les lignes d'*Andromaque*, mais uniquement les dizaines (10, 20, 30, 40, 50).
2. Numérotez les lignes qui sont un multiple de 5.

---
# II. Conditions et tests en XSLT (2ème partie)

## ```xsl:choose```

L'élément ```xsl:choose``` ressemble énormément à ```xsl:if```. Sa syntaxe minimale est la suivante:

```XML
<xsl:template match="monElement">
  <xsl:choose>
    <xsl:when test="conditionQueJeDéfinis">
      ... Si la condition que j'ai posée est validée, alors…
    </xsl:when>
  </xsl:choose>
</xsl:template>
```

Contrairement à ```xsl:if```, il est cependant possible de proposer une liste de conditions alternatives qui s'appliquent toutes au même élément:

```XML
<xsl:choose>
  <xsl:when test="premiereCondition">
    ... Si la première condition que j'ai posée est validée, alors…
  </xsl:when>
  <xsl:when test="secondeCondition">
    ... Si la seconde condition que j'ai posée est validée, alors…
  </xsl:when>
    <xsl:when test="troisiemeCondition">
    ... Si la troisième condition que j'ai posée est validée, alors…
  </xsl:when>
</xsl:choose>
```

Il est aussi possible d'ajouter un élément ```xsl:otherwise```, optionnel, permettant de prévoir le cas où aucune des conditions prélablement définies n'est remplie – très utile pour éviter les oublis!

```XML
<xsl:choose>
  <xsl:when test="premiereCondition">
    ... Si la première condition que j'ai posée est validée, alors…
  </xsl:when>
  <xsl:when test="secondeCondition">
    ... Si la seconde condition que j'ai posée est validée, alors…
  </xsl:when>
    <xsl:when test="troisiemeCondition">
    ... Si la troisième condition que j'ai posée est validée, alors…
  </xsl:when>
  <xsl:otherwise>
    ... Dans tous les autres cas, alors…
  </xsl:otherwise>
</xsl:choose>

```

---

## Exercice II

En regardant notre fichier XML de pus près, on remarque que les antilabes (morcellement du vers sur plusieurs répliques) ont été identifiées avec l'attribut ```@part```:

```XML
    <l n="1176" xml:id="v1176" part="I">Courez au Temple. Il faut immoler....</l>
  </lg>
</sp>
<sp who="#oreste" xml:id="A4S3_7">
  <speaker rend="center">ORESTE.</speaker>
  <lg>
    <l n="1176" part="M">Qui?</l>
  </lg>
</sp>
<sp who="#hermione" xml:id="A4S3_8">
  <speaker rend="center">HERMIONNE.</speaker>
  <lg>
    <l n="1176" part="F"><persName ref="#pyrrhus">Pyrrhus</persName>.</l>
  </lg>
</sp>
````

Noter les antilabes est important pour l'analyse stylistique de l'œuvre, mais aussi pour sa mise en page:
![](img/exemple_racine.jpg)

(Source: wikisource)

Notre css a prévu cette situation

```CSS
.verse {
    margin-left: 2em;
}

.verseM {
    margin-left: 8em;
}

.verseF {
    margin-left: 8em;
}
```

Il s'agit donc d'attribuer la bonne classe (```verse```, ```verseM``` ou ```verseF```) dans le fichier HTML en fonction de ```l @part``` dans le fichier XML.


