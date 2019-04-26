<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei ="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <!-- output 3 columns: seg/@xml:id ; deponent ; accused -->
        <xsl:text>deposition_segment~deponent~accused~role&#10;</xsl:text>
        <xsl:for-each select=".//tei:text[@xml:id]">
            <!-- set deponent as variable -->
            <xsl:variable name="deponent" select=".//tei:body//tei:persName[@role='dep']/@nymRef"/>
            <!-- get accused except self-incriminations -->
            <xsl:for-each select=".//tei:persName[@role='par' or @role='own'][@nymRef != $deponent]">
                <xsl:value-of select="ancestor::tei:seg[@type='dep_event']/@xml:id"/>
                <xsl:text>~</xsl:text>
                <xsl:value-of select="$deponent"/>
                <xsl:text>~</xsl:text>
                <xsl:value-of select="./@nymRef"/>
                <xsl:text>~</xsl:text>
                <xsl:choose>
                    <xsl:when test=".[@role='par']"><xsl:text>participant</xsl:text></xsl:when>
                    <xsl:when test=".[@role='own']"><xsl:text>owner</xsl:text></xsl:when>
                    <xsl:otherwise><xsl:text>unknown</xsl:text></xsl:otherwise>
                </xsl:choose>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>