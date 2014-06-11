class ProgramCell < UITableViewCell

  include CellSelectable

  extend IB

  # outlet
  outlet :name, UILabel
  outlet :description, UILabel
  outlet :image, UIImageView

  def populate(item)
    self.name.text = item[:name]

    self.description.text = item[:description]
    self.description.numberOfLines = 0
    #self.description.sizeToFit

    image = UIImage.imageNamed(item[:image])
    self.image.setImage(image)

    self.selectColor([self.name, self.description])
  end

end