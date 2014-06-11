class AmenityGroupCell < UITableViewCell

  extend IB

  # outlet
  outlet :name, UILabel

  def populate(name)
    self.name.text = name
  end

end