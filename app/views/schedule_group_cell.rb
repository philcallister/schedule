class ScheduleGroupCell < UITableViewCell

  extend IB

  # outlet
  outlet :group, UILabel

  def populate(group)
    self.group.text = group
  end

end