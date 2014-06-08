class ClubCell < UITableViewCell

  include CellSelectable

  extend IB

  # outlet
  outlet :info, UILabel
  outlet :description, UILabel

  def populate(info, description)
    self.info.text = info
    self.description.text = description
    self.selectColor([self.info, self.description])
  end

end