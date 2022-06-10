<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!--
        TP1
        Par:
        - Liu, Rui Jie
        - Lian, Henxing
    -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Bibliothèque IFT 3225</title>
                <link rel="stylesheet" href="bibliotheque.css"></link>
            </head>
            <body>
                <div class="main-column">
                    <section name="livres">
                        <xsl:apply-templates select="bibliotheque/livres"/>
                    </section>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="bibliotheque/livres">
        <h1>Livres</h1>
        <table class="table-display">
            <tr class="table-header">
                <th>Titre</th>
                <th>Langue</th>
                <th>Auteur(s)</th>
                <th>Année</th>
                <th>Prix</th>
                <th>Couverture</th>
                <th>Commentaire</th>
            </tr>
            
            <xsl:for-each select="livre">
                <!-- Triage en ordre décroissant de prix -->
                <xsl:sort select="prix" order="descending"/>
                <tr>
                    <xsl:apply-templates select="titre"/>
                    <td><xsl:value-of select="@langue"/></td>
                    <td>
                        <!-- Méthode d'accès des éléments à partir de leur ID prise de:
                             https://stackoverflow.com/questions/40806811/xslt-select-one-idref-and-find-corr-element -->
                        <xsl:for-each select="for $ref in tokenize(@auteurs) return key('auteur', $ref)">
                            <xsl:value-of select="prenom"/>&#160;<xsl:value-of select="nom"/>
                            <!-- Ajout de séparateur de ligne entre les auteurs -->
                            <xsl:if test="position() != last()">
                                <br/>
                            </xsl:if>
                        </xsl:for-each>
                    </td>
                    <xsl:apply-templates select="annee"/>
                    <xsl:apply-templates select="prix"/>
                    <td>
                        <xsl:apply-templates select="couverture"/>
                    </td>
                    <td class="book-comments">
                        <xsl:apply-templates select="commentaire"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
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
    
    <xsl:template match="prix">
        <td>
            <xsl:sequence>
                <xsl:value-of select="text()"/>
                &#160; <!-- espace -->
                <xsl:choose>
                    <xsl:when test="@devise">
                        <xsl:value-of select="@devise"/>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:sequence>
        </td>
    </xsl:template>
    
    <xsl:template match="couverture">
        <img class="book-cover">
            <xsl:attribute name="src">
                <xsl:value-of select="text()"/>
            </xsl:attribute>
        </img>
    </xsl:template>
    
    <xsl:template match="commentaire">
        <xsl:value-of select="text()"/>
    </xsl:template>
    
</xsl:stylesheet>