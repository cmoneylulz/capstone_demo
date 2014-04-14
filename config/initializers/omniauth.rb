# SSL Certificates fail for Facebook authentication, so I turned them off [AC]
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# Configuration for omniauth user authentication
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'jpuBN5ntYLfZTioOaH6rxw', 'o8SqgjA4jdHzXntusbxgr4HUkS4v7RYwp6VR4HajC8'
	provider :facebook, '1425493441027250', '136a4f8eb366b153e4a15d3de6590268'
	provider :google_oauth2, '361921756982.apps.googleusercontent.com', '1ekILhEPDH2PaWRAF5D9mr5B'
end