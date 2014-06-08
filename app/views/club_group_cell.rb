class ClubGroupCell < UITableViewCell

  extend IB

  # outlet
  outlet :club, UILabel
  outlet :location, UILabel

  def populate(club, location)
    self.club.text = club
    self.location.text = location
  end

end