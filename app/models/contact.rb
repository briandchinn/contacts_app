class Contact < ApplicationRecord

  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups
  
  validates :first_name, :middle_name, :last_name, presence: true
  validates :email, uniqueness: true
  validates :phone_number, presence: true
  validates :bio, length: {in: 10..500}

  def friendly_updated_at
    updated_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def japan_country_code
    "+81 #{phone_number}"
  end

  def group_names
    groups.map { |group| group.name }
  end
end
