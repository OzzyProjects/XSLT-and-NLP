<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8"/>

<xsl:template match ="/">

	<xsl:comment>Toutes les feuilles de style utilisent XSLT 2.0 et la transformation doit être réalisée sur Oxygen avec Saxon-EE 9.8</xsl:comment>
	
    <xsl:text disable-output-escaping='yes'>&#xD;&#xA;</xsl:text>
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <xsl:text disable-output-escaping='yes'>&#xD;&#xA;</xsl:text>
	<html>
		<h1>Poème du père Duchesne</h1>
		<body>
		    <xsl:for-each-group select="//w" group-ending-with="w[forme='.']"><p>
		    	<xsl:for-each select="current-group()">
		          	<xsl:choose>
		            	<xsl:when test="position()=1">
		                	<xsl:value-of select="concat(upper-case(substring(forme/text(),1,1)),
		                	substring(forme/text(), 2), ' '[not(last() )], ' ')"/>
		            	</xsl:when>
		            	<xsl:when test="(contains(lemme/text(), 'aristocrate') or contains(lemme/text(), 'patriote')) and (contains(forme/text(), '.') and not(ends-with(forme/text(), '.')))">
		                	<xsl:call-template name="splitted_color">
		                	<xsl:with-param name="text" select="forme/text()"/>
		                	</xsl:call-template>
		           		</xsl:when>
		           		<xsl:when test="contains(lemme/text(), 'aristocrate') or contains(lemme/text(), 'patriote')">
		               		<b><font color="red"><xsl:value-of select="concat(forme/text(), ' ')"/></font></b>
		           		</xsl:when>
		           		<xsl:when test="contains(forme/text(), '.') and not(ends-with(forme/text(), '.'))">
		               		<xsl:variable name="maj">
		                  		<xsl:call-template name="upper">
		                  		<xsl:with-param name="text" select="forme/text()"/>
		                  		</xsl:call-template>
		              		</xsl:variable>
		                	<xsl:value-of select="concat(substring-before(forme/text(), '.'), ' . ')"/>
		                	<xsl:value-of select="concat($maj, ' ')"/>
		         		</xsl:when>
             			<xsl:when test="ends-with(forme/text(), '.')">
                  			<xsl:value-of select="forme/text()"/>
             			</xsl:when>
		     			<xsl:otherwise>
		             		<xsl:value-of select="concat(forme/text(), ' ')"/>
		     			</xsl:otherwise>
		       		</xsl:choose>
		      	</xsl:for-each>
		    </p></xsl:for-each-group>
	  	</body>
  	</html>
</xsl:template>
   
<xsl:template name="upper">
	<xsl:param name="text"/>
  		<xsl:variable name="trans" select="substring-after($text, '.')"/>
  		<xsl:value-of select="concat(upper-case(substring($trans, 1, 1)), substring($trans, 2), ' '[not(last())])" />
</xsl:template>
  
<xsl:template name="splitted_color">
    <xsl:param name="text"/>
    <xsl:variable name="before" select="substring-before($text, '.')"/>
    <xsl:variable name="after" select="substring-after($text, '.')"/>
    	<xsl:choose>
      		<xsl:when test="contains($before, 'aristocrate') or contains($before, 'patriote')">
        		<b><font color="red"><xsl:value-of select="concat($before, ' . ')"/></font></b>
        		<xsl:value-of select="concat(upper-case(substring($after, 1, 1)), substring($after, 2), ' '[not(last())], ' ')" />
      		</xsl:when>
      		<xsl:otherwise>
        		<xsl:value-of select="concat($before, '. ')" />
        		<b><font color="red"><xsl:value-of select="concat(upper-case(substring($after, 1, 1)), substring($after, 2), ' '[not(last())], ' ')"/></font></b>
      		</xsl:otherwise>
  		</xsl:choose>
</xsl:template>


</xsl:stylesheet>