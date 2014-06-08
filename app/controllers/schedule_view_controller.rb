class ScheduleViewController < UIViewController

  extend IB

  outlet :display_date, UILabel
  outlet :weekly, UIBarButtonItem
  outlet :daily, UIBarButtonItem

  def viewDidLoad
    super
    @daily_format = true
    @daily_classes ||= [ 
      { :day => 'Today', :start_time => 7, :end_time => 8, :price => 'Free', :class_name => 'TCX', :instructor => 'Angie C. @ Studio2' },
      { :day => 'Today', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Zumba', :instructor => 'Tonia R. @ Studio1' },
      { :day => 'Today', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Shockwave', :instructor => 'Tonia R. @ Studio2' },
      { :day => 'Today', :start_time => 9, :end_time => 10, :price => 'Free', :class_name => 'Core', :instructor => 'Jim A. @ Studio2' },
      { :day => 'Today', :start_time => 9, :end_time => 10, :price => '$35.00', :class_name => 'Alpha Training', :instructor => 'Adam R.' },
      { :day => 'Today', :start_time => 10, :end_time => 11, :price => '$174.99', :class_name => 'T.E.A.M Fitness', :instructor => 'Kirsten D.' },
      { :day => 'Today', :start_time => 10, :end_time => 11, :price => 'Free', :class_name => 'Studio Cycle', :instructor => 'Patricia @ Cycle' },
      { :day => 'Today', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Warrior Sculpt', :instructor => 'Nick B. @ Studio1' },
      { :day => 'Today', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'INSANITY', :instructor => 'Julie S. @ Studio2' },
      { :day => 'Today', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Aqua', :instructor => 'Sara J. @ Lap Pool' } ]

    today = Time.now
    self.display_date.text = today.strftime("%a, %b %d, %Y")
  end

  def viewWillAppear(animated)
    self.daily.setEnabled !@daily_format
    self.weekly.setEnabled @daily_format
    super
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    5
  end

  def tableView(tableView, heightForRowAtIndexPath:path)
    60
  end
  
  def tableView(tableView, heightForHeaderInSection:section)
    24
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    case section
    when 0
      return 1
    when 1
      return 2
    when 2
      return 2
    when 3
      return 2
    when 4
      return 3
    end
  end

  def tableView(tableView, viewForHeaderInSection:section)
    header = tableView.dequeueReusableCellWithIdentifier(ScheduleGroupCell.name)
    case section
    when 0
      header.populate('7:00 AM')
    when 1
      header.populate('8:00 AM')
    when 2
      header.populate('9:00 AM')
    when 3
      header.populate('10:00 AM')
    when 4
      header.populate('11:00 AM')
    end

    header
  end 
  
  def tableView(tableView, cellForRowAtIndexPath:path)
    cell = tableView.dequeueReusableCellWithIdentifier(ScheduleCell.name)
    case path.section
    when 0
      cell.populate(@daily_classes[0], self.view)
    when 1
      cell.populate(@daily_classes[path.row + 1], self.view)
    when 2
      cell.populate(@daily_classes[path.row + 3], self.view)
    when 3
      cell.populate(@daily_classes[path.row + 5], self.view)
    when 4
      cell.populate(@daily_classes[path.row + 7], self.view)
    end
    
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:path)
    #self.performSegueWithIdentifier("ActivitySegue", sender:self)
    tableView.deselectRowAtIndexPath(path, animated:true)
  end

  # We do this to avoid having separators after the last cell
  def tableView(tableView, heightForFooterInSection:section)
    return 0.01
  end


  ############################################################################
  # Actions

  def dailyPressed
    @daily_format = !@daily_format
    self.daily.setEnabled !@daily_format
    self.weekly.setEnabled @daily_format
    today = Time.now
    self.display_date.text = today.strftime("%a, %b %d, %Y")
  end

  def weeklyPressed
    @daily_format = !@daily_format
    self.daily.setEnabled !@daily_format
    self.weekly.setEnabled @daily_format
    today = Time.now
    next_week = today + (86400 * 7)
    self.display_date.text = "#{today.strftime('%a, %b %d, %Y')}  |  #{next_week.strftime('%a, %b %d, %Y')}" 
  end

  def backPressed
    puts "!!!!! Back Pressed..."
  end

  def forwardPressed
    puts "!!!!! Forward Pressed..."
  end

  def actionPressed
    sheet = UIActionSheet.alloc.initWithTitle("Sort By",
                                              delegate:self,
                                              cancelButtonTitle:"Cancel",
                                              destructiveButtonTitle:nil,
                                              otherButtonTitles:"Time", "Activity", "Instructor", nil)
    sheet.showInView(self.view)
  end

  def actionSheet(actionSheet, didDismissWithButtonIndex:buttonIndex)
    case buttonIndex
    when 0 # Time
      # Time...
    when 1 # Class
      # Class...
    when 2 # Instructor
      # Instructor
    end
  end

end