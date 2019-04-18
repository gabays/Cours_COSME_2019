<?xml version="1.0" encoding="UTF-8"?>

<!-- Problèmes à régler :
    
- Mise en forme du glossaire, tous les noms ne sont pas toujours écrits de la même manière (problèmes d'accents et tiret dans le nom d'Hector), ce qui pose des problèmes pour la reconnaissance de l'occurence.
 => une solution récupérer la graphie du glossaire 
- début de solution mise en place de l'index sur la forme régularisée uniquement (+ évite de multiplier les occurrences entre page de droite et page de gauche
=> + problème latex dans la reconnaissance des numéros de vers de l'index incohérent et lien brisé de l'index vers le texte
-->

<!-- Préambule du document avec ajout par défaut du domaine tei dans le xpath -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
<!-- Paramétrage d'un format de sortie de type texte -->   
<xsl:output method="text" encoding="UTF-8"/>
<!-- Fonction XSLT qui permet de réduire les espaces parasites dans les éléments liées à l'indentation du XML -->    
<xsl:strip-space elements="*"/>
    
<!-- Régle "racine" qui permet de parser l'ensemble du document et de structurer le document de sortie -->    
<xsl:template match="/"><!-- Ajout de la structuration de base du document LaTeX de sortie --><xsl:text>\documentclass{book}
\usepackage[french]{babel}
\usepackage{hyperref}
\usepackage{glossaries}
\usepackage[noend,series={A},noeledsec, noledgroup]{reledmac}
\usepackage{reledpar}
\usepackage{libertinus}
\usepackage[paperwidth=10cm, paperheight=15cm]{geometry}

% Pas de numéro pour les chapitres, vers etc
\setcounter{secnumdepth}{-2}

% Réglage de la poésie
\setstanzaindents{2,0}
\setcounter{stanzaindentsrepetition}{1}
\sethangingsymbol{[\,}
\newcommand{\antilabe}{\skipnumbering\unskip\hspace{2\stanzaindentbase}}

% Annonce des personnages
\newcommand{\personscene}[1]{\par\hspace{2\stanzaindentbase}\emph{#1}}
\newcommand{\enonciateur}[1]{\par\hspace{\stanzaindentbase}\textbf{#1}}

% Apparat textuel (positif?)

% #1 Le lemme tel que dans le texte
% #2 Le ms concerné
% #3 ce qu'il y a a droite (les variantes)
\newcommand{\app}[3]{\edtext{#1}{%
    \lemma{#1 \wit{#2}}%
    \Afootnote{#3}%
  }%
}
\newcommand{\wit}[1]{(#1)}

% Pas de flag pour les lignes de droites
\setRlineflag{}

\renewcommand{\pagelinesep}{.}
\glstoctrue
\makeglossaries 
</xsl:text>
<!-- Ajout à cet endroit des règles qui permettront de générer le glossaire -->    
<xsl:apply-templates select="//listPerson"/>
<xsl:text>
\begin{document}

\tableofcontents
\begin{pages}
\begin{Leftside}
\beginnumbering</xsl:text>
<!-- Ajout à cet endroit des règles qui permettront de générer la page de gauche avec les graphies originales de la source
    Utilisation de l'attribut mode pour pouvoir traiter plusieurs fois un même élément de la source
    ici, le mode est nommé "orig"
    -->
<xsl:apply-templates select="//body" mode="orig"/>
<xsl:text>\endnumbering
\end{Leftside}
\begin{Rightside}
\beginnumbering</xsl:text>
<!-- Ajout à cet endroit des règles qui permettront de générer la page de droite avec les graphies normalisées de la source
    Utilisation de l'attribut mode pour pouvoir traiter de plusieurs fois un même élément de la source
    ici, le mode est nommé "reg"
    -->
<xsl:apply-templates select="//body" mode="reg"/>
<xsl:text>\endnumbering
\end{Rightside}
\end{pages}
\Pages
\printglossaries
\end{document}</xsl:text>
</xsl:template>

<!-- Règle qui permet la constitution des entrées du glossaire -->
<xsl:template match="person">
<xsl:text>\longnewglossaryentry{</xsl:text><xsl:value-of select="persName"/>}{name=<xsl:value-of select="persName"/>}{
    <xsl:value-of select="note"/>
    Référence: \url{--><!--<xsl:value-of select=".//ref[1]/@target"/>--><xsl:text>}
}
    </xsl:text>
</xsl:template>

<!-- Règle de structuration du texte d'un acte, cette règle est valable aussi bien en mode 'reg' qu'en mode 'orig',
        elle s'applique donc de la même manière aux pages de droite et aux pages de gauche -->
<xsl:template match="//div[@type='act']" mode="orig reg">
<!-- Création du titre de l'acte, associé au titre de la première scène de l'acte concerné. -->    
<xsl:text>﻿\stanza[\chapter{</xsl:text><xsl:value-of select="head"/>}
\section{<xsl:value-of select="./div[1]/head"/>} <!--ajout du titre -->
    \personscene{<xsl:value-of select="./div[1]/stage[1]"/>}  <!--nom des personnages sur scène -->
    \enonciateur{<xsl:value-of select="./div[1]/sp[1]/speaker[1]"/>} <!--nom du premier personnage à prendre la parole -->
    ]
    <!-- Les règles qui s'appliquent aux scènes s'appliqueront ici en fonction du mode d'application de la règle ('#current') -->
    <xsl:apply-templates select="div[@type='scene']" mode="#current"/>
</xsl:template>

    <!-- Règle de structuration du texte d'une scène, cette règle est valable aussi bien en mode 'reg' qu'en mode 'orig',
        elle s'applique donc de la même manière aux pages de droite et aux pages de gauche -->
    <xsl:template match="div[@type='scene']" mode="orig reg">
     <!-- Ici, la mise en place des titres n'est pas traitée de la manière en fonction des situations -->   
        <xsl:choose>
            <!-- Si la scène est la permière de l'acte, on ne crée pas de nouveau titre, car il a été crée avec l'annonce de l'acte -->
            <xsl:when test="position () = 1"> 
                <!-- Les règles qui s'appliquent aux répliques s'appliqueront ici en fonction du mode d'application de la règle ('#current') -->
                <xsl:apply-templates select="sp" mode="#current"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- Si la scène n'est pas la permière de l'acte, on crée de nouveau titre, annoncant le changement de scène -->      
\stanza[\section{<xsl:value-of select="head"/>}
\personscene{<xsl:value-of select="stage"/>}
\enonciateur{<xsl:value-of select="./sp[1]/speaker[1]"/>}
                ]
                <!-- Les règles qui s'appliquent aux répliques s'appliqueront ici en fonction du mode d'application de la règle ('#current') -->
                <xsl:apply-templates select="sp" mode="#current"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Règle de structuration du texte d'une réplique, cette règle est valable aussi bien en mode 'reg' qu'en mode 'orig',
        elle s'applique donc de la même manière aux pages de droite et aux pages de gauche -->
    <xsl:template match="sp" mode="orig reg">
        <xsl:choose>
            <xsl:when test="position () = 1"> 
                <xsl:apply-templates select="lg" mode="#current"/>
            </xsl:when>
            <xsl:otherwise>
\stanza[
\enonciateur{<xsl:value-of select="speaker"/>}
]
                <!-- Les règles qui s'appliquent aux répliques s'appliqueront ici en fonction du mode d'application de la règle ('#current') -->
                <xsl:apply-templates select="lg/l" mode="#current"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Règle de structuration du texte d'un ver, cette règle est valable aussi bien en mode 'reg' qu'en mode 'orig',
        elle s'applique donc de la même manière aux pages de droite et aux pages de gauche -->
    <xsl:template match="l" mode="orig reg">
        <xsl:choose><xsl:when test="@part='M'"><xsl:text>\antilabe </xsl:text></xsl:when>
            <xsl:when test="@part='F'"><xsl:text>\antilabe </xsl:text></xsl:when>
        </xsl:choose>
        <!-- Les règles qui s'appliquent au texte des vers s'appliqueront ici en fonction du mode d'application de la règle ('#current') -->
        <xsl:apply-templates mode="#current"/>
        <!-- Deux cas de figure, fin de vers ou fin de réplique qui demandent des traitements différent en latex -->
       <xsl:choose><xsl:when test="position() = last()"><xsl:text>\&amp;<!-- Cas où le vers est le dernier de la réplique -->
       </xsl:text></xsl:when>
       <xsl:otherwise><xsl:text>&amp;
       </xsl:text></xsl:otherwise><!-- autres cas -->
       </xsl:choose>
    </xsl:template>
    
    <!-- Signalement des occurences d'un nom de personnages dans le corpus (permet de constuire le glossaire) uniquement dans la forme régularisée -->    
    <xsl:template match="persName" mode="reg">
        <!-- Variable qui "stocke" la valeur de l'attribut @ref -->
        <xsl:variable name="ref" select="replace(@ref, '#', '')"/>
        <!-- Condition qui permet de ne signaler que les noms de personnages qui apparaissent dans le glossaire -->
       <xsl:choose> <xsl:when test="ancestor::TEI/teiHeader//person[@xml:id=$ref]">
            <xsl:text>\edgls{</xsl:text>
           <xsl:value-of select="ancestor::TEI/teiHeader//person[@xml:id=$ref]/persName"/>
               <xsl:text>}</xsl:text>
        </xsl:when>
       <xsl:otherwise>
           <xsl:apply-templates mode="reg"/>
       </xsl:otherwise>
       </xsl:choose>
    </xsl:template>
    
   
    <!-- L'élément c qui signale dans le XML la graphie des régularisation est traité différement en fonction du mode 'orig' ou 'reg' --> 
    <!-- En mode orig, le texte de l'élément est récupéré -->
    <xsl:template match="c" mode="orig">
        <xsl:value-of select="."/>
    </xsl:template>
    <!-- En mode reg, la partie du texte régularisé présent dans l'attribut ana est récupérée  --> 
    <xsl:template match="c" mode="reg">
        <xsl:value-of select="substring-after(@ana,'_')"/> 
    </xsl:template>
    
    <!-- Règles de mise en place de l'apparat critique, uniquement sur les pages de gauche, soit en mode orig -->    
    <xsl:template match="app" mode="orig">
        ﻿<xsl:text>\app%
        </xsl:text>
        <xsl:apply-templates mode="#current"/>       
    </xsl:template>
    <xsl:template match="lem" mode="orig">
        <xsl:text>{</xsl:text><xsl:apply-templates mode="orig"/><xsl:text>}%
        {</xsl:text><xsl:value-of select="replace(@wit, '#ed', '')"/><xsl:text>}%
        </xsl:text>
  </xsl:template>
    <xsl:template  match="descendant::rdg" mode="orig">
        <xsl:text>{</xsl:text><xsl:apply-templates mode="orig"/><xsl:text> \wit{</xsl:text><xsl:value-of select="replace(@wit, '#ed', '')"/><xsl:text>}}</xsl:text>
    </xsl:template>
    <xsl:template match="app" mode="reg"/> <!-- Les apparats ne doivent pas apparaitre sur les pages de droite -->
    
    <!-- Règles de mise en place des notes de commentaire, uniquement sur les pages de droite, soit en mode reg -->   
    <xsl:template match="note" mode="reg">
        <xsl:text>\footnoteA{</xsl:text><xsl:apply-templates mode="reg"/><xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="title" mode="reg">
        <xsl:text>\emph{</xsl:text><xsl:value-of select="."/><xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="ref" mode="reg">
        <xsl:text>\href{</xsl:text><xsl:value-of select="@target"/><xsl:text>}{</xsl:text><xsl:value-of select="."/><xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="note" mode="orig"/><!-- Les apparats ne doivent pas apparaitre sur les pages de gauche -->
    
    <!-- Règles de mise en page des éléments xml qui peuvent apparaitre dans les vers -->
    <xsl:template match="text()" mode="orig reg"><xsl:value-of select="replace(., '&amp;', '﻿\\ampersand\\')"/></xsl:template>   
   <xsl:template match="persName" mode="orig"><xsl:apply-templates mode="orig"/></xsl:template>
    <xsl:template match="hi" mode="orig reg">
        <xsl:apply-templates mode="#current"></xsl:apply-templates>
    </xsl:template>   
    <xsl:template match="descendant::desc" mode="orig reg">
        <xsl:if test="@type"><xsl:value-of select="text()"/></xsl:if>
    </xsl:template>
       
    <!-- Insertion dans cette règle vide de tous les éléments dont les valeurs textuelles ne doivent pas être récupérées -->
    <xsl:template match="//fw | //pb | div[@type='play']/head | div[@xml:id='privilege']" mode="orig reg"/>   
</xsl:stylesheet>