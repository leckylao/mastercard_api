require "mastercard_api"
require "test/unit"
require "rexml/document"
include REXML

=begin
connector = Connector.new('820oCPqU4KAUEAwy0I6_Xf1dkjAlfSrEbSfeIq961563e1f8!414d686c777974526d2f71367141505a68304673746b633d', 'C:\Users\JBK0718\dev\mastercard\keystore\sandbox\414d686c777974526d2f71367141505a68304673746b633d.p12', 'unreal')

response_body = connector.do_request('https://sandbox.api.mastercard.com/fraud/loststolen/v1/account-inquiry?Format=XML','PUT','<AccountInquiry><AccountNumber>5343434343434343</AccountNumber></AccountInquiry>')
puts(response_body)

puts('SIGNATURE BASE STRING:')
puts(connector.signature_base_string)
puts('SIGNED SIGNATURE BASE STRING:')
puts(connector.signed_signature_base_string)
puts('AUTH HEADER:')
puts(connector.auth_header)
=end

class ConnectorTest < Test::Unit::TestCase
   
  def setup
    @consumer_key = '820oCPqU4KAUEAwy0I6_Xf1dkjAlfSrEbSfeIq961563e1f8!414d686c777974526d2f71367141505a68304673746b633d'
    @private_key = OpenSSL::PKCS12.new(File.read("data/privateKey.p12"), "unreal").key
    @connector = Mastercard::Common::Connector.new @consumer_key, @private_key
    @oauth_params = @connector.oauth_parameters_factory
    
  end
  
  def test_constructor
    assert @connector != nil, "connector has been instantiated" 
  end
  
  def test_response
    response_body = @connector.do_request 'https://sandbox.api.mastercard.com/fraud/loststolen/v1/account-inquiry?Format=XML','PUT', "<AccountInquiry><AccountNumber>5343434343434343</AccountNumber></AccountInquiry>", @oauth_params
    response = REXML::Document.new response_body
    assert response_body != nil, "Response is not nil"
    assert response.elements.first.name == "Account", "Response is Account xml"
  end
  
  def test_multiple_query_params
     params = Mastercard::Common::OAuthParameters.new
     params.add_parameter("hello", "1")
     params.add_parameter("goodbye", "2")
     params.add_parameter("zed", "3")
     params.add_parameter("dead", "4")
     response_body = @connector.normalize_parameters("http://helloworld.com", params)
     assert response_body == "dead=4&goodbye=2&hello=1&zed=3"
  end
  
  def test_signature_base_string
     signature = @connector.generate_signature_base_string("https://www.example.com?Format=XML", "POST", @oauth_params)
     puts "\n#{signature}\n"
     assert signature.include? "POST"
     assert signature.include? "https%3A%2F%2Fwww.example.com&Format%3DXML"
     assert signature.include? "oauth_consumer_key%3D820oCPqU4KAUEAwy0I6_Xf1dkjAlfSrEbSfeIq961563e1f8%21414d686c777974526d2f71367141505a68304673746b633d"
  end
end