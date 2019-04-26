<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei ="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <xsl:output method="html" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <!-- output HTML table with three columns: seg/@xml:id ; deponent ; accused -->
        <html>
            <head>
            </head>   
            <body>    
               <h3>Accusations of heresy</h3>
               <table>
                  <thead>
                      <tr>
                          <td>Deposition Seg ID</td>
                          <td>Deponent</td>
                          <td>Accused</td>
                          <td>Role</td>
                      </tr>
                  </thead>
                  <tbody>
                      <xsl:for-each select=".//tei:text[@xml:id]">
                          <!-- set deponent as variable -->
                          <xsl:variable name="deponent" select=".//tei:body//tei:persName[@role='dep']/@nymRef"/>
                          <!-- get accused except self-incriminations -->
                          <xsl:for-each select=".//tei:persName[@role='par' or @role='own'][@nymRef != $deponent]"> 
                              <tr>
                                  <td><xsl:value-of select="ancestor::tei:seg[@type='dep_event']/@xml:id"/></td>
                                  <td><xsl:value-of select="$deponent"/></td>
                                  <td><xsl:value-of select="./@nymRef"/></td>
                                  <td>
                                      <xsl:choose>
                                          <xsl:when test=".[@role='par']"><xsl:text>participant</xsl:text></xsl:when>
                                          <xsl:when test=".[@role='own']"><xsl:text>owner</xsl:text></xsl:when>
                                         <xsl:otherwise><xsl:text>unknown</xsl:text></xsl:otherwise>
                                      </xsl:choose>
                                  </td>
                              </tr>
                          </xsl:for-each>
                      </xsl:for-each>
                  </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>