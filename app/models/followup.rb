class Followup < ApplicationRecord
  has_one :applicant, inverse_of: :application, dependent: :destroy
  belongs_to :agent, foreign_key: :agent_id

end
