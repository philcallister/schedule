class ScheduleCell < UITableViewCell

  include CellSelectable

  extend IB

  attr_accessor :top_view

  # outlet
  outlet :day, UILabel
  outlet :start_time, UILabel
  outlet :end_time, UILabel
  outlet :price, UILabel
  outlet :class_name, UILabel
  outlet :instructor, UILabel

  def populate(item, top_view)
    self.top_view = WeakRef.new(top_view)
    self.day.text = item[:day]
    self.start_time.text = "#{item[:start_time]}:00 AM"
    self.end_time.text = "#{item[:end_time]}:00 AM"
    self.price.text = item[:price]
    self.class_name.text = item[:class_name]
    self.instructor.text = item[:instructor]
    self.selectColor([self.day, self.start_time, self.end_time, self.price, self.class_name, self.instructor])
  end


  ############################################################################
  # Actions

  def calendarAddPressed
    sheet = UIActionSheet.alloc.initWithTitle("Add To",
                                              delegate:self,
                                              cancelButtonTitle:"Cancel",
                                              destructiveButtonTitle:nil,
                                              otherButtonTitles:"Calendar", "Activities", nil)
    sheet.showInView(self.top_view)
  end

  def actionSheet(actionSheet, didDismissWithButtonIndex:buttonIndex)
    case buttonIndex
    when 0 # Calendar
      # EventKit to do add... 
    when 1 # Favorites
      # Add to Favorites
    end
  end

end