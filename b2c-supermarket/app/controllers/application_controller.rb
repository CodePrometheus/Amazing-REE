class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception # 防止 CSRF 攻击

  protected

  def fetch_category_grouped
    @categories = Category.grouped_data
  end
end
