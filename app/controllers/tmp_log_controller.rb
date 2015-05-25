class TmpLogController < ApplicationController

  require 'open-uri'


  def create
    uri = Addressable::URI.parse(request.url)
    uri.host = 'betaworks.stage.xolator.com'
    uri.port = nil
    uri.scheme = 'http'
    uri.path = '/t/podcast-ratings.php'
    uri.query += '&' + URI.encode_www_form(ip_address: request.ip, useragent: request.user_agent)
    open(uri)
  end

end