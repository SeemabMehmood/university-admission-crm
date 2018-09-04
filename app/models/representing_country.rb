class RepresentingCountry < ApplicationRecord
  enum status: [:active, :inactive]

  belongs_to :agent

  validates :name, :agent_id, presence: true

  filterrific(
     default_filter_params: { sorted_by: 'created_at_desc' },
     available_filters: [
       :sorted_by,
       :with_name
     ]
   )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("representing_countries.created_at #{ direction }")
    when /^name_/
      order("LOWER(representing_countries.name) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_name, lambda { |country_name|
    where(name: country_name)
  }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc']
    ]
  end
end
