class MenuGroupCell < UITableViewCell

  extend IB

  # outlet
  outlet :menu, UILabel

  def populate(menu)
    self.menu.text = menu
  end
  
end