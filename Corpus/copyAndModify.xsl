<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <!-- Copy anything as it is -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- If I were to do something different for an element here is how I'd do it. -->
    <xsl:template match="w" priority="1">
        <w xmlns="http://www.tei-c.org/ns/1.0"><choice><orig><xsl:apply-templates/></orig><reg><xsl:call-template name="reg"></xsl:call-template></reg></choice></w>
    </xsl:template>
    
    <xsl:template match="reg" name="reg">
        <xsl:choose>
            <xsl:when test=".[descendant::lb]">
                <xsl:apply-templates/>

            </xsl:when>
            <xsl:when test=".[not(descendant::lb)]">
                <xsl:value-of select="replace(., 'ſ', 's')" />
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- 
        <xsl:template match="reg" name="reg">
        <xsl:choose>
            <xsl:when test="reg[descendant::lb]">
                <xsl:value-of select="replace(text()[current()=following::lb[1]], 'ſ', 's')" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="replace(., 'ſ', 's')" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    -->

    <!--<xsl:template match="reg" name="reg">
        <reg xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:value-of select="replace(., 'ſ', 's')" />
        </reg>
    </xsl:template>-->
    
    <!-- 
        
    <xsl:template match="reg" name="reg">
        <xsl:analyze-string select="." regex="(\w*ſ\w*)">
            <xsl:matching-substring>
                <xsl:value-of select="replace(.,'ſ','s')"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>
    -->
    
</xsl:stylesheet>