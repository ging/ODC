require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Idm < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "idm"

      unless ODC::Application.config.APP_CONFIG["IDM"].blank?
        # This is where you pass the options you would pass when
        # initializing your consumer from the OAuth gem.
        option :client_options, {
          :site => ODC::Application.config.APP_CONFIG["IDM"]["site"],
          :authorize_url => ODC::Application.config.APP_CONFIG["IDM"]["authorize_path"],
          :token_url     => ODC::Application.config.APP_CONFIG["IDM"]["token_url"]
        }
      end

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.

      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get(ODC::Application.config.APP_CONFIG["IDM"]["user_url"]).parsed
      end

      def callback_url
         full_host + callback_path
      end
    end
  end
end
