secret_key_base =
  if Rails.env.production?
    ENV['SECRET_KEY_BASE']
  else
    'c678b071ea09307fe451cdef29b6abe3ac3e0581da58225f82a33f77d906b0dde0afb09433c40cb44f150cda90adc1f9ebd4b5fe6dbe90911f9051185bac8ffc'
  end

puts secret_key_base

if secret_key_base.blank?
  raise Exception.new("Missing SECRET_KEY_BASE environment variable")
end

Bikeability::Application.config.secret_key_base = secret_key_base


