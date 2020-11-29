class Employer < ApplicationRecord
  has_secure_password
  has_many :pars
  validates :username , length: {minimum: 4}
  validates :email , presence: true , uniqueness: true
  validates :role , presence: true

  def auth_by_email
    user=Employer.find_by(email: self.email.downcase)
        .try(:authenticate , self.password)
  end

  def auth_by_token(token)
    begin
      secret_key='123456789'
      decoded_token = JWT.decode(token , secret_key)[0]
      return Employer.find_by(email: decoded_token['email'])
    rescue  JWT::DecodeError
      return nil
    end
  end

  def data
    exp=1.days.from_now.to_i
    secret_key='123456789'
    user_data= {email: self.email , role: self.role , exp: exp}
    token = JWT.encode(user_data , secret_key)
    return data={id: self.id, username: self.username , email: self.email , role: self.role , token: token}
  end

  def downcase_email
    email= self.email.downcase
    self.email= email
    return self
  end

end
