module CellSelectable

  def selectColor(labels)
    bgColorView = UIView.alloc.init
    bgColorView.backgroundColor = UIColor.colorWithRed(180.0/255.0, green:22.0/255.0, blue:34.0/255.0, alpha:1.0)
    self.selectedBackgroundView = bgColorView
    labels.each { |l| l.highlightedTextColor = UIColor.whiteColor }
  end

end