<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xml" />
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" />
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="anchor">
        <xsl:choose>
            <xsl:when test="ends-with(@xml:id, 's')">
                <xsl:variable name="id">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="@xml:id"/>
                </xsl:variable>
                <xsl:copy-of select="//app[@from=$id]"/>
            </xsl:when>
            <xsl:when test="ends-with(@xml:id, 'e')">
                <xsl:variable name="id">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="@xml:id"/>
                </xsl:variable>
                <xsl:copy-of select="//note[@target=$id]"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="text()[preceding::anchor[1][ends-with(@xml:id, 's')]=following::anchor[1][ends-with(@xml:id, 'e')]]"/>
    
    <!--<xsl:template match="anchor"/>
    <xsl:template match="text()[preceding::anchor[1][ends-with(@xml:id, 's')]=following::anchor[1][ends-with(@xml:id, 'e')]]">
        <xsl:variable name="id">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="preceding::anchor[1]/@xml:id"/>
        </xsl:variable>
        <xsl:copy-of select="//app[@from=$id]"/>-->



</xsl:stylesheet>
