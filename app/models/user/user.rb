class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable, :trackable

  enum status: [:active, :inactive]

  filterrific(
     default_filter_params: { sorted_by: 'created_at_desc' },
     available_filters: [
       :sorted_by,
       :with_role,
       :with_country_name
     ]
   )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("users.created_at #{ direction }")
    when /^name_/
      order("LOWER(users.name) #{ direction }")
    when /^country_name_/
      order("LOWER(users.country) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_country_name, lambda { |country_name|
    where(country: country_name)
  }

  scope :with_role, lambda { |role_name|
    where(type: role_name)
  }

  after_initialize :setup_password

  validates :name, :country, presence: true
  validates :contact_person_name, :contact_person_email,
            :contact_person_mobile, :contact_person_designation, presence: true, unless: Proc.new { |u| u.admin? }

  ROLES = ["admin", "agent", "branch_officer", "counsellor"]

  def street_address
    [street, city].join(', ') if street && city
  end

  def state_address
    return country unless state && zipcode
    [[zipcode, state].join(' - '), country].join(' | ')
  end

  def role
    type.present? ? type : "admin"
  end

  def admin?
    type.nil? || type.empty?
  end

  def agent?
    type == 'Agent'
  end

  def branch_officer?
    type == 'BranchOfficer'
  end

  def counsellor?
    type == 'Counsellor'
  end

  def build_user
    return BranchOfficer.new if self.agent?
    return Counsellor.new    if self.branch_officer?
  end

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Country (a-z)', 'country_name_asc']
    ]
  end

  private

  def setup_password
    return if self.persisted?
    self.password = self.password_confirmation = Devise.friendly_token.first(8)
  end
end
