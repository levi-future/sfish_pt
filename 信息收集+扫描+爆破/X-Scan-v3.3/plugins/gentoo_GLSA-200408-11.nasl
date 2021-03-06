# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200408-11.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(14567);
 script_version("$Revision: 1.6 $");
 script_xref(name: "GLSA", value: "200408-11");
 script_cve_id("CVE-2004-1445");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200408-11 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200408-11
(Nessus: "adduser" race condition vulnerability)


    A race condition can occur in "nessus-adduser" if the user has not
    configured their TMPDIR variable.
  
Impact

    A malicious user could exploit this bug to escalate privileges to the
    rights of the user running "nessus-adduser".
  
Workaround

    There is no known workaround at this time. All users are encouraged to
    upgrade to the latest available version of Nessus.
  
');
script_set_attribute(attribute:'solution', value: '
    All Nessus users should upgrade to the latest version:
    # emerge sync
    # emerge -pv ">=net-analyzer/nessus-2.0.12"
    # emerge ">=net-analyzer/nessus-2.0.12"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:H/Au:N/C:P/I:P/A:P');
script_set_attribute(attribute: 'see_also', value: 'http://secunia.com/advisories/12127/');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-1445');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200408-11.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200408-11] Nessus: "adduser" race condition vulnerability');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'Nessus: "adduser" race condition vulnerability');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "net-analyzer/nessus", unaffected: make_list("ge 2.0.12"), vulnerable: make_list("le 2.0.11")
)) { security_note(0); exit(0); }
exit(0, "Host is not affected");
