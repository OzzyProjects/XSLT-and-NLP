<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8"/>    
    
    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&#xD;&#xA;</xsl:text>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:text disable-output-escaping='yes'>&#xD;&#xA;</xsl:text>
        
        <html>
            <body>
                <h2><i><font color="blue">Titres, patron NOM-ADJ</font></i></h2>
                <xsl:apply-templates select="//p[@type='titre']">
                    <xsl:with-param name="pos1" select="'NC'"/>
                    <xsl:with-param name="pos2" select="'ADJ'"></xsl:with-param>
                </xsl:apply-templates>
                
                <h2><i><font color="blue">Descriptions, patron DET-NOM</font></i></h2>
                <xsl:apply-templates select="//p[@type='description']">
                    <xsl:with-param name="pos1" select="'DET'"/>
                    <xsl:with-param name="pos2" select="'NC'"></xsl:with-param>
                </xsl:apply-templates>
            </body>
        </html>       
    </xsl:template> 
    
 <xsl:template match="p">
     <xsl:param name="pos1"></xsl:param>
     <xsl:param name="pos2"></xsl:param>
     
    <p>
    <xsl:for-each select="item">
        <xsl:if test="position() != last()">
            <xsl:choose>                
                <xsl:when test="(contains(a[4],$pos1) and contains(following-sibling::*[1]/a[4], $pos2)) or (contains(a[4], $pos2) and contains(preceding-sibling::*[1]/a[4], $pos1))">
                    <span style="border:1px; border-style:solid; border-color:#FF0000; padding: 1px;background-color : #ffe6e6; color : #cc0000; font-weight: bold;"><xsl:value-of select="a[2]"/></span>
                </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="a[2]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
        <xsl:if test="position() &lt; last()-2">
            <xsl:text>&#160;</xsl:text>
        </xsl:if>
   </xsl:for-each>
   </p>
     
 </xsl:template> 
    
</xsl:stylesheet>