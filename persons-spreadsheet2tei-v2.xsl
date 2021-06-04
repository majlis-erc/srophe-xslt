<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:srophe="https://srophe.app" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- FILE OUTPUT PROCESSING -->
    <!-- specifies how the output file will look -->
    <xsl:output encoding="UTF-8" indent="yes" method="xml" name="xml"/>
    
    <!-- COLUMN NAME FORMATTING --> 
    <!-- string appended to columns containing element names -->
    <xsl:variable name="element-suffix" select="'_element_'"/>
    <!-- string appended to columns containing attribute values, followed by attribute name. 
    Colons (for namespaces) should be indicated by a double hyphen -->
    <xsl:variable name="attribute-suffix" select="'_att_'"/>
    
    <!-- DIRECTORY -->
    <!-- specifies where the output TEI files should go -->
    <!-- !!! Change this to where you want the output files to be placed relative to the XML file being converted. 
        This should end with a trailing slash (/).-->
    <xsl:variable name="directory">../tei/</xsl:variable>
    
    <!-- !!! If true will put records lacking a URI into an "unresolved" folder and assign them a random ID. -->
    <xsl:variable name="process-unresolved" select="false()"/>
    
    <!--<xsl:function name="srophe:is-content-column" as="xs:boolean">
        <xsl:param name="column" as="node()"/>
        <xsl:value-of select="not($column/name()='New_URI' or matches($column/name(),$element-suffix) or matches($column/name(),$attribute-suffix))"/>
    </xsl:function>-->
    
    <xsl:function name="srophe:create-element">
        <xsl:param name="content-column" as="node()*"/>
        <xsl:for-each select="$content-column[normalize-space(.)!='']">
            <xsl:variable name="column-name" select="replace(name(),concat($element-suffix,'.*$'),'')"/>
            <xsl:variable name="element" select="replace(name(),concat($column-name,$element-suffix),'')"/>
            <xsl:variable name="attributes" select="following-sibling::*[matches(name(),concat('^',$column-name,$attribute-suffix)) and normalize-space(.)!='']"/>
            <xsl:variable name="children" select="following-sibling::*[matches(name(),$element-suffix) and matches(name(),concat('^child_',$column-name))]"/>
            <xsl:element name="{$element}">
                <xsl:for-each select="$attributes">
                    <xsl:attribute name="{replace(replace(name(),concat('.*',$attribute-suffix),''),'--',':')}" select="."/>
                </xsl:for-each>
                <xsl:copy-of select="if ($children) then srophe:create-element($children) else ()"/>
                <!-- Underscore (_) is used to trigger creating the element if it has no content.
                    Does this need to be a recursive function? -->
                <xsl:copy-of select="node()/replace(.,'^_$','')"/>
            </xsl:element>
        </xsl:for-each>        
    </xsl:function>
    
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
                   
                    <xsl:variable name="content-cells" select="./*[matches(name(),$element-suffix) and not(matches(name(),'^child'))]"/>    
                    
                    <xsl:copy-of select="srophe:create-element($content-cells)"/>
                    
                </xsl:result-document>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>