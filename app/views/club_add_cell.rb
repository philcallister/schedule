class ClubAddCell < UITableViewCell

  include CellSelectable

  extend IB

  # outlet
  outlet :name, UILabel
  outlet :type_description, UILabel
  outlet :distance, UILabel

  def populate(name, type_description, distance)
    self.name.text = name
    self.type_description.text = type_description
    self.distance.text = distance
    self.selectColor([self.name, self.type_description, self.distance])
  end
  
end