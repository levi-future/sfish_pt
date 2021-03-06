
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(41332);
 script_version("$Revision: 1.1 $");
 script_name(english: "SuSE9 Security Update:  Security update for openmotif (9399)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE9 system is missing the security patch 9399");
 script_set_attribute(attribute: "description", value: 'This update fixes following security problems in OpenMotif:
CVE-2004-0687
Several stack overflows in the libXPM image handling library
contained within OpenMotif were fixed.
CVE-2004-0688
Several integer overflow problems in the libXPM image
handling library contained within OpenMotif were fixed.
');
 script_set_attribute(attribute: "risk_factor", value: "High");
script_set_attribute(attribute: "solution", value: "Install the security patch 9399");
script_end_attributes();

script_summary(english: "Check for the security advisory #9399");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"openmotif21-libs-2.1.30MLI4-119.4", release:"SUSE9", cpu: "i586") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
