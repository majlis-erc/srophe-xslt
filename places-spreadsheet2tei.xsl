<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/root/row">
        <xsl:if test="string-length(URI)">
            <xsl:variable name="uri" select="URI"/>
            <xsl:variable name="id" select="replace($uri,'https://usaybia.net/place/','')"/>
            <TEI xmlns="http://www.tei-c.org/ns/1.0" 
                xmlns:srophe="https://srophe.app" 
                xmlns:syriaca="http://syriaca.org" 
                xmlns:svg="http://www.w3.org/2000/svg" 
                xml:lang="en">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title level="a" xml:lang="en">
                                <xsl:value-of select="Name__curated_"/>
                            </title>
                            <sponsor>Syriaca.org: The Syriac Reference Portal</sponsor>
                            <funder>The National Endowment for the Humanities</funder>
                            <funder>The International Balzan Prize Foundation</funder>
                            <editor role="creator" ref="http://syriaca.org/documentation/editors.xml#dschwartz">Daniel L. Schwartz</editor>
                            <respStmt>
                                <resp>Data collected and record created by</resp>
                                <name ref="http://syriaca.org/documentation/editors.xml#dschwartz">Daniel L. Schwartz</name>
                            </respStmt>
                        </titleStmt>
                        <editionStmt>
                            <edition n="2.0"/>
                        </editionStmt>
                        <publicationStmt>
                            <authority>Syriaca.org: The Syriac Reference Portal</authority>
                            <idno type="URI"><xsl:value-of select="concat($uri,'/tei')"/></idno>
                            <availability>
                                <licence target="http://creativecommons.org/licenses/by/3.0/">
                                    <p>Distributed under a Creative Commons Attribution 3.0 Unported License.</p>
                                </licence>
                            </availability>
                            <date><xsl:value-of select="current-date()"/></date>
                        </publicationStmt>
                        <seriesStmt>
                            <title level="s" xml:lang="en">The Syriac Gazetteer</title>
                            <editor role="general" ref="http://syriaca.org/documentation/editors.xml#dmichelson">
                                <persName>David A. Michelson</persName>, <date from="2014">2014-present</date>.</editor>
                            <editor role="general" ref="http://syriaca.org/documentation/editors.xml#wpotter">
                                <persName>William L. Potter</persName>, <date from="2020">2020-present</date>.</editor>
                            <editor role="past-general" ref="http://syriaca.org/documentation/editors.xml#tcarlson">
                                <persName>Thomas A. Carlson</persName>, <date from="2014" to="2018">2014-2018</date>
                            </editor>
                            <editor role="technical" ref="http://syriaca.org/documentation/editors.xml#dmichelson">
                                <persName>David A. Michelson</persName>, <date from="2014">2014-present</date>.</editor>
                            <editor role="technical" ref="http://syriaca.org/documentation/editors.xml#dschwartz">
                                <persName>Daniel L. Schwartz</persName>, <date from="2019">2019-present</date>.</editor>
                            <editor role="technical" ref="http://syriaca.org/documentation/editors.xml#wpotter">
                                <persName>William L. Potter</persName>, <date from="2020">2020-present</date>.</editor>
                            <idno type="URI">http://syriaca.org/geo</idno>
                        </seriesStmt>
                        <sourceDesc>
                            <p>Born digital.</p>
                        </sourceDesc>
                    </fileDesc>
                    <encodingDesc>
                        <editorialDecl>
                            <p>This record has been created following the Syriaca.org editorial guidelines. Documentation is available at: <ref target="http://syriaca.org/documentation">http://syriaca.org/documentation</ref>. <title>The Syriac Gazetteer</title> was encoded using both the general editorial guidelines for all publications of Syriaca.org and an encoding schema specific to <title>The Syriac Gazetteer</title>.</p>
                            <p>Approximate dates described in terms of centuries or partial centuries have been interpreted into quantitative values as documented in the Syriaca.org guidelines for normalization of dates. See <ref target="http://syriaca.org/documentation/dates.html">Syriaca.org Guidelines for Approximate Dates</ref>.</p>
                            <p>The <gi>state</gi> element of @type="existence" indicates the period for which this place was in use as a place of its indicated type (e.g. an inhabited settlement, a functioning monastery or church, an administrative province).  While it is possible to indicate a source for this date, this date is usually based on the estimate of the editors and provided as an aid to searching. As a practice, attested dates for a place based on historical sources have instead been encoded more precisely using <gi>event</gi> of @type="attestation". Natural features which have always existed have no date on the <gi>state</gi> element of @type="existence" since they are are presumed to have always existed throughout recorded history.</p>
                            <p>In some cases, maps from print publications have been used as the basis for coordinate data in <title>The Syriac Gazetteer</title>. In two instances, the editors of such print maps provided the digital coordinate data used to prepare the print maps. Specifically, coordinates which are attributed to <title>The Gorgias Encyclopedic Dictionary of the Syriac Heritage</title> (<ref target="http://syriaca.org/bibl/1">http://syriaca.org/bibl/1</ref>) or to <title>The Syriac World</title> (<ref target="http://syriaca.org/bibl/PUTG99V4">http://syriaca.org/bibl/PUTG99V4</ref>) were extracted from the KML files used to create the print maps for those volumes. Because only the print maps were published, the citation for these coordinates refers to the print source. The editors of the <title>The Syriac Gazetteer</title> are grateful to the editors of <title>The Gorgias Encyclopedic Dictionary of the Syriac Heritage</title> and <title>The Syriac World</title> for providing these coordinate files.</p>
                            <p>The editors have silently normalized data from other sources in some cases. The primary instances are listed below.</p>
                            <p>The capitalization of names from <title>The Gorgias Encyclopedic Dictionary of the Syriac Heritage</title> (<ref target="http://syriaca.org/bibl/1">http://syriaca.org/bibl/1</ref>) was normalized silently (i.e. names in ALL-CAPS were replaced by Proper-noun capitalization).</p>
                            <p>The unchanging parts of alternate names from the editions and translations of Barsoum, <title>The Scattered Pearls: A History of Syriac Literature and Sciences</title> (<ref target="http://syriaca.org/bibl/2">http://syriaca.org/bibl/2</ref>, <ref target="http://syriaca.org/bibl/3">http://syriaca.org/bibl/3</ref>, or <ref target="http://syriaca.org/bibl/4">http://syriaca.org/bibl/4</ref>) have been supplied silently.</p>
                            <p>Names from the English translation of Barsoum, <title>The Scattered Pearls: A History of Syriac Literature and Sciences</title> (<ref target="http://syriaca.org/bibl/4">http://syriaca.org/bibl/4</ref>) were silently transformed into sentence word order rather than the headword alphabetization used by Barsoum.  Commas were silently removed.</p>
                        </editorialDecl>
                        <classDecl>
                            <taxonomy>
                                <category xml:id="syriaca-headword">
                                    <catDesc>The name used by Syriaca.org for document titles, citation, and disambiguation. These names have been created according to the Syriac.org guidelines for headwords: <ref target="http://syriaca.org/documentation/headwords.html">http://syriaca.org/documentation/headwords.html</ref>.</catDesc>
                                </category>
                            </taxonomy>
                        </classDecl>
                    </encodingDesc>
                    <profileDesc>
                        <langUsage>
                            <p>
                                Languages codes used in this record follow the Syriaca.org guidelines. Documentation available at: 
                                <ref target="http://syriaca.org/documentation/langusage.xml">http://syriaca.org/documentation/langusage.xml</ref>
                            </p>
                        </langUsage>
                    </profileDesc>
                    <revisionDesc status="draft">
                        <change who="http://syriaca.org/documentation/editors.xml#dschwartz" when="2020-07-13">CREATED: place</change>
                    </revisionDesc>
                </teiHeader>
                <text>
                    <body>
                        <listPlace>
                            <!--adjust place types-->
                            <place type="settlement">
                                <placeName 
                                    source="{concat('#bib',$id,'-1')}" 
                                    xml:id="{concat('name',$id,'-1')}" 
                                    xml:lang="en-x-lhom" 
                                    srophe:tags="#syriaca-headword">
                                    <xsl:value-of select="Name__curated_"/>
                                </placeName>
                                <xsl:variable name="alt-names-joined"
                                    select="string-join((Alternate_Names,Alternate_Names__curated_),', ')"/>
                                <xsl:variable name="alt-names"
                                    select="tokenize($alt-names-joined,',\s*')"/>
                                <xsl:for-each select="$alt-names">
                                    <xsl:variable name="index" select="index-of($alt-names,.)"/>
                                    <placeName 
                                        source="{concat('#bib',$id,'-1')}" 
                                        xml:id="{concat('name',$id,'-',$index[1])}" 
                                        xml:lang="en-x-lhom">
                                        <xsl:value-of select="."/>
                                    </placeName>
                                </xsl:for-each>
                                <xsl:if test="string-length(Identity__curated_)">
                                    <desc type="abstract" xml:id="abstract{$id}-1" xml:lang="en" source="#bib{$id}-1">
                                        "<xsl:value-of select="Identity__curated_"/>"
                                    </desc>
                                </xsl:if>
                                <idno type="URI"><xsl:value-of select="$uri"/></idno>
                                <bibl xml:id="bib{$id}-1">
                                    <ptr target="https://usaybia.net/bibl/WVSJMDSV"/>
                                    <citedRange unit="p"><xsl:value-of select="Index_Page"/> (index)</citedRange>
                                    <xsl:for-each select="tokenize(Refs,';\s*')">
                                        <citedRange unit="entry"><xsl:value-of select="."/></citedRange>
                                    </xsl:for-each>
                                </bibl>
                            </place>
                        </listPlace>
                    </body>
                </text>
            </TEI>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>