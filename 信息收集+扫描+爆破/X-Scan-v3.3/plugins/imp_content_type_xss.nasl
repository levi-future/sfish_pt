#
# This script was written by George A. Theall, <theall@tifaware.com>.
#
# See the Nessus Scripts License for details.
#

# Changes by Tenable:
# - Revised plugin title (4/30/09)


include("compat.inc");

if (description) {
  script_id(12263);
  script_version ("$Revision: 1.16 $");

  script_cve_id("CVE-2004-0584");
  script_bugtraq_id(10501);
  script_xref(name:"GLSA", value:"GLSA-200406-11");
  script_xref(name:"OSVDB", value:"55372");
 
  script_name(english:"IMP Content-Type Header XSS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server is hosting a PHP application that is affected by
a cross-site scripting vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote server is running at least one instance of IMP whose 
version number is between 2.0 and 3.2.3 inclusive.  Such versions are
vulnerable to a cross-scripting attack whereby an attacker may be 
able to cause a victim to unknowingly run arbitrary JavaScript code 
simply by reading a MIME message with a specially crafted Content-Type
header. 

Note : Nessus has determined the vulnerability exists on the target
simply by looking at the version number of IMP installed there; it has
not attempted to actually exploit the vulnerability." );
 script_set_attribute(attribute:"see_also", value:"http://www.rs-labs.com/adv/RS-Labs-Advisory-2004-2.txt" );
 script_set_attribute(attribute:"see_also", value:"http://www.rs-labs.com/adv/RS-Labs-Advisory-2004-1.txt" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to IMP version 3.2.4 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );
script_end_attributes();

 
  summary["english"] = "Checks for Content-Type XSS Vulnerability in IMP";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2004-2009 George A. Theall");

  family["english"] = "CGI abuses : XSS";
  script_family(english:family["english"]);

  script_dependencie("global_settings.nasl", "imp_detect.nasl");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("http_func.inc");

host = get_host_name();
port = get_http_port(default:80);
if (debug_level) display("debug: searching for Content-Type XSS vulnerability in IMP on ", host, ":", port, ".\n");

if (!get_port_state(port)) exit(0);

# Check each installed instance, stopping if we find a vulnerability.
installs = get_kb_list(string("www/", port, "/imp"));
if (isnull(installs)) exit(0);
foreach install (installs) {
  matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
  if (!isnull(matches)) {
    ver = matches[1];
    dir = matches[2];
    if (debug_level) display("debug: checking version ", ver, " under ", dir, ".\n");

    if (ereg(pattern:"^(2\.|3\.(0|1|2|2\.[1-3]))$", string:ver)) {
      security_warning(port);
      set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
      exit(0);
    }
  }
}
