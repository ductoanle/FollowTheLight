Factory.define :user do |user|
  user.name   "Ethan.Le"
  user.email  "ethan.le@ufinity.com"
  user.password "ethanle"
  user.password_confirmation "ethanle"
end

Factory.define :image do |image|
  image.name "sunset_at_Singapore_river"
  image.url  "images/landscape/sunset_2.jpg"
  image.format "JPG"
end