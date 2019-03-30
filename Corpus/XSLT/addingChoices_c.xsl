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
    
    <xsl:template match="c" priority="1">
        <xsl:choose>
            <xsl:when test="@type='a'">
                <choice xmlns="http://www.tei-c.org/ns/1.0"><abbr><xsl:apply-templates/></abbr><expan><xsl:value-of select="substring-after(@ana,'_')"/></expan></choice>
            </xsl:when>
            <xsl:otherwise>
                <choice xmlns="http://www.tei-c.org/ns/1.0"><orig><xsl:apply-templates/></orig><reg ana="{@ana}"><xsl:value-of select="substring-after(@ana,'_')"/></reg></choice>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>