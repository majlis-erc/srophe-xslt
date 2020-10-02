<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">

    <!-- FILE OUTPUT PROCESSING -->
    <!-- specifies how the output file will look -->
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="xml"/>
    <!-- Relative path to directory where output files will go. -->
    <xsl:variable name="directory" select="'tei/'"/>
    <!-- Current version of data -->
    <xsl:variable name="version" select="'0.4'"/>

    <xsl:template match="/root/row">
        <xsl:if test="URI != ''">
            <xsl:variable name="uri" select="URI"/>
            <xsl:variable name="record-id" select="replace($uri, 'https://usaybia.net/place/', '')"/>


            <!-- creates a variable containing the path of the file to be created for this record, in the location defined by $directory -->
            <xsl:variable name="filename">
                <xsl:choose>
                    <!-- tests whether there is sufficient data to create a complete record. If not, puts it in an 'incomplete' folder inside the $directory -->
                    <xsl:when test="empty(Name__curated_)">
                        <xsl:value-of
                            select="concat($directory, '/incomplete/', $record-id, '.xml')"/>
                    </xsl:when>
                    <!-- if record is complete and has a URI, puts it in the $directory folder -->
                    <xsl:when test="URI != ''">
                        <xsl:value-of select="concat($directory, $record-id, '.xml')"/>
                    </xsl:when>
                    <!-- if record doesn't have a URI, puts it in 'unresolved' folder inside the $directory  -->
                    <xsl:otherwise>
                        <xsl:value-of select="concat($directory, 'unresolved/', $record-id, '.xml')"
                        />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <!-- creates the XML file, if the filename has been sucessfully created. -->
            <xsl:if test="$filename != ''">
                <xsl:result-document href="{$filename}" format="xml">
                    <!-- adds the xml-model instruction with the link to the Syriaca.org validator -->
                    <xsl:processing-instruction name="xml-model">
                        <xsl:text>href="https://raw.githubusercontent.com/srophe/srophe-eXist-app/master/documentation/schemas/out/syriacaPlaces.compiled.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:text>
                    </xsl:processing-instruction>
                    <xsl:processing-instruction name="xml-model">
                        <xsl:text>href="https://raw.githubusercontent.com/srophe/srophe-eXist-app/master/documentation/schemas/out/syriacaPlaces.compiled.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>
                    </xsl:processing-instruction>
                    <xsl:processing-instruction name="xml-model">
                        <xsl:text>href="https://raw.githubusercontent.com/srophe/srophe-eXist-app/master/documentation/schemas/uniqueLangHW.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:text>
                    </xsl:processing-instruction>

                    <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:srophe="https://srophe.app"
                        xmlns:syriaca="http://syriaca.org" xmlns:svg="http://www.w3.org/2000/svg"
                        xml:lang="en">
                        <teiHeader>
                            <fileDesc>
                                <titleStmt>
                                    <title level="a" xml:lang="en">
                                        <xsl:value-of select="Name__curated_"/>
                                    </title>
                                    <sponsor ref="https://www.uni-muenchen.de">
                                        <orgName>Ludwig Maximilian University of Munich</orgName>
                                            (<orgName xml:lang="de">Ludwig-Maximilians-Universität
                                            München</orgName>) </sponsor>
                                    <sponsor ref="http://www.naher-osten.uni-muenchen.de">
                                        <orgName>Institute of Near and Middle Eastern
                                            Studies</orgName> (<orgName xml:lang="de">Institut für
                                            den Nahen und Mittleren Osten</orgName>) </sponsor>
                                    <funder ref="https://www.bmbf.de/">
                                        <orgName>German Federal Ministry of Education and
                                            Research</orgName> (<orgName xml:lang="de"
                                            >Bundesministerium für Bildung und Forschung</orgName>) </funder>
                                    <principal ref="#ngibson">Nathan P. Gibson</principal>

                                    <!-- EDITORS -->
                                    <editor xml:id="ngibson" role="general"
                                        ref="https://usaybia.net/documentation/editors.xml#ngibson 
                                        http://syriaca.org/documentation/editors.html#ngibson 
                                        https://www.naher-osten.uni-muenchen.de/personen/wiss_ma/gibson/index.html
                                        http://orcid.org/0000-0003-0786-8075
                                        http://viaf.org/viaf/59147905242279092527"
                                        >Nathan P. Gibson</editor>

                                    <!-- CREATOR -->
                                    <!-- designates the editor responsible for creating this person record (may be different from the file creator) -->
                                    <editor role="creator" ref="#ngibson">Nathan P. Gibson</editor>

                                    <!-- CONTRIBUTORS -->
                                    <respStmt>
                                        <resp>The orignal version of this record was adapted from
                                            the index entry in A Literary History of Medicine: The
                                            “Uyūn al-Anbā” Fī Ṭabaqāt al-Aṭibbā’ of Ibn Abī
                                            Uṣaybi’ah, 5 vols. (Leiden: Brill, 2020) by</resp>
                                        <name>Emilie Savage-Smith</name>
                                        <name>Simon Swain</name>
                                        <name>G. J. H. van Gelder</name>
                                    </respStmt>
                                    <respStmt>
                                        <resp>Conversion into tabular and TEI-XML formats, data
                                            mining, and proofing by</resp>
                                        <name type="person" ref="#ngibson">Nathan P. Gibson</name>
                                    </respStmt>
                                    <respStmt>
                                        <resp>Original data architecture of TEI place records for
                                            Srophé by</resp>
                                        <name type="person"
                                            ref="http://syriaca.org/documentation/editors.xml#dmichelson"
                                            >David A. Michelson</name>
                                    </respStmt>
                                    <respStmt>
                                        <resp>Original data architecture of TEI place records for
                                            Srophé by</resp>
                                        <name type="person"
                                            ref="http://syriaca.org/documentation/editors.xml#tcarlson"
                                            >Thomas A. Carlson</name>
                                    </respStmt>
                                    <respStmt>
                                        <resp>Srophé app design and development by</resp>
                                        <name type="person"
                                            ref="http://syriaca.org/documentation/editors.xml#wsalesky"
                                            >Winona Salesky</name>
                                    </respStmt>
                                </titleStmt>
                                <editionStmt>
                                    <edition n="{$version}"/>
                                </editionStmt>
                                <publicationStmt>
                                    <authority>
                                        <ref target="https://usaybia.net">Usaybia.net</ref>
                                    </authority>
                                    <idno type="URI">
                                        <xsl:value-of select="concat($uri, '/tei')"/>
                                    </idno>
                                    <availability>
                                        <licence
                                            target="http://creativecommons.org/licenses/by/3.0/">
                                            <p>Distributed under a Creative Commons Attribution 4.0
                                                International (CC BY 4.0) License.</p>
                                        </licence>
                                    </availability>
                                    <date>
                                        <xsl:value-of select="current-date()"/>
                                    </date>
                                </publicationStmt>
                                <sourceDesc>
                                    <p>Born digital.</p>
                                </sourceDesc>
                            </fileDesc>
                            <encodingDesc>
                                <editorialDecl>
                                    <p>This record has been created following the Usaybia.net
                                        editorial guidelines. Documentation is available at: <ref
                                            target="https://usaybia.net/documentation"
                                            >https://usaybia.net/documentation</ref>.</p>
                                    <p>The editors have silently normalized data from other sources
                                        in some cases. The primary instances are listed below.</p>
                                    <p>Place names, descriptions, and entry numbers from the index
                                        of Emilie Savage-Smith, Simon Swain, and G. J. H. van Gelder
                                        (eds.), A Literary History of Medicine: The “Uyūn al-Anbā”
                                        Fī Ṭabaqāt al-Aṭibbā’ of Ibn Abī Uṣaybi’ah, 5 vols. (Leiden:
                                        Brill, 2020) were occasionally corrected for typographic
                                        errors. Alternate names drawn from cross-references were
                                        sometimes standardized to match the form appearing elsewhere
                                        in the index.</p>
                                </editorialDecl>
                                <classDecl>
                                    <taxonomy>
                                        <category xml:id="syriaca-headword">
                                            <catDesc>The name used by Syriaca.org for document
                                                titles, citation, and disambiguation. These names
                                                have been created according to the Syriac.org
                                                guidelines for headwords: <ref
                                                  target="http://syriaca.org/documentation/headwords.html"
                                                  >http://syriaca.org/documentation/headwords.html</ref>.</catDesc>
                                        </category>
                                    </taxonomy>
                                </classDecl>
                            </encodingDesc>
                            <profileDesc>
                                <langUsage>
                                    <p> Language codes used in this record follow the Usaybia.net
                                        guidelines. Documentation available at: <ref
                                            target="https://usaybia.net/documentation/langusage.xml"
                                            >https://usaybia.net/documentation/langusage.xml</ref>
                                    </p>
                                </langUsage>
                            </profileDesc>
                            <revisionDesc status="draft">
                                <change who="http://usaybia.net/documentation/editors.xml#ngibson"
                                    n="0.4" when="2020-07-22+02:00">CREATED: place from spreadsheet
                                    https://docs.google.com/spreadsheets/d/1B6vJjZjUbCX-oyqmrgVmVq7GmyqvaAjfBlzcIYnwhpQ.
                                    The canonical record is currently in the spreadsheet. Changes
                                    should be made there. THIS FILE SHOULD NOT BE MANUALLY
                                    EDITED!</change>
                                <change who="http://usaybia.net/documentation/editors.xml#ngibson"
                                    n="{$version}" when="{current-date()}">CHANGED: Updated places from spreadsheet
                                    https://docs.google.com/spreadsheets/d/1B6vJjZjUbCX-oyqmrgVmVq7GmyqvaAjfBlzcIYnwhpQ.
                                    The canonical record is currently in the spreadsheet. Changes
                                    should be made there. THIS FILE SHOULD NOT BE MANUALLY
                                    EDITED!</change>
                            </revisionDesc>
                        </teiHeader>
                        <text>
                            <body>
                                <listPlace>
                                    <!--adjust place types-->
                                    <place>
                                        <xsl:if 
                                            test="Place_Type__curated_[string-length() and .!='#N/A']">
                                            <xsl:attribute name="type" 
                                                select="Place_Type__curated_"/>
                                        </xsl:if>
                                        <placeName source="{concat('#bib',$record-id,'-1')}"
                                            xml:id="{concat('name',$record-id,'-1')}"
                                            xml:lang="en-x-lhom" srophe:tags="#syriaca-headword">
                                            <xsl:value-of select="Name__curated_"/>
                                        </placeName>
                                        <xsl:variable name="alt-names-joined"
                                            select="string-join((Alternate_Names, Alternate_Names__curated_), ', ')"/>
                                        <xsl:variable name="alt-names"
                                            select="distinct-values(tokenize($alt-names-joined, ',\s*'))"/>
                                        <xsl:for-each select="$alt-names">
                                            <xsl:variable name="index"
                                                select="index-of($alt-names, .)+1"/>
                                            <xsl:if test=". != ''">
                                                <placeName source="{concat('#bib',$record-id,'-1')}"
                                                  xml:id="{concat('name',$record-id,'-',$index[1])}"
                                                  xml:lang="en-x-lhom">
                                                  <xsl:value-of select="."/>
                                                </placeName>
                                            </xsl:if>
                                        </xsl:for-each>
                                        <xsl:if test="string-length(Identity__curated_)">
                                            <desc type="abstract" xml:id="abstract{$record-id}-1"
                                                xml:lang="en" source="#bib{$record-id}-1">
                                                  "<xsl:value-of select="Identity__curated_"/>"
                                            </desc>
                                        </xsl:if>
                                        <idno type="URI">
                                            <xsl:value-of select="$uri"/>
                                        </idno>
                                        <bibl xml:id="bib{$record-id}-1">
                                            <ptr target="https://usaybia.net/bibl/WVSJMDSV"/>
                                            <citedRange unit="p"><xsl:value-of select="Index_Page"/>
                                                (index)</citedRange>
                                            <xsl:for-each select="tokenize(Refs, ';\s*')">
                                                <citedRange unit="entry">
                                                  <xsl:value-of select="."/>
                                                </citedRange>
                                            </xsl:for-each>
                                        </bibl>
                                    </place>
                                </listPlace>
                                <xsl:if test="Related_Place[.!=''] and Related_Place_URI[.!='']">
                                    <listRelation>
                                        <relation name="see-also" mutual="{$uri} {Related_Place_URI}"/>
                                    </listRelation>
                                </xsl:if>                                
                            </body>
                        </text>
                    </TEI>
                </xsl:result-document>
            </xsl:if>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
