class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation

  validates_presence_of :email, message: "Email can't be blank"
  validates_format_of :email, message: "Email format is invalid",
                      with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/,
                      if: proc { |user| !user.email.blank? }
  validates :email, uniqueness: true

  validates_presence_of :password, message: "Password can't be blank",
                        if: :need_validate_password
  validates_presence_of :password_confirmation, message: "Password_Confirmation can't be blank",
                        if: :need_validate_password
  validates_confirmation_of :password, message: "Password and Password_Confirmation do not match",
                            if: :need_validate_password
  validates_length_of :password, message: "Password must be at least 6 characters long", minimum: 6,
                      if: :need_validate_password

  def get_name_from_email
    self.email.split('@').first
  end

  has_many :addresses, -> {
    where(address_type: Address::AddressType::User).
      order("id desc")
  }

  has_many :orders # 订单

  belongs_to :default_address, class_name: :Address

  private

  # 触发校验
  def need_validate_password
    # 新建用户 或者 密码没有改变
    self.new_record? || (!self.password.nil? || !self.password_confirmation.nil?)
  end
end
