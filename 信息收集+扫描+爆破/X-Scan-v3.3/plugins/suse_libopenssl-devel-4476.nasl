
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(27328);
 script_version ("$Revision: 1.5 $");
 script_name(english: "SuSE Security Update:  openssl: This update fixes a buffer overflow. (libopenssl-devel-4476)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch libopenssl-devel-4476");
 script_set_attribute(attribute: "description", value: "This update of openssl fixes a off-by-one buffer overflow
in function SSL_get_shared_ciphers(). This vulnerability
potentially allows remote code execution; depending on
memory layout of the process. (CVE-2007-5135)
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch libopenssl-devel-4476");
script_end_attributes();

script_cve_id("CVE-2007-5135");
script_summary(english: "Check for the libopenssl-devel-4476 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"libopenssl-devel-0.9.8e-45.2", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libopenssl0_9_8-0.9.8e-45.2", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libopenssl0_9_8-32bit-0.9.8e-45.2", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"libopenssl0_9_8-64bit-0.9.8e-45.2", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"openssl-0.9.8e-45.2", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"openssl-certs-0.9.8e-45.2", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"openssl-doc-0.9.8e-45.2", release:"SUSE10.3") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
