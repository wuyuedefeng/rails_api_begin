module UserForm
  class Create < Reform::Form
    model :user

    property :email
    property :password

    validates :email, :password, presence: true
  end
end