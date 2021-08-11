module ApplicationHelper

  def fetch_company
    if current_user.has_role?(:employee)
      @belong_to_company = User.find(current_user.invited_by_id).company.name.upcase
      @comp_id = User.find(current_user.invited_by_id).company.id
    elsif current_user.has_role?(:vendor)
      @belong_to_company = current_user.company.name.upcase
    end
    return [@belong_to_company, @comp_id]
  end

end
