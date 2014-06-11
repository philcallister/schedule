class HourCell < UITableViewCell

  extend IB

  # outlet
  outlet :name, UILabel
  outlet :hours, UILabel

  def populate(item)
    self.name.text = item[:name]
    self.hours.text = item[:hours]
  end

end