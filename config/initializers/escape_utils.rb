require 'escape_utils/html/erb'
require 'escape_utils/url/erb'
require 'escape_utils/url/uri'
require 'escape_utils/javascript/action_view'

# CGI & Rack are not patched because of + character parsing bug
# @see https://github.com/brianmario/escape_utils/pull/46

# Disable / characters escaping with &#47;
EscapeUtils.html_secure = false
