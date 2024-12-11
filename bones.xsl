<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"    
    xmlns:xs="http://www.w3.org/2001/XMLSchema"    
    
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"   
    exclude-result-prefixes="xs math"   
    xmlns="http://www.w3.org/1999/xhtml"   
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title> Bone:Table of Contents</title>
            </head>
            <body>
                <h1>
                    <a href="cover.jpg">
                        <img src="cover.jpg" alt="orginal bones heading" />
                    </a>
                </h1>
                <h2>Table of Contents</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Page Number</th>
                            <th>Panels</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:apply-templates select="//div[@type='page']" mode="toc" />
                    </tbody>
                </table>
                
                <section id="reading-view">
                    <xsl:apply-templates select="//div[@type='page']" mode="reading-view" />
                </section>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="div[@type='page']" mode="toc">
        <tr>
            <td>
                <a href="#page-{position()}">
                    Page <xsl:value-of select="@n" />
                </a>
            </td>
            <td>
                <xsl:value-of select="string-join(distinct-values(cbml:panel/@id), ', ')" />
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="div[@type='page']" mode="reading-view">
        <section>
            <div id="page-{position()}" class="page-left">
                <h2>Page <xsl:value-of select="@n" /></h2>
                <!--<img src="{@n}.jpg" alt="Page <xsl:value-of select='@n' />-->
            </div>
            <div class="page-right">
                <h3>Page <xsl:value-of select="@n" /></h3>
                <xsl:for-each select="cbml:panel">
                    <p>
                        <strong>Dialogue:</strong>
                        <xsl:apply-templates select="cbml:balloon" />
                    </p>
                    <p>
                        <strong>Description:</strong>
                        <xsl:apply-templates select="note" />
                    </p>
                </xsl:for-each>
            </div>
        </section>
    </xsl:template>
    
    <xsl:template match="cbml:balloon">
        <xsl:value-of select="." />
    </xsl:template>
    
    <xsl:template match="note">
        <xsl:value-of select="." />
    </xsl:template>
</xsl:stylesheet>