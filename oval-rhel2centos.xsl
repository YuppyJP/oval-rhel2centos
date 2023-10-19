<?xml version='1.0' encoding='UTF-8'?><!-- -*- indent-tabs-mode: nil -*- -->
<!--

oval-rhel2centos.xsl : Use RHEL oval definitions for CentOS (7 and 8)


Requirements:
 libxslt (for xsltproc command, required for converting)

 wget or curl (for downloading RHEL oval definitions)
 bzip2 (for decompress BZ2)
 openscap-utils (for oscap processing)


Usage:
1. Download RHEL oval definitions
 $ wget https://access.redhat.com/security/data/oval/v2/RHEL7/rhel-7.oval.xml.bz2
   or
 $ wget https://access.redhat.com/security/data/oval/v2/RHEL8/rhel-8.oval.xml.bz2

2. Decompress
 $ bunzip *.oval.xml.bz2

3. Process XML with xsltproc
 $ xsltproc oval-rhel2centos.xsl rhel-7.oval.xml > centos-7.xml
   or
 $ xsltproc oval-rhel2centos.xsl rhel-8.oval.xml > centos-8.xml

4. Enjoy with OpenSCAP
 $ oscap oval eval centos-7.xml
   or
 $ oscap oval eval centos-8.xml

Note:
 - This stylesheet only rewrites keyids and package file name checks (does not for target OS names).
   The result is displayed as if it were running on RHEL. 
 - '&quot;' in source RHEL oval definitions will be converted to '"'. (This may cause another problems...)

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://oval.mitre.org/XMLSchema/oval-definitions-5"
                xmlns:oval="http://oval.mitre.org/XMLSchema/oval-common-5"
                xmlns:unix-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#unix"
                xmlns:red-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#linux"
                xmlns:ind-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#independent"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="http://oval.mitre.org/XMLSchema/oval-common-5 oval-common-schema.xsd http://oval.mitre.org/XMLSchema/oval-definitions-5 oval-definitions-schema.xsd http://oval.mitre.org/XMLSchema/oval-definitions-5#unix unix-definitions-schema.xsd http://oval.mitre.org/XMLSchema/oval-definitions-5#linux linux-definitions-schema.xsd"
                version="1.0">
<xsl:output method="xml" indent="yes" encoding="UTF-8" version="1.0" />


<!-- preserve &gt; &lt; %amp; in text node. but &quot; cannot be preserved... -->
<xsl:template match="text()">
<xsl:value-of select="." disable-output-escaping="no" />
</xsl:template>

<!-- copy original nodes and attributes -->
<xsl:template match="@*|node()">
<xsl:copy>
<xsl:apply-templates select="@*|node()"/>
</xsl:copy>
</xsl:template>

<xsl:template match="oval-definitions">
<xsl:apply-templates/>
</xsl:template>

<!-- replacement -->
<!-- rhel7 signature keyid -->
<xsl:template match="red-def:rpminfo_state[@id='oval:com.redhat.rhba:ste:20150364002']/red-def:signature_keyid/text()">24c6a8a7f4a80eb5</xsl:template>
<!-- rhel7 redhat-release -->
<xsl:template match="red-def:rpmverifyfile_state[@id='oval:com.redhat.rhba:ste:20150364007']/red-def:name/text()">^centos-release</xsl:template>
<xsl:template match="red-def:rpmverifyfile_state[@id='oval:com.redhat.rhba:ste:20150364007']/red-def:version/text()">^7[^\d]?</xsl:template>
<xsl:template match="red-def:rpmverifyfile_state[@id='oval:com.redhat.rhba:ste:20150364008']/red-def:name/text()">^centos-release</xsl:template>


<!-- rhel8 signature keyid -->
<xsl:template match="red-def:rpminfo_state[@id='oval:com.redhat.rhba:ste:20191992002']/red-def:signature_keyid/text()">05b555b38483c65d</xsl:template>
<!-- rhel8 redhat-release -->
<xsl:template match="red-def:rpmverifyfile_state[@id='oval:com.redhat.rhba:ste:20191992003']/red-def:name/text()">^centos-(?:linux|stream)?-release</xsl:template>
<xsl:template match="red-def:rpmverifyfile_state[@id='oval:com.redhat.rhba:ste:20191992003']/red-def:version/text()">^8[^\d]?</xsl:template>
<xsl:template match="red-def:rpmverifyfile_state[@id='oval:com.redhat.rhba:ste:20191992005']/red-def:name/text()">^centos-(?:linux|stream)?-release</xsl:template>

</xsl:stylesheet>
