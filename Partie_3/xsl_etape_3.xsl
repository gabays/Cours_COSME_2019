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
                <link rel="stylesheet" type="text/css" href="andromaque.css"/>
                <meta charset="UTF-8"/>
            </head>
            <body>
                <div id="notices_personnages">
                    <h3>Notices: personnages</h3>
                    <xsl:apply-templates select="//person"/>
                </div>
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
                        <xsl:apply-templates select="descendant::div[@type = 'play']"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <!--1, NB : XSL:value-of permet de récupérer le texte qui se trouve dans la balise head de la div[@type='play'] -->
    <xsl:template match="div[@type = 'play']/head">
        <h1>
            <xsl:value-of select="."/>
        </h1>
    </xsl:template>
    <!-- 2 -->
    <xsl:template match="div[@type = 'act']">
        <div class="actTitle" id="{@xml:id}">
            <xsl:value-of select="head"/>
        </div>
        <!-- l'apply-templates permet d'appliquer les règles des éléments enfants de div[@type='act'] -->
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="div[@type = 'scene']">
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
        <div class="verse" id="{@xml:id}">
            <!-- Ici le Xpath de @select permet de récupérer plusieurs valeurs :
            - le texte enfant des <l>
            - le texte enfant des desc[@type='letter']
            - le texte enfant des <c> -->
            <!--Maj matthias: appliquer les règles sur toutes les balises mentionnées + sur les persName-->
            <xsl:apply-templates
                select="
                    text() |
                    figure/desc[@type = 'letter']/text() |
                    c/text() | persName"
            />
        </div>
    </xsl:template>

    <!-- Cette règle vide permet de ne pas récupérer le contenu des balises citées -->
    <xsl:template match="fw | figure | pb"/>



    <!--Pour chaque personnage qui est cité dans le texte avec un persName, créer une notice-->
    <xsl:template match="person">
        <xsl:variable name="id_person" select="@xml:id"/>
            <div id="{@xml:id}">
                <h3>
                    <xsl:value-of select="persName"/>
                </h3>
                <p>
                    <xsl:apply-templates select="note"/>
                    <br/>
                    <xsl:text>Références:</xsl:text>
                    <a href="{descendant::ref[@type = 'wiki']/@target}">
                        <xsl:value-of select="bibl/ref[@type = 'wiki']/@target"/>
                    </a>
                    <br/>
                    <!-- <xsl:text>Index:</xsl:text>
                    <xsl:for-each select="ancestor::TEI//text//div[@type = 'scene']//persName[@ref = concat('#', $id_person)]">
                        <xsl:text>Acte </xsl:text>
                        <xsl:value-of select="ancestor::div[@type = 'act']/@n"/>
                        <xsl:text>, scène </xsl:text>
                        <xsl:value-of select="ancestor::div[@type = 'scene']/@n"/>
                        <xsl:text>; </xsl:text>
                    </xsl:for-each>-->
                </p>
            </div>
    </xsl:template>


    <!--Traitement des noms de personnage dans le texte: renvoyer vers la liste des personnages qui ont une notice. Suppose p.e. de refaire le xml pour typer les personnages.-->
    <xsl:template match="persName[@ref]">

        <!--Récupérer l'@id du persName-->
        <xsl:variable name="id_persName" select="translate(@ref, '#', '')"/>
        <!--Récupérer l'@id du persName-->

        <!--Appliquer la règle uniquement aux noms de personnages qui sont listés dans la notice-->
        <xsl:choose>
            <xsl:when test="//person[@xml:id = $id_persName]">
                <!--faire un lien vers cette notice-->
                <a href="{@ref}">
                    <xsl:apply-templates/>
                </a>
                <!--faire un lien vers cette notice-->
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <!--Appliquer la règle uniquement aux noms de personnages qui sont listés dans la notice, et pas dans al liste des personnages-->
    </xsl:template>



</xsl:stylesheet>
