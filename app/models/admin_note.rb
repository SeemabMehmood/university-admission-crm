class AdminNote < ApplicationRecord
  belongs_to :application

  audited

  def by_user
    User.find(self.audits.last.user_id).name.titleize
  end
end
