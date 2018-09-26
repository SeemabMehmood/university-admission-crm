class PasswordsController < Devise::PasswordsController
  def update
    super do |resource|
      if resource.errors.any?
        flash[:notice] = resource.errors.full_messages.to_sentence
      end
    end
  end
end
