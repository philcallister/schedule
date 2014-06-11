class HourHeadCell < UITableViewCell

  extend IB

  # outlet
  outlet :header, UILabel

  def populate(header)
    self.header.text = header
  end

end