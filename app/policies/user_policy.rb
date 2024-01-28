class UserPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @record = record
  end

  def index?
    current_user.admin?
  end

  def show?
    current_user.admin? || current_user == record
  end

  def update?
    current_user.admin?
  end

  def destroy?
    current_user != record && current_user.admin?
  end
end
