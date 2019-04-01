<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
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
                    <xsl:apply-templates select="descendant::div[@type='play']"/>                
                </div>
            </div>
        </body>
    </html>
    </xsl:template>
    
    <xsl:template match="div[@type='play']">
        <h1><xsl:value-of select="head"/></h1>
        <xsl:apply-templates select="div[@type='act']"/>
    </xsl:template>
    
    <xsl:template match="div[@type='act']">
        <div class="actTitle" id="{@xml:id}">
            <xsl:value-of select="head"/>
        </div>
        <xsl:apply-templates select="div"/>
    </xsl:template>
    
    <xsl:template match="div[@type='scene']">
        <div class="sceneTitle" id="{@xml:id}">
            <xsl:value-of select="head"/>
        </div>
        <div class="stage">
            <xsl:value-of select="stage"/>
        </div>
        <xsl:apply-templates select="sp"/>
    </xsl:template>
      
    <xsl:template match="speaker">
        <div class="speaker">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <xsl:template match="l">
        <div class="verse" id="{@xml:id}">
            <xsl:value-of select="text()|
                figure/desc[@type='letter']/text()|
                c/text()"/>
        </div>
    </xsl:template>
    
    <xsl:template match="fw|figure|pb"/>
    
</xsl:stylesheet>