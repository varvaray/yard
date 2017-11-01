class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    ap 'initialize in application policy'
    raise Pundit::NotAuthorizedError unless user
    @user = user
    @record = record
    ap 'record = '
    ap record
  end

  def index?
    false
  end

  def show?
    ap 'show in application policy'
    ap 'record = '
    ap record
    ap scope
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
