class ClubLinkCell < UITableViewCell

  include CellSelectable

  extend IB

  # outlet
  outlet :link, UILabel

  def populate(link)
    self.link.text = link
    self.selectColor([self.link])
  end

end