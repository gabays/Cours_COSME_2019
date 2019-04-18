<?xml version="1.0" encoding="UTF-8"?>
<!-- en-tête du fichier xsl qui indique que l'on utilise la version 2.0 et que le nom de domaine par défaut du Xpath est tei -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- réglage de la sortie au format HTML avec un encodage de caractères UTF-8 -->
    <xsl:output method="html" encoding="UTF-8"/>
    
    <!-- Cette règle permet de parser l'arbre XML source depuis le racine -->
    <xsl:template match="/">
        <!-- Ci-dessous ajout des balises HTML de structuration du fichier -->
      <html>
        <head>
            <title>Edition numérique d'Andromaque (1668)</title>
            <link rel="stylesheet" type="text/css" href="andromaque.css"></link>
            <meta charset="UTF-8"></meta>
        </head>
        <body>
            <!-- Mise en place d'une table des matières permettant la navigation au sein du fichier -->
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
                    <!-- Les différents éléments du fichier XML seront insérés à ce niveau de la structure -->
                </div>
            </div>
        </body>
    </html>
    </xsl:template>   
</xsl:stylesheet>