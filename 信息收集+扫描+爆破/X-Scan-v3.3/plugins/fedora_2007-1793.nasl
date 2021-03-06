
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2007-1793
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(27735);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 7 2007-1793: pam_ssh");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2007-1793 (pam_ssh)");
 script_set_attribute(attribute: "description", value: "This PAM module provides single sign-on behavior for UNIX using SSH keys.
Users are authenticated by decrypting their SSH private keys with the
password provided. In the first PAM login session phase, an ssh-agent
process is started and keys are added. The same agent is used for the
following PAM sessions. In any case the appropriate environment variables
are set in the session phase.

-
ChangeLog:


Update information :

* Thu Aug 23 2007 Patrice Dumas <pertusus free fr> 1.92-2
- update to 1.92
- Fix #253959, CVE-2007-0844
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:N");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2007-0844");
script_summary(english: "Check for the version of the pam_ssh package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"pam_ssh-1.92-2.fc7", release:"FC7") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
