# frozen_string_literal: true

module ApiMain
  module Auth
    class V1 < BaseApi
      helpers do
        params :credentials do
          requires :email, type: String, regexp: Constants::Regexps::EMAIL
          requires :password, type: String
        end
      end

      resources :auth do
        desc 'Create new user and login'
        params do
          use :credentials
        end
        post :sign_up do
          user = User.new(declared_params)

          if user.save
            present(:token, user.auth_token)
          else
            invalid_credentials!(user.errors.messages)
          end
        end

        desc 'Authenticate user'
        params do
          use :credentials
        end
        post :sign_in do
          params = declared_params
          user = User.authenticate(params[:email], params[:password])

          if user.present?
            present(:token, user.auth_token)
          else
            invalid_credentials!
          end
        end
      end
    end
  end
end