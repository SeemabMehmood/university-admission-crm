class PasswordsController < Devise::PasswordsController
  def update
    super do |resource|
      if resource.errors.any?
        flash[:notice] = resource.errors.full_messages.map { |msg| msg == 'Reset password token is invalid' ? 'The Reset Password Token is expired. Please send instructions again.' : msg }.to_sentence
      end
    end
  end
end
