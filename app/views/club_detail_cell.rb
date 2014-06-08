class ClubDetailCell < UITableViewCell

  include CellSelectable

  extend IB

  # outlet
  outlet :info, UILabel

  def populate(info)
    self.info.text = info
    selectColor([self.info])
  end

end