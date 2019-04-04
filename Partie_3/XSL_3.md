Cours Cosme 2019

# XSLT: approfondissement II

Matthias GILLE LEVENSON

23 avril 2019

---

# Les variables

Une variable est une donnée stockée dans la mémoire du programme de transformation: 

>« If we use logic to control the flow of our stylesheets, we’ll probably want to store tem-
porary results along the way. In other words, we’ll need to use variables. XSLT provides
the ``<xsl:variable>`` element, which allows you to store a value and associate it with a
name.»

Tidwell, D. (2008). *XSLT: Mastering XML Transformations.* 2nd ed. O’Reilly Media.


En XSL, on utilise donc la fonction ``<xsl:variable>``. Une variable est  **nécessairement** nommée à l'aide d'un attribut ``@name``. 

On peut l'utiliser de deux façons: 

- `` <xsl:variable name="nom"  select="valeur_a_capturer"/>``

- on peut aussi proposer la façon suivante: 

        
        <xsl:variable name="nom">
           règles à appliquer...
        </xsl:variable>
        

Les variables sont appelées à l'aide du caractères dollar $:

- ``<xsl:value-of select="$ma_variable"/>``


On peut aussi se servir des variables pour filtrer précisément les données que l'on veut sélectionner et transformer. 

---

# Quelques fonctions xpath

## fn:concat()

La fonction ``concat()`` permet de fusionner deux chaînes de caractères (*strings*). La documentation de xpath la définit de la manière qui suit: 
>« fn:concat(string,string,...)»

[MDN](https://www.w3schools.com/xml/xsl_functions.asp)

Les arguments passés sont des chaînes de caractères. Cette fonction est souvent utilisée pour manipuler des identifiants et des valeurs d'attributs.

## fn:translate()
La fonction ``fn:translate()`` permet de remplacer des caractères. Cette fonction est définie comme suit:

>fn:translate(string1,string2,string3)

[MDN](https://www.w3schools.com/xml/xsl_functions.asp)

Le string1 est le noeud textuel à traiter, string2 les caractères à remplacer, string3 les caractères par lesquels les remplacer.

Attention, la fonction translate convertit les caractères **un à un**:


### Exemple

- ``` translate(abcdefg, 'abcd', 'defghijk')``` donne 'defgefg'.
- ``` translate(abcdefg, 'dcba', 'defg')``` donne 'gfedefg'.

## fn:replace()
La fonction ``replace()`` permet de remplacer des chaînes de caractères qui respectent un motif (*pattern*) défini. Si le motif est trouvé dans la chaîne de caractère, il est remplacé par le troisième argument. Cette fonction est définie ainsi: 

> fn:replace(string,pattern,replace)

[MDN](https://www.w3schools.com/xml/xsl_functions.asp)

où string est le noeud textuel à traîter. 
### Exemple


- ``` replace(abcdefg, 'abcd', 'defghijk')``` donne 'defghijkefg'.
- ``` replace(abcdefg, 'dcba', 'defg')``` donne 'abcdefg': le motif n'a pas été trouvé.

---

# Exercices 
- Créer une notice pour chaque personnage listé dans la ``<listPerson>``.
- Pour chaque personnage listé dans cette ``<listPerson>``, créer un lien vers sa notice en début du document. 


