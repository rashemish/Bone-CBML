<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    
    <!-- Template to match the root element -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </title>
                <style>
                    body { font-family: Arial, sans-serif; background-color: #f9f9f9; margin: 20px; }
                    .panel { border: 1px solid #ddd; padding: 10px; margin-bottom: 10px; background-color: #fff; }
                    .caption { font-weight: bold; margin-bottom: 10px; }
                    .balloon { margin-left: 20px; }
                    .note { font-style: italic; color: gray; margin-left: 20px; }
                </style>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </h1>
                <p>
                    <strong>Author:</strong> 
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/>
                </p>
                <p>
                    <strong>Publisher:</strong> 
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>
                </p>
                <p>
                    <strong>Publication Date:</strong> 
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/>
                </p>
                <div>
                    <xsl:apply-templates select="tei:TEI/tei:text/tei:body/tei:div[@type='page']"/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for each page -->
    <xsl:template match="tei:div[@type='page']">
        <div class="page">
            <h2>Page <xsl:value-of select="@n"/></h2>
            <xsl:apply-templates select="tei:div[@type='panelGrp']/tei:div[@type='page']/cbml:panel"/>
        </div>
    </xsl:template>
    
    <!-- Template for each panel -->
    <xsl:template match="cbml:panel">
        <div class="panel">
            <div class="caption">
                <xsl:apply-templates select="cbml:caption"/>
            </div>
            <div>
                <xsl:apply-templates select="cbml:balloon"/>
            </div>
            <div class="note">
                <xsl:apply-templates select="tei:note[@type='panelDesc']"/>
            </div>
        </div>
    </xsl:template>
    
    <!-- Template for captions -->
    <xsl:template match="cbml:caption">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- Template for balloons -->
    <xsl:template match="cbml:balloon">
        <div class="balloon">
            <strong><xsl:value-of select="@who"/>:</strong>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- Template for notes -->
    <xsl:template match="tei:note">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>