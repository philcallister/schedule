class AmenityCell < UITableViewCell

  extend IB

  # outlet
  outlet :description, UILabel

  def populate(description)
    self.description.text = description
  end

end