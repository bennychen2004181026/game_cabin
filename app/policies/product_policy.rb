class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end
  private
  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end

  def update?
    user.admin? || !product.published?
  end
  def edit?
    user.admin? || !product.published?
  end
  def destory?
    user.admin? || !product.published?
  end
end
