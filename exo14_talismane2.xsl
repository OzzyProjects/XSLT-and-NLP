<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:saxon="http://saxon.sf.net/" extension-element-prefixes="saxon"
    xmlns:str="http://exslt.org/strings" exclude-result-prefixes="saxon str" >
    <xsl:output method="html" encoding="utf-8"/>
    <xsl:variable name="count" saxon:assignable="yes" select="1"/>	

    <xsl:template match="/">
        <xsl:comment>Toutes les feuilles de style utilisent XSLT 2.0 et doivent être "compilées" avec Saxon-EE 3.9.8 sur Oxygen</xsl:comment>
        <xsl:text disable-output-escaping='yes'>&#xD;&#xA;</xsl:text>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:text disable-output-escaping='yes'>&#xD;&#xA;</xsl:text>
        <html>
            <body>
                <table border="1" width="100%" style="border-width : 3px solid black; table-layout:fixed; border-collapse: collapse;">
                    <thead>
                        <tr style="font-weight : bold; background-color : #80d4ff; border-bottom: solid blue;">
                            <th width="50%">Titres</th>
                            <th width="50%">Descriptions</th>
                        </tr>
                    </thead>
                    <xsl:variable name="titres">
                        <xsl:apply-templates select="//titre"/>
                    </xsl:variable>
                    <xsl:variable name="descriptions">
                        <xsl:apply-templates select="//description"/>
                    </xsl:variable>
                    <saxon:while test="$count &lt; count($titres/titre)">
                        <xsl:choose>
                            <xsl:when test="$count mod 2 = 0">
                                <tr style="background-color : #ccf3ff;">
                                    <td width="%50%"><xsl:value-of select="$titres/titre[$count]"/></td>
                                    <td width="%50%"><xsl:value-of select="$descriptions/description[$count]"/></td>
                                </tr>
                            </xsl:when>
                            <xsl:otherwise>
                                <tr style="background-color : #e6f9ff;">
                                    <td width="%50%"><xsl:value-of select="$titres/titre[$count]"/></td>
                                    <td width="%50%"><xsl:value-of select="$descriptions/description[$count]"/></td>
                                </tr>
                            </xsl:otherwise>
                        </xsl:choose>
                        <saxon:assign name="count" select="$count+1"/>
                    </saxon:while>
                </table>
            </body>
        </html>       
    </xsl:template> 
    
    <xsl:template match="titre">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="description">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    
    <xsl:template match="p">
        <xsl:variable name="para">
            <xsl:for-each select="item/a[2]">
                <xsl:value-of select="." />
                <xsl:comment>0n n'ajoute pas d'espace entre le dernier mot et le point final</xsl:comment>
                <xsl:if test="position()!=last()- 2">
                    <xsl:text xml:space="preserve"> </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="tokenize($para, '§')"/>
    </xsl:template>
    
</xsl:stylesheet>