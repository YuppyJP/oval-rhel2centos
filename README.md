# oval-rhel2centos
Use RHEL oval definitions for CentOS (7 and 8)


## Requirements
 libxslt (for xsltproc command, required for converting)

 wget or curl (for downloading RHEL oval definitions)
 bzip2 (for decompress BZ2)
 openscap-utils (for oscap processing)


## Usage
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

## Note
 - This stylesheet only rewrites keyids and package file name checks (does not for target OS names).
   The result is displayed as if it were running on RHEL.
 - '&quot;' in source RHEL oval definitions will be converted to '"'. (This may cause another problems...)

