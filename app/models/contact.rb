class Contact < ApplicationRecord

  def friendly_updated_at
    updated_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def full_name
   "#{first_name} #{last_name}"
  end

  def japan_country_code
    "+81 #{phone_number}"
  end
end
