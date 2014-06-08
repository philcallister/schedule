module CellSelectable

  def selectColor(labels)
    bgColorView = UIView.alloc.init
    bgColorView.backgroundColor = UIColor.colorWithRed(236.0/255.0, green:96.0/255.0, blue:77.0/255.0, alpha:1.0)
    self.selectedBackgroundView = bgColorView
    labels.each { |l| l.highlightedTextColor = UIColor.whiteColor }
  end

end