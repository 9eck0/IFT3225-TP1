<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Bibliothèque IFT 3225</title>
            </head>
            <body>
                <section name="livres">
                    <xsl:apply-templates select="livres"/>
                </section>
                
                <section name="auteurs">
                    <h1>Livres</h1>
                </section>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="livres">
        <h1>Livres</h1>
        <table>
            <tr>
                <td>Titre</td>
                <td>Année</td>
                <td>Prix</td>
                <td>Couverture</td>
                <td>Commentaire</td>
                <td>Langue</td>
                <td>Auteur(s)</td>
            </tr>
            <xsl:apply-templates select="livre"/>
        </table>
    </xsl:template>
    
    <xsl:template match="livre">
        <tr>
            <xsl:apply-templates select="titre"/>
            <xsl:apply-templates select="annee"/>
        </tr>
    </xsl:template>
    
    <xsl:template match="titre">
        <td>
            <xsl:value-of select="text()"/>
        </td>
    </xsl:template>
    
    <xsl:template match="annee">
        <td>
            <xsl:value-of select="text()"/>
        </td>
    </xsl:template>
</xsl:stylesheet>