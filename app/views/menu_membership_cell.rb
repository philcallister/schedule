class MenuMembershipCell < UITableViewCell

  include CellSelectable

  extend IB

  # outlet
  outlet :menu, UILabel

  def populate(menu)
    self.menu.text = menu
    self.selectColor([self.menu])
  end

  def layoutSubviews
    super
  end
  
end