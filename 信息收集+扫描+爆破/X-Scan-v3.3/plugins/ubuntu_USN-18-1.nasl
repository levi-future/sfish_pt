# This script was automatically generated from the 18-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(20590);
script_version("$Revision: 1.5 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "18-1");
script_summary(english:"zip vulnerability");
script_name(english:"USN18-1 : zip vulnerability");
script_set_attribute(attribute:'synopsis', value: 'The remote package "zip" is missing a security patch.');
script_set_attribute(attribute:'description', value: 'HexView discovered a buffer overflow in the zip package. The overflow
is triggered by creating a ZIP archive of files with very long path
names. This vulnerability might result in execution of arbitrary code
with the privileges of the user who calls zip.

This flaw may lead to privilege escalation on systems which
automatically create ZIP archives of user supplied files, like backup
systems or web applications.');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- zip-2.30-6ubuntu0.1 (Ubuntu 4.10)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

script_cve_id("CVE-2004-1010");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "4.10", pkgname: "zip", pkgver: "2.30-6ubuntu0.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package zip-',found,' is vulnerable in Ubuntu 4.10
Upgrade it to zip-2.30-6ubuntu0.1
');
}

if (w) { security_hole(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
