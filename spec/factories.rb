# By using the symbol :user we get Factory Gild to simulate the User model

Factory.define :user do | user |
  user.name     "Barbara Kleinen"
  user.email    "kleinen@infrastructure.de"
  user.password "foobar"
  user.password_confirmation "foobar"
end