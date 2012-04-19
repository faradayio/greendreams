## 1) hack to disable ssl cerb verify
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

## 2) set up a client
require 'oauth2'
client = OAuth2::Client.new(
  '58929ca82b8755cb869cba192c7f333a',     # client_id
  '52f1d9a82e543d440a1072d188f277e7',     # client_secret
  :site => 'https://dev.tendrilinc.com',  # not sure why this throws an ssl error without (1) above
  :token_method => :get,                  # non-standard
  :token_url => "/oauth/access_token"     # non-standard
)

## 3) get an authorization code
## this outputs a url that you need to go to in your browser
## sign in as "andrew.wood@tendril.com" with password "password"
# puts client.auth_code.authorize_url(:redirect_uri => 'http://127.0.0.1', :response_type => 'code', :scope => 'account billing consumption offline_access')
# exit

## 4) use the authorization code you got from that manual process to get an access token
## when it expires, repeat (3) above
authorization_code = 'b3bc6490e8a42ff609f27548817c64cd' # sabshere 2012-04-19 6pm Central
access_token = client.auth_code.get_token(authorization_code, :redirect_uri => 'http://127.0.0.1') # [A]

## 5) now you can, for example, get meter readings
## http://dev.tendrilinc.com/docs/meter_readings
meter_readings = access_token.get(
  '/connect/meter/read;external-account-id=aid_aw;from=2011-07-01T00:00:00-0000;to=2011-12-31T00:00:00-0000;limit-to-latest=20;source=ACTUAL',
  :headers => {
    'Accept' => 'application/json',        # required
    'Content-Type' => 'application/json',  # required
    'Access_Token' => access_token.token   # required, which i don't think is standard (i think it's redundant?)
}) # [B]
puts meter_readings.body

# Sample output
# {"MeterReading":[{"CustomerAgreement":{"mRID":"aid_aw"},"MeterAsset":{"mRID":"rid_aw-aid_aw"},"Readings":[{"timeStamp":"2011-12-30T19:15:00.000+00:00","value":49839.598,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T19:30:00.000+00:00","value":49840.527,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T19:45:00.000+00:00","value":49841.465,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T20:00:00.000+00:00","value":49842.344,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T20:15:00.000+00:00","value":49843.227,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T20:30:00.000+00:00","value":49844.125,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T20:45:00.000+00:00","value":49845.02,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T21:00:00.000+00:00","value":49845.895,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T21:15:00.000+00:00","value":49846.766,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T21:30:00.000+00:00","value":49847.527,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T21:45:00.000+00:00","value":49848.28,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T22:00:00.000+00:00","value":49849.22,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T22:15:00.000+00:00","value":49849.316,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T22:30:00.000+00:00","value":49849.41,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T22:45:00.000+00:00","value":49849.523,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T23:00:00.000+00:00","value":49849.625,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T23:15:00.000+00:00","value":49849.746,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T23:30:00.000+00:00","value":49849.85,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-30T23:45:00.000+00:00","value":49849.945,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}},{"timeStamp":"2011-12-31T00:00:00.000+00:00","value":49850.06,"ReadingQualities":[{"quality":"1.4.0.0"}],"ReadingType":{"@ref":"2.1.1.1.0.4.0.0.224.3.72"}}]}],"ReadingType":[{"mRID":"2.1.1.1.0.4.0.0.224.3.72","aliasName":"Raw","channelNumber":0,"defaultQuality":"0.0.0","intervalLength":900.0,"kind":"current","multiplier":"k","name":"Cumulative","unit":"Wh"}]}

# HTTP requests being made behind the scenes
# [A] GET https://dev.tendrilinc.com/oauth/access_token?grant_type=authorization_code&code=b3bc6490e8a42ff609f27548817c64cd&client_id=58929ca82b8755cb869cba192c7f333a&client_secret=52f1d9a82e543d440a1072d188f277e7&redirect_uri=http%3A%2F%2F127.0.0.1
# [B] GET https://dev.tendrilinc.com/connect/meter/read;external-account-id=aid_aw;from=2011-07-01T00:00:00-0000;to=2011-12-31T00:00:00-0000;limit-to-latest=20;source=ACTUAL
#     with headers {"Accept"=>"application/json", "Content-Type"=>"application/json", "Access_Token"=>"6ba114f0ae143fb7e9210cd897643a0d", "Authorization"=>"Bearer 6ba114f0ae143fb7e9210cd897643a0d"}
