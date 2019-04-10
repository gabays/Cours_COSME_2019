<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" encoding="UTF-8"/>
    <!-- strip-space permet de supprimer les espaces superflues entre les différents éléments de document de sortie -->
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Edition numérique d'Andromaque (1668)</title>
                <link rel="stylesheet" type="text/css" href="andromaque.css"></link>
                <meta charset="UTF-8"></meta>
            </head>
            
            <body>
                <div id="tableOfContent">
                    <ul>
                        <li>
                            <a class="tableOfContent" href="#A1">ACTE PREMIER.</a>
                        </li>
                        <li>
                            <a class="tableOfContent" href="#A2">ACTE II.</a>
                        </li>
                        <li>
                            <a class="tableOfContent" href="#A3">ACTE III.</a>
                        </li>
                        <li>
                            <a class="tableOfContent" href="#A4">ACTE IV.</a>
                        </li>
                        <li>
                            <a class="tableOfContent" href="#A5">ACTE V.</a>
                        </li>
                    </ul>
                </div>
                <div id="header">
                    <h1>Edition numérique d'Andromaque (1668)</h1>
                </div>
                <div id="main">
                    <div id="play">
                        <!-- On n'appliquera que les règles XSL qui concernent les éléments enfants de la div[@type='play'] -->
                        <xsl:apply-templates select="descendant::div[@type='play']"/>                
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!--1, NB : XSL:value-of permet de récupérer le texte qui se trouve dans la balise head de la div[@type='play'] -->  
    <xsl:template match="div[@type='play']/head">
        <h1>
            <xsl:value-of select="."/>
        </h1>
    </xsl:template>
    <!-- 2 --> 
    <xsl:template match="div[@type='act']">
        <div class="actTitle" id="{@xml:id}">
            <xsl:value-of select="head"/>
        </div>
        <!-- l'apply-templates permet d'appliquer les règles des éléments enfants de div[@type='act'] -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="div[@type='scene']">
        <div class="sceneTitle" id="{@xml:id}">
            <xsl:value-of select="head"/>
        </div>
        <div class="stage">
            <xsl:value-of select="stage"/>
        </div>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="speaker">
        <div class="speaker">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <xsl:template match="l">
        <!-- Pour gérer les antilabes (morcellement du vers sur plusieurs répliques), à l'aide de <l @type"F|M"> -->
        <div class="verse" id="{@xml:id}">
            <xsl:choose>
                <!-- Si c'est la fin du vers -->
                <xsl:when test="@part = 'F'">
                    <div class="verseF">
                        <xsl:apply-templates select="text()|
                            figure/desc[@type='letter']/text()|
                            c/text() | placeName | persName"/>
                    </div>
                </xsl:when>
                <!-- Si c'est le milieu du vers -->
                <xsl:when test="@part = 'M'">
                    <div class="verseM">
                        <xsl:apply-templates select="text()|
                            figure/desc[@type='letter']/text()|
                            c/text() | placeName | persName"/>
                    </div>
                </xsl:when>
                <!-- Si ce n'est ni la fin, ni le milieu du vers – doncle début du vers -->
                <xsl:otherwise>
                    <div class="verse">
                        <!-- On ajoute le numéro du vers comme attribut à <div class="verse"> -->
                        <xsl:attribute name="id">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>
                        <!-- Si le numéro du vers finit par '0' c'est un multiple de 10, s'il finit par '0' ou '5' c'est un multiple de 5. -->
                        <xsl:if test="ends-with(@n, '0') or ends-with(@n, '5')">
                            [<xsl:value-of select="@n"/>]
                        </xsl:if>
                        <xsl:apply-templates select="text()|
                            figure/desc[@type='letter']/text()|
                            c/text() | placeName | persName"/>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>    

<!-- J'ajoute les notes avec tooltip. -->
    <xsl:template match="note">
        <span class="tooltip">
            <img src="img_413193.png" height="10"/>
            <span class="tooltiptext">
                <xsl:apply-templates select="text()|title|ref"/>
            </span>
        </span> 
    </xsl:template>
</xsl:stylesheet>