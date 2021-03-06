<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" encoding="UTF-8"/>
    
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
                    
                    <section name="auteurs">
                        <xsl:apply-templates select="bibliotheque/auteurs"></xsl:apply-templates>
                    </section>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:key name="auteur" match="auteur" use="@ident"/>
    
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
                <xsl:value-of select="text()"/>&#160; <!-- espace -->
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
    
    
    
    <xsl:template match="bibliotheque/auteurs">
        <h1>Auteurs</h1>
        <table class="table-display">
            <tr class="table-header">
                <th>Photo</th>
                <th>Nom</th>
                <th>Prenom</th>
                <th>Pays</th>
                <th>Commentaire</th>
            </tr>
            <xsl:apply-templates select="auteur"/>
        </table>
    </xsl:template>
    
    <xsl:template match="auteur">
        <tr>
            <a>
                <xsl:attribute name="id">
                    <xsl:value-of select="@ident"/>
                </xsl:attribute>
            </a>
            <xsl:apply-templates select="photo"/>
            <xsl:apply-templates select="nom"/>
            <xsl:apply-templates select="prenom"/>
            <xsl:apply-templates select="pays"/>
            <td class="book-comments">
                <xsl:apply-templates select="commentaire"/>
            </td>
        </tr>
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
</xsl:stylesheet>