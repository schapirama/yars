require 'rss/2.0'
require 'assert_valid_markup'

class Test::Unit::TestCase
  # Is the current response returning XML?
  def xml_response?
    @response.headers['Content-Type'] == 'application/xml'
  end

  # Is the current response returning KML (Keyhole Markup)?
  def kml_response?
    @response.headers['Content-Type'] == 'application/vnd.google-earth.kml+xml'
  end

  # Is the current response returning JSON data?
  def json_response?
    ['application/json','text/x-json'].include?(@response.headers['Content-Type'])
  end

  # Is the current response a JavaScript document?
  def javascript_response?
    return ['text/javascript; charset=UTF-8', 
            'text/javascript'].include?(@response.headers['Content-Type'])
  end

  # Check that a generated RSS document can be parsed by the Ruby RSS
  # parser. If the document cannot be processed, an assertion is
  # raised.
  def assert_rss_valid
    assert_not_nil @response.body
    # Do validation and ignore unknown elements.
    # We need to ignore unknown elements because the built-in Ruby RSS
    # support doesn't understand the Geocoder module.
    RSS::Parser.parse(@response.body, true, true)
    # Make sure all the objects have been processed.
    assert_no_match /cannot be processed/, @response.body
  end

  # Using the assert_valid_markup plugin, check that the current
  # response is valid HTML. If the document cannot be processed, an
  # assertion is raised. In addition, the document and its headers are
  # printed to stdout. A detailed list of validation errors will be
  # reported in the test summary.
  def assert_html_valid
    #begin
      assert_valid_markup
    #rescue
    #  print "\nVALIDATION FAILED:\n"
    #  print "HEADERS:\n"
    #  @response.headers.each { |header,value|
    #    print "\t#{header}: #{value}\n"
    #  }
    #  print "BODY:\n"
    #  print @response.body
    #  print "\n"
    #  raise # re-raise after showing the failing body.
    #end
  end

  # Call out to the various validators.
  def check_markup
    return if ! ENV['NO_VALIDATION'].nil?
    
    if @response.redirect?
      # redirects don't validate; they're really dumbed-down HTML fragments.
    elsif javascript_response? || json_response?
      # No JS/JSON validation.
    elsif kml_response?
      # We don't validate KML yet.
    elsif xml_response?
      # Eventually, differentiate between RSS and other XML doc types.
      assert_rss_valid
      # print "+"
    else
      # HTML response. Validate.
      assert_html_valid
      # print "+"
    end
  end

  # Rewrite 'get' and 'post' to confirm that the requests result in
  # valid markup.
  alias :non_validating_get :get
  alias :non_validating_post :post 

  def get(path, parameters=nil, headers={}, flash=nil)
    non_validating_get path, parameters, headers, flash
    check_markup
  end

  def post(path,parameters=nil,headers={}, flash=nil)
    non_validating_post path, parameters, headers, flash
    check_markup
  end
end
