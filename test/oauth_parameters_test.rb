require "mastercard_api"
require "test/unit"
=begin
params = OAuthParameters.new('hello')
puts(params.consumer_key)
puts(params.nonce)
puts(params.timestamp)
puts(params.oauth_version)
puts(params.signature_method)

#hashed body
puts(params.generate_body_hash('foo'))
puts(params.generate_body_hash('bar'))
#blank line
puts(params.generate_body_hash(nil))
=end

class OAuthParametersTest < Test::Unit::TestCase
    def setup
       @consumer_key = '820oCPqU4KAUEAwy0I6_Xf1dkjAlfSrEbSfeIq961563e1f8!414d686c777974526d2f71367141505a68304673746b633d'
       @private_key = OpenSSL::PKCS12.new(File.read("data/privateKey.p12"), "unreal").key
       @connector = Mastercard::Common::Connector.new @consumer_key, @private_key
       @oauth_params = @connector.oauth_parameters_factory 
    end
    
    def test_constructor
       assert @oauth_params != nil
    end
    
    def test_params_hash
       params = @connector.oauth_parameters_factory.params
       assert params[:oauth_consumer_key] != nil
       assert params[:oauth_timestamp] != nil
       assert params[:oauth_nonce] != nil
       assert params[:oauth_signature_method] == "RSA-SHA1"
       assert params[:oauth_version] == "1.0"
       assert params[:oauth_body_hash] == nil
       assert params[:oauth_signature] == nil
    end
    
    def test_add_parameter
       @oauth_params.add_parameter("Hello", "World")
       assert @oauth_params.params[:Hello] == "World", "Test added param"
       assert @oauth_params.send("Hello") == "World", "Test added instance method"
    end
end