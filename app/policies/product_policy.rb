class ProductPolicy < ApplicationPolicy

  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end

  def update?
    user.admin? || product.user_uuid == user.uuid
  end
  def edit?
    user.admin? || product.user_uuid == user.uuid
  end
  def destory?
    user.admin? || product.user_uuid == user.uuid
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end
end
