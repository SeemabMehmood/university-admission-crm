class ApplicationHistory < ApplicationRecord
  belongs_to :application

  validates :status, presence: true,
                      uniqueness: { scope: :application_id,
                                    message: "has already been assigned." }

  mount_uploader :document, DocUploader
  audited

  def by_user
    User.find(self.audits.last.user_id).name.titleize if self.audits.present?
  end
end
