<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- FILE OUTPUT PROCESSING -->
    <!-- specifies how the output file will look -->
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="xml"/>
    
    <!-- ??? Not sure what this variable does. They're from Winona's saints XSL. -->
    <xsl:variable name="n">
        <xsl:text/>
    </xsl:variable>
    
    <!-- DIRECTORY -->
    <!-- specifies where the output TEI files should go -->
    <!-- !!! Change this to where you want the output files to be placed relative to the XML file being converted. 
        This should end with a trailing slash (/).-->
    <xsl:variable name="directory">../tei/</xsl:variable>
    
    <!-- !!! If true will put records lacking a URI into an "unresolved" folder and assign them a random ID. -->
    <xsl:variable name="process-unresolved" select="false()"/>
    
    <!-- MAIN TEMPLATE -->
    <!-- processes each row of the spreadsheet -->
    <xsl:template match="/root">
        <!-- creates ids for new persons. -->
        <!-- ??? How should we deal with matched persons, where the existing TEI records need to be supplemented? -->
        <xsl:for-each select="row[not(contains(.,'***'))]">
            <xsl:variable name="record-id">
                <!-- gets a record ID from the New_URI column, or generates one if that column is blank -->
                <xsl:choose>
                    <xsl:when test="New_URI != ''">
                        <xsl:value-of select="New_URI"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat('unresolved-',generate-id())"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <!-- creates the URI from the record ID -->
            <xsl:variable name="record-uri" select="concat('https://usaybia.net/person/',New_URI)"/>
            
            <xsl:variable 
                name="headword-column-names"
                select="for $name in ./*[matches(.,'#syriaca-headword')]/name() 
                return replace($name,'_Attribute','')"/>
            
            <!-- creates a variable containing the path of the file to be created for this record, in the location defined by $directory -->
            <xsl:variable name="filename">
                <xsl:choose>
                    <!-- tests whether there is sufficient data to create a complete record. If not, puts it in an 'incomplete' folder inside the $directory -->
                    <xsl:when test="empty(./*[name()=$headword-column-names]) and New_URI != ''">
                        <xsl:value-of select="concat($directory,'/incomplete/',$record-id,'.xml')"/>
                    </xsl:when>
                    <!-- if record is complete and has a URI, puts it in the $directory folder -->
                    <xsl:when test="New_URI != ''">
                        <xsl:value-of select="concat($directory,$record-id,'.xml')"/>
                    </xsl:when>
                    <!-- if record doesn't have a URI, puts it in 'unresolved' folder inside the $directory  -->
                    <xsl:otherwise>
                        <xsl:if test="$process-unresolved">
                            <xsl:value-of select="concat($directory,'unresolved/',$record-id,'.xml')"/>
                        </xsl:if>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <!-- creates the XML file, if the filename has been sucessfully created. -->
            <xsl:if test="$filename != ''">
                <xsl:result-document href="{$filename}" format="xml">
                    <!-- adds the xml-model instruction with the link to the Syriaca.org validator -->
                    <xsl:processing-instruction name="xml-model">
                    <xsl:text>href="http://syriaca.org/documentation/syriaca-tei-main.rnc" type="application/relax-ng-compact-syntax"</xsl:text>
                </xsl:processing-instruction>
                   
                    <xsl:variable name="element-cells" select="./*[matches(name(),'_element')]"/>
                    <xsl:variable name="attribute-cells" select="./*[matches(name(),'_att_')]"/>
                    <xsl:variable name="content-cells" select="./*[name()!='New_URI' and empty(index-of(($element-cells,$attribute-cells),.))]"/>    
                    
                    <xsl:for-each select="$content-cells[normalize-space(.)!='']">
                        <xsl:variable name="column-name" select="name()"/>
                        <xsl:variable name="element" select="following-sibling::*[name()=concat($column-name,'_Element')][1]"/>
                        <xsl:variable name="attributes" select="following-sibling::*[matches(name(),concat($column-name,'_att_'))]"/>
                        <xsl:element name="{$element}">
                            <xsl:for-each select="$attributes">
                                <xsl:attribute name="{replace(replace(name(),'.*_att_',''),'--',':')}" select="."/>
                                <!--<xsl:analyze-string select="." regex="(.*?)=&quot;(.*?)&quot;\s*">
                                    <xsl:matching-substring>
                                        <xsl:attribute name="{regex-group(1)}" select="regex-group(2)"/>
                                    </xsl:matching-substring>
                                </xsl:analyze-string>-->
                            </xsl:for-each>
                            <xsl:copy-of select="node()"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>