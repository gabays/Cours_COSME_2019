<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" encoding="UTF-8"/>
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
                    <h1>Titre</h1>
                    <div class="actTitle" id="A1">ACTE PREMIER.</div>
                    <div class="sceneTitle" id="A1S1">SCENE PREMIERE.</div>
                    <div class="stage">ORESTE, PYLADE.</div>
                    <div class="speaker">ORESTE.</div>
                    <div class="verse" id="v1"><xsl:apply-templates/></div>
                </div>
            </div>
        </body>
    </html>
    </xsl:template>
    
    
    
</xsl:stylesheet>