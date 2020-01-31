<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="tei"
    version="2.0">
  <xsl:output method="html" indent="yes" />
  <xsl:template match="/">
    <html>
            <head>
                <link href="style.css" rel="stylesheet" type="text/css" />
                <meta charset="UTF-8" />
                <title> 
                    <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </title>
                
            </head>
            <body>
                <!-- parte introduttiva -->
                <header>
                    <h1 id="titolo">Cartoline</h1>
                    <nav>
                        <ul>
                            <li> <a href="#cartolina22" > XXII </a> </li>
                            <li> <a href="#cartolina99"> XCIX </a> </li>
                            <li> <a href="#about"> About </a></li>
                        </ul>
                    </nav>
                    <div id="introduzione">   
                        <p>
                            Questo sito è stato realizzato per il progetto del corso di Codifica di Testi a.a. 2019/2020 del corso di laurea in Informatica Umanistica. <br/>
                            Le due cartoline qui presentate provengono dal <i> <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository"/> </i>, del comune di 
                            <i> <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:settlement"/></i>.
                            <br/>
                            Le cartoline sono state scritte durante la Prima Guerra Mondiale e riguardano la corrispondenza di una coppia d'innamorati, Oliva Turtura e Giovanni Coliola. 
                            <br/>
                        </p>
                    </div>
                    
                </header>
                <section id="cartolina22">
                    <div class="cont">
                        <xsl:apply-templates select="//tei:teiCorpus[@xml:id='cart22']"/>
                    </div>
                </section>
                <section id="cartolina99">
                    <div class="cont">
                        <xsl:apply-templates select="//tei:teiCorpus[@xml:id='cart99']"/>
                    </div>
                </section>
                <section id="about">
                    <div class="cont">
                        <xsl:apply-templates select="//tei:teiCorpus/tei:teiHeader[@xml:id='main']"/>
                    </div>
                </section>
            </body>
        </html>
    </xsl:template>
 
    <!-- template informazioni -->
    <xsl:template match="tei:teiCorpus[@xml:id='cart22' or @xml:id='cart99']/tei:teiHeader/tei:fileDesc">
        <div class="info">
            <div class="informazioni">
                <h2> <xsl:value-of select="tei:titleStmt/tei:title"/> </h2>
                <p>
                    <xsl:for-each select="tei:notesStmt/tei:note">
                        <xsl:value-of select="."/>
                    </xsl:for-each>
                </p>
                <h4><xsl:value-of select="tei:sourceDesc/tei:bibl/tei:title[@type='custom']"/></h4>
                <p>
                    Scritto da <i><xsl:value-of select="tei:sourceDesc/tei:bibl/tei:author"/></i>, nel <xsl:value-of select="tei:sourceDesc/tei:bibl/tei:date"/>.
                </p>
                <p> 
                    <b> Codice identificativo: </b>
                    <xsl:value-of select="tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:idno"/>
                </p>
                <p> 
                <b> Condizione: </b>
                <xsl:value-of select="tei:sourceDesc/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:condition"/>
                </p>
            </div>
            <xsl:apply-templates select="tei:sourceDesc/tei:listPerson"/>
            <xsl:apply-templates select="tei:sourceDesc/tei:listPlace"/>
        </div>
    </xsl:template>
    
    <!-- PERSONE -->
    <xsl:template match="tei:listPerson">
        <div class="persone">
                <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:person">
        <div class="persona">
            <p> <b>Nome: </b> <xsl:value-of select="tei:persName/tei:forename"/></p>
            <p> <b>Cognome: </b> <xsl:value-of select="tei:persName/tei:surname"/></p>
            <p> <b>Sesso: </b> <xsl:value-of select="tei:sex"/></p>
        </div>
    </xsl:template>
    
    <!-- LUOGHI -->
    <xsl:template match="tei:listPlace">
        <div class="luogo">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:place">
        <div class="place">
            <p> <b>Luogo: </b><xsl:value-of select="tei:settlement"/> di <xsl:value-of select="tei:placeName"/> 
                (<xsl:value-of select="tei:district[@type='provincia']"/>), 
                <xsl:value-of select="tei:country"/>.
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:correspDesc">
        <div class="corrispondenze">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- MITTENTE E DESTINATARIO -->
    <xsl:template match="tei:correspAction[@type='sent']">
        <div class="mittente">
            <p> <b>Mittente: </b>
                <xsl:value-of select="tei:persName"/>
            </p>
            <p> <b>Luogo: </b>
                <xsl:value-of select="tei:placeName"/>
            </p>
            <p> <b>Data: </b>
                <xsl:value-of select="tei:date"/>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:correspAction[@type='received']">
        <div class="destinatario">
            <p> <b>Destinatario: </b>
                <xsl:value-of select="tei:persName"/>
            </p>
        </div>
    </xsl:template>
    
    <!-- TIPOLOGIA -->
    <xsl:template match="tei:textClass">
        <div class="descr">
            <p>
                <b>Tipologia: </b> <xsl:value-of select="tei:keywords/tei:term[@type='descr1']"/>
                - <xsl:value-of select="tei:keywords/tei:term[@type='descr2']"/>
            </p>
        </div>
    </xsl:template>
    
    <!-- LINGUA -->
    <xsl:template match="tei:langUsage">
        <div class="lingua">
            <p><b>Lingua: </b> <xsl:apply-templates/> </p>
        </div>
    </xsl:template>
    
    <!-- immagine fronte e retro-->
    <xsl:template match="tei:facsimile">
        <div class="immagine">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:surface[@xml:id='retro022' or @xml:id='retro099']/tei:graphic">       
        <div class="imgretro"> 
            <img src="{@url}"/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:surface[@xml:id='fronte022' or @xml:id='fronte099']/tei:graphic">       
        <div class="imgfronte">
            <img src="{@url}"/>
        </div>
    </xsl:template>  
    
    <!-- template fronte -->
    <xsl:template match="tei:text">
        <div class="corpo">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- descrizione della cartolina + note -->
    
    <xsl:template match="tei:figure">
        <div class="fronte">
            <p> <xsl:value-of select="tei:figDesc"/>
                <xsl:for-each select="tei:note">
                    <xsl:value-of select="."/>
                </xsl:for-each>
            </p>
       </div>
    </xsl:template>
    
    <!-- codifica del fronte e del retro -->
     
    <xsl:template match="tei:div[@type='message']">
        <div class="testo">
           <p>
               <xsl:apply-templates/> 
           </p> 
        </div>
    </xsl:template>
    
    <xsl:template match="tei:div[@xml:id='part2']">
        <div class="testofronte">
            <p>
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br />
    </xsl:template>
       
    <xsl:template match="tei:choice">
        <i>
            <xsl:value-of select="tei:abbr"/>
        </i>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='codice']">
        <div class="archivio">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- FOOTER -->
    <xsl:template match="tei:title">
        <h1> <xsl:value-of select="."/> </h1>
    </xsl:template>
    <xsl:template match="tei:respStmt">
        <div>
            <p> <b> <xsl:value-of select="tei:resp"/>: </b> </p>
            <p> <xsl:for-each select="tei:name">
                <xsl:value-of select="."/>
                </xsl:for-each>
            </p>
        </div>
    </xsl:template>
    <!-- edizione -->
    <xsl:template match="tei:edition">
        <div>
            <p> 
                <i>
                    <xsl:value-of select="."/> - anno 
                    <xsl:value-of select="tei:date"/>
                </i>
            </p>
        </div>
    </xsl:template>
    <xsl:template match="tei:publicationStmt">
        <div>
            <p>
                <i>
                    Pubblicazione <xsl:value-of select="tei:publisher"/> 
                    (<xsl:value-of select="tei:pubPlace"/>) - 
                    <xsl:value-of select="tei:availability/tei:p"/>
                </i> 
            </p>
        </div>
    </xsl:template>
    <xsl:template match="tei:sourceDesc">
        <div>
            <p>
                <i>
                    <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:country"/> - 
                    <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:settlement"/> <br/>
                    <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:repository"/>
                </i>
            </p>
        </div>
  </xsl:template>
</xsl:stylesheet>
