<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xhtml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"></xsl:output>
    
    <xsl:template match="TEI">
        <html>
            <head>
                <title><xsl:value-of select="//titleStmt/title"/></title>
                <link rel="stylesheet" type="text/css" href="andromaque.css"/>
                <meta charset="UTF-8"/>    
            </head>
            <body>
                <div id="tableOfContent">
                    <ul>
                        <xsl:for-each select="//div[@type='act']">
                            <li>
                                <a>
                                    <xsl:attribute name="class">
                                        <xsl:text>tableOfContent</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="href">
                                        <xsl:text>#</xsl:text>
                                        <xsl:value-of select="@xml:id"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="head"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
                <div id="header">
                    <h1><xsl:value-of select="//titleStmt/title"/></h1>
                </div>
                <div id="main">
                    <xsl:apply-templates/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match ="teiHeader"/>
    
    <xsl:template match ="figure"/>
    
    <xsl:template match ="titlePage"/>
    
    <xsl:template match ="note"/>
    
    <xsl:template match ="expan"/>
    
    <xsl:template match ="corr"/>
    
    <xsl:template match="sic">
        <xsl:apply-templates/> [sic]
    </xsl:template>
    
    <!-- Mise en page -->
    
    <xsl:template match="pb">
        <div class="pb">
            <xsl:attribute name="id">
                <xsl:text>p</xsl:text><xsl:value-of select="@n"/>
            </xsl:attribute>
            <a target="_blank" href="{@facs}">[<xsl:value-of select="@n"/>]</a>
        </div>
    </xsl:template>
    
    <xsl:template match="fw">
        <xsl:choose>
            <xsl:when test="@type='bookBinding'">
                <div class="fw">
                    [cahier] <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='catchword'">
                <div class="fw">
                    <xsl:apply-templates/> [Réclame]
                </div>
            </xsl:when>
            <xsl:when test="@type='pageNum'">
                <div class="fw">
                    [Page] <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@type='head'">
                <div class="fw">
                    [En-tête] <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="fw">
                    <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    

    <xsl:template match="front/div/head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>

    
    <!-- Front -->
    
    <xsl:template match ="front//p//lb"/>
    
    <!-- Lettre introductive -->
    
    <xsl:template match="div[@xml:id='aMadame']">
        <div id="aMadame">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@xml:id='aMadame']//p">
        <p ><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="opener">
        <div class="opener"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="closer">
        <div class="closer"><xsl:apply-templates/></div>
    </xsl:template>
    
    <!-- preface -->
    
    <xsl:template match="//div[@xml:id='preface']">
        <div id="preface">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@xml:id='preface']//l">
        <div class="verse">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- CastList -->
    
    <xsl:template match="div[@xml:id='castList']">
        <div id="castList">
            <ul><xsl:apply-templates/></ul>
        </div>
    </xsl:template>
    
    <xsl:template match="castItem">
        <li class="castItem"><xsl:apply-templates/></li>
    </xsl:template>
    
    <!-- Play -->
    
    <xsl:template match="div[@type='play']">
        <div id="play">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@type='act']/head">
        <div class="actTitle">
            <xsl:attribute name="id">
                <xsl:value-of select="../@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@type='scene']/head">
        <div class="sceneTitle">
            <xsl:attribute name="id">
                <xsl:value-of select="../@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@type='scene']/stage">
        <div class="stage">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="speaker">
        <div class="speaker">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@type='scene']//l">
        <xsl:choose>
            <xsl:when test="@part='F'">
                <div class="verseF">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:when test="@part='M'">
                <div class="verseM">
                    <xsl:apply-templates/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="verse">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    [<xsl:value-of select="@n"/>] <xsl:apply-templates/>
                </div>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>
    
    <!-- Privilege -->
    
    <xsl:template match="div[@xml:id='privilege']">
        <div id="privilege">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="//div[@xml:id='privilege']//p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="orig"/>
    
    <xsl:template match="back"/>

    <!-- 
    <xsl:template match="//p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="//lg">
        <div id="stanza">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match ="//p//lb"/>
    
    <xsl:template match="//lb">
        <xsl:choose>
            <xsl:when test="@break"/>
            <xsl:otherwise><br/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="//choice/sic">
        <xsl:apply-templates/> [sic:<xsl:value-of select="//sic/parent::choice/corr"/>]
    </xsl:template>
     -->
    
</xsl:stylesheet>