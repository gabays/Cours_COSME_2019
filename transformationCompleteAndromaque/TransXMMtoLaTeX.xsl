<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
<xsl:output method="text" encoding="UTF-8"/>
<xsl:strip-space elements="*"/>
<xsl:template match="/"><xsl:text>\documentclass{book}
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
﻿% Glossaires
\renewcommand{\pagelinesep}{.}
<!--\glstoctrue
\makeglossaries -->
</xsl:text>
<xsl:apply-templates select="//listPerson"/>
<xsl:text>
\begin{document}

\tableofcontents
\begin{pages}
\begin{Leftside}
\beginnumbering</xsl:text>
<xsl:apply-templates select="//body" mode="orig"/>
<xsl:text>\endnumbering
\end{Leftside}
\begin{Rightside}
\beginnumbering</xsl:text>
<xsl:apply-templates select="//body" mode="reg"/>
<xsl:text>\endnumbering
\end{Rightside}
\end{pages}
\Pages
\printglossaries
\end{document}</xsl:text>
</xsl:template>

<xsl:template match="//fw | //pb | div[@type='play']/head | div[@xml:id='privilege']" mode="orig reg"/>

<!--<xsl:template match="person">
<xsl:text>\longnewglossaryentry{</xsl:text><xsl:value-of select="translate(persName, 'éè', 'ee')"/>}{name=<xsl:value-of select="persName"/>}{
    <xsl:value-of select="note"/>
    Référence: \url{--><!--<xsl:value-of select=".//ref[1]/@target"/>--><!--<xsl:text>}
}
    </xsl:text>
</xsl:template>-->

<xsl:template match="//div[@type='act']" mode="orig reg">
<xsl:text>﻿\stanza[\chapter{</xsl:text><xsl:value-of select="head"/>}
\section{<xsl:value-of select="./div[1]/head"/>}
\personscene{<xsl:value-of select="./div[1]/stage[1]"/>}
\enonciateur{<xsl:value-of select="./div[1]/sp[1]/speaker[1]"/>}
    ]
    <xsl:apply-templates select="div[@type='scene']" mode="#current"/>
</xsl:template>


    <xsl:template match="div[@type='scene']" mode="orig reg">
        <xsl:choose>
            <xsl:when test="position () = 1"> 
                <xsl:apply-templates select="sp" mode="#current"/>
            </xsl:when>
            <xsl:otherwise>
\stanza[\section{<xsl:value-of select="head"/>}
\personscene{<xsl:value-of select="stage"/>}
\enonciateur{<xsl:value-of select="./sp[1]/speaker[1]"/>}
                ]
                <xsl:apply-templates select="sp" mode="#current"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="sp" mode="orig reg">
        <xsl:choose>
            <xsl:when test="position () = 1"> 
                <xsl:apply-templates select="lg" mode="#current"/>
            </xsl:when>
            <xsl:otherwise>
\stanza[
\enonciateur{<xsl:value-of select="speaker"/>}
]
                <xsl:apply-templates select="lg/l" mode="#current"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="l" mode="orig reg">
        <xsl:choose><xsl:when test="@part='M'"><xsl:text>\antilabe </xsl:text></xsl:when>
            <xsl:when test="@part='F'"><xsl:text>\antilabe </xsl:text></xsl:when>
        </xsl:choose>
        <xsl:apply-templates mode="#current"/>
       <xsl:choose><xsl:when test="position() = last()"><xsl:text>\&amp;
       </xsl:text></xsl:when>
       <xsl:otherwise><xsl:text>&amp;
       </xsl:text></xsl:otherwise>
       </xsl:choose>
    </xsl:template>
    
    <xsl:template match="descendant::desc" mode="orig reg">
         <xsl:if test="@type"><xsl:value-of select="text()"/></xsl:if>
    </xsl:template>
    <xsl:template match="persName" mode="reg">
        <xsl:variable name="ref" select="replace(@ref, '#', '')"/>
        <xsl:if test="ancestor::TEI/teiHeader//person[@xml:id=$ref]">
            <xsl:text>\edgls{</xsl:text>
                    <xsl:apply-templates mode="reg"></xsl:apply-templates>
               <xsl:text>}</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="hi" mode="orig reg">
        <xsl:apply-templates mode="#current"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="c" mode="orig">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="c" mode="orig">
        <xsl:value-of select="."/>
    </xsl:template>
 
    <xsl:template match="c" mode="reg">
        <xsl:value-of select="substring-after(@ana,'_')"/> 
    </xsl:template>
    
    <xsl:template match="text()" mode="orig reg"><xsl:value-of select="replace(., '&amp;', '﻿\\ampersand\\')"/></xsl:template>
 
    
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
    <xsl:template match="app" mode="reg"/>
    <xsl:template match="note" mode="orig"/>
    
    <xsl:template match="note" mode="reg">
        <xsl:text>\footnoteA{</xsl:text><xsl:apply-templates mode="reg"/><xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="title" mode="reg">
        <xsl:text>\emph{</xsl:text><xsl:value-of select="."/><xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="ref" mode="reg">
        <xsl:text>\href{</xsl:text><xsl:value-of select="@target"/><xsl:text>}{</xsl:text><xsl:value-of select="."/><xsl:text>}</xsl:text>
    </xsl:template>
       
</xsl:stylesheet>