# This script was automatically generated from the dsa-1001
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(22543);
 script_version("$Revision: 1.6 $");
 script_xref(name: "DSA", value: "1001");
 script_cve_id("CVE-2006-1010");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1001 security update');
 script_set_attribute(attribute: 'description', value:
'It was discovered that Crossfire, a multiplayer adventure game, performs
insufficient bounds checking on network packets when run in "oldsocketmode",
which may possibly lead to the execution of arbitrary code.
For the old stable distribution (woody) this problem has been fixed in
version 1.1.0-1woody1.
For the stable distribution (sarge) this problem has been fixed in
version 1.6.0.dfsg.1-4sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2006/dsa-1001');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your crossfire packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1001] DSA-1001-1 crossfire");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1001-1 crossfire");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'crossfire-doc', release: '3.0', reference: '1.1.0-1woody1');
deb_check(prefix: 'crossfire-edit', release: '3.0', reference: '1.1.0-1woody1');
deb_check(prefix: 'crossfire-server', release: '3.0', reference: '1.1.0-1woody1');
deb_check(prefix: 'crossfire-doc', release: '3.1', reference: '1.6.0.dfsg.1-4sarge1');
deb_check(prefix: 'crossfire-edit', release: '3.1', reference: '1.6.0.dfsg.1-4sarge1');
deb_check(prefix: 'crossfire-server', release: '3.1', reference: '1.6.0.dfsg.1-4sarge1');
deb_check(prefix: 'crossfire', release: '3.1', reference: '1.6.0.dfsg.1-4sarge1');
deb_check(prefix: 'crossfire', release: '3.0', reference: '1.1.0-1woody1');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
