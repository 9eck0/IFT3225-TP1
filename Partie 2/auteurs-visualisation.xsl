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
    
    <!-- Cette variable, selection_auteur, permet de spécifier tous les livres d'un auteur spécifique (par son ID) à afficher.
         Si laissée vide, aucune sélection ne sera effectuée et tous les auteurs seront affichés. -->
    <xsl:variable name="selection_auteur"></xsl:variable>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Bibliothèque IFT 3225</title>
                <link rel="stylesheet" href="bibliotheque.css"></link>
            </head>
            <body>
                <div class="main-column">
                    <section name="auteurs">
                        <xsl:apply-templates select="bibliotheque/auteurs"/>
                    </section>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="bibliotheque/auteurs">
        <h1>Auteurs</h1>
        <table class="table-display">
            <tr class="table-header">
                <th>Photo</th>
                <th>Nom</th>
                <th>Prenom</th>
                <th>Pays</th>
                <th>Commentaire</th>
                <th>Livres</th>
            </tr>
            <xsl:apply-templates select="auteur"/>
        </table>
    </xsl:template>
    
    <xsl:template match="auteur">
        <xsl:choose>
            <xsl:when test="$selection_auteur != '' and @ident != $selection_auteur">
                <!-- Auteur spécifié en variable && pas l'auteur recherché -> skip au prochain -->
            </xsl:when>
            <xsl:otherwise>
                <tr>
                    <xsl:attribute name="id">
                        <xsl:value-of select="@ident"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="photo"/>
                    <xsl:apply-templates select="nom"/>
                    <xsl:apply-templates select="prenom"/>
                    <xsl:apply-templates select="pays"/>
                    <td class="book-comments">
                        <xsl:apply-templates select="commentaire"/>
                    </td>
                    <xsl:apply-templates select="livre"/>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="photo">
        <td>
            <xsl:choose>
                <xsl:when test="text() != ''">
                    <img class="author-image">
                        <xsl:attribute name="src">
                            <xsl:value-of select="text()"/>
                        </xsl:attribute>
                    </img>
                </xsl:when>
                <xsl:otherwise>
                    <img class="author-image" src="https://st4.depositphotos.com/11634452/41441/v/380/depositphotos_414416674-stock-illustration-picture-profile-icon-male-icon.jpg"/>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </xsl:template>
    
    <xsl:template match="nom">
        <td>
            <xsl:value-of select="text()"/>
        </td>
    </xsl:template>
    
    <xsl:template match="prenom">
        <td>
            <xsl:value-of select="text()"/>
        </td>
    </xsl:template>
    
    <xsl:template match="pays">
        <td>
            <xsl:value-of select="text()"/>
        </td>
    </xsl:template>
    
    <xsl:template match="commentaire">
        <xsl:value-of select="text()"/>
    </xsl:template>
    
    <xsl:template match="livre">
        <td>
            <table class="table-display">
                <tr class="table-header">
                    <th>Titre</th>
                    <th>Langue</th>
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
        </td>
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
    
</xsl:stylesheet>