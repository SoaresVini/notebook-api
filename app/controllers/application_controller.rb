class ApplicationController < ActionController::API

  #antes de qualquer coisa garanta que o reterno é em JSON
# before_action :ensure_json_request

# def ensure_json_request
#   return if request.headers["Accept"] =~ /json/
#   render :nothing => true, :status => 406
# end
end
