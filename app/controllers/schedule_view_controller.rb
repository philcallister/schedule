class ScheduleViewController < UIViewController

  extend IB

  outlet :display_date, UILabel
  outlet :weekly, UIBarButtonItem
  outlet :daily, UIBarButtonItem
  outlet :table_view, UITableView

  DAY = 86400

  def viewDidLoad
    super
    @daily_format = true
    @weekly_classes ||= [  
      { :day_seq => 1, :day => 'SUN', :start_time => 7, :end_time => 8, :price => 'Free', :class_name => 'TCX', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 1, :day => 'SUN', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Zumba', :instructor => 'Tonia R. @ Studio1' },
      { :day_seq => 1, :day => 'SUN', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Shockwave', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 1, :day => 'SUN', :start_time => 9, :end_time => 10, :price => 'Free', :class_name => 'Core', :instructor => 'Jim A. @ Studio2' },
      { :day_seq => 1, :day => 'SUN', :start_time => 9, :end_time => 10, :price => '$35.00', :class_name => 'Alpha Training', :instructor => 'Adam R.' },
      { :day_seq => 1, :day => 'SUN', :start_time => 10, :end_time => 11, :price => '$174.99', :class_name => 'T.E.A.M Fitness', :instructor => 'Kirsten D.' },
      { :day_seq => 1, :day => 'SUN', :start_time => 10, :end_time => 11, :price => 'Free', :class_name => 'Studio Cycle', :instructor => 'Patricia @ Cycle' },
      { :day_seq => 1, :day => 'SUN', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Warrior Sculpt', :instructor => 'Nick B. @ Studio1' },
      { :day_seq => 1, :day => 'SUN', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'INSANITY', :instructor => 'Julie S. @ Studio2' },
      { :day_seq => 1, :day => 'SUN', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Aqua', :instructor => 'Sara J. @ Lap Pool' },

      { :day_seq => 2, :day => 'MON', :start_time => 7, :end_time => 8, :price => 'Free', :class_name => 'TCX', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 2, :day => 'MON', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Zumba', :instructor => 'Tonia R. @ Studio1' },
      { :day_seq => 2, :day => 'MON', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Shockwave', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 2, :day => 'MON', :start_time => 9, :end_time => 10, :price => 'Free', :class_name => 'Core', :instructor => 'Jim A. @ Studio2' },
      { :day_seq => 2, :day => 'MON', :start_time => 9, :end_time => 10, :price => '$35.00', :class_name => 'Alpha Training', :instructor => 'Adam R.' },
      { :day_seq => 2, :day => 'MON', :start_time => 10, :end_time => 11, :price => '$174.99', :class_name => 'T.E.A.M Fitness', :instructor => 'Kirsten D.' },
      { :day_seq => 2, :day => 'MON', :start_time => 10, :end_time => 11, :price => 'Free', :class_name => 'Studio Cycle', :instructor => 'Patricia @ Cycle' },
      { :day_seq => 2, :day => 'MON', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Warrior Sculpt', :instructor => 'Nick B. @ Studio1' },
      { :day_seq => 2, :day => 'MON', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'INSANITY', :instructor => 'Julie S. @ Studio2' },
      { :day_seq => 2, :day => 'MON', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Aqua', :instructor => 'Sara J. @ Lap Pool' },

      { :day_seq => 3, :day => 'TUE', :start_time => 7, :end_time => 8, :price => 'Free', :class_name => 'TCX', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 3, :day => 'TUE', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Zumba', :instructor => 'Tonia R. @ Studio1' },
      { :day_seq => 3, :day => 'TUE', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Shockwave', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 3, :day => 'TUE', :start_time => 9, :end_time => 10, :price => 'Free', :class_name => 'Core', :instructor => 'Jim A. @ Studio2' },
      { :day_seq => 3, :day => 'TUE', :start_time => 9, :end_time => 10, :price => '$35.00', :class_name => 'Alpha Training', :instructor => 'Adam R.' },
      { :day_seq => 3, :day => 'TUE', :start_time => 10, :end_time => 11, :price => '$174.99', :class_name => 'T.E.A.M Fitness', :instructor => 'Kirsten D.' },
      { :day_seq => 3, :day => 'TUE', :start_time => 10, :end_time => 11, :price => 'Free', :class_name => 'Studio Cycle', :instructor => 'Patricia @ Cycle' },
      { :day_seq => 3, :day => 'TUE', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Warrior Sculpt', :instructor => 'Nick B. @ Studio1' },
      { :day_seq => 3, :day => 'TUE', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'INSANITY', :instructor => 'Julie S. @ Studio2' },
      { :day_seq => 3, :day => 'TUE', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Aqua', :instructor => 'Sara J. @ Lap Pool' },

      { :day_seq => 4, :day => 'WED', :start_time => 7, :end_time => 8, :price => 'Free', :class_name => 'TCX', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 4, :day => 'WED', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Zumba', :instructor => 'Tonia R. @ Studio1' },
      { :day_seq => 4, :day => 'WED', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Shockwave', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 4, :day => 'WED', :start_time => 9, :end_time => 10, :price => 'Free', :class_name => 'Core', :instructor => 'Jim A. @ Studio2' },
      { :day_seq => 4, :day => 'WED', :start_time => 9, :end_time => 10, :price => '$35.00', :class_name => 'Alpha Training', :instructor => 'Adam R.' },
      { :day_seq => 4, :day => 'WED', :start_time => 10, :end_time => 11, :price => '$174.99', :class_name => 'T.E.A.M Fitness', :instructor => 'Kirsten D.' },
      { :day_seq => 4, :day => 'WED', :start_time => 10, :end_time => 11, :price => 'Free', :class_name => 'Studio Cycle', :instructor => 'Patricia @ Cycle' },
      { :day_seq => 4, :day => 'WED', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Warrior Sculpt', :instructor => 'Nick B. @ Studio1' },
      { :day_seq => 4, :day => 'WED', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'INSANITY', :instructor => 'Julie S. @ Studio2' },
      { :day_seq => 4, :day => 'WED', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Aqua', :instructor => 'Sara J. @ Lap Pool' },

      { :day_seq => 5, :day => 'THU', :start_time => 7, :end_time => 8, :price => 'Free', :class_name => 'TCX', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 5, :day => 'THU', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Zumba', :instructor => 'Tonia R. @ Studio1' },
      { :day_seq => 5, :day => 'THU', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Shockwave', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 5, :day => 'THU', :start_time => 9, :end_time => 10, :price => 'Free', :class_name => 'Core', :instructor => 'Jim A. @ Studio2' },
      { :day_seq => 5, :day => 'THU', :start_time => 9, :end_time => 10, :price => '$35.00', :class_name => 'Alpha Training', :instructor => 'Adam R.' },
      { :day_seq => 5, :day => 'THU', :start_time => 10, :end_time => 11, :price => '$174.99', :class_name => 'T.E.A.M Fitness', :instructor => 'Kirsten D.' },
      { :day_seq => 5, :day => 'THU', :start_time => 10, :end_time => 11, :price => 'Free', :class_name => 'Studio Cycle', :instructor => 'Patricia @ Cycle' },
      { :day_seq => 5, :day => 'THU', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Warrior Sculpt', :instructor => 'Nick B. @ Studio1' },
      { :day_seq => 5, :day => 'THU', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'INSANITY', :instructor => 'Julie S. @ Studio2' },
      { :day_seq => 5, :day => 'THU', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Aqua', :instructor => 'Sara J. @ Lap Pool' },

      { :day_seq => 6, :day => 'FRI', :start_time => 7, :end_time => 8, :price => 'Free', :class_name => 'TCX', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 6, :day => 'FRI', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Zumba', :instructor => 'Tonia R. @ Studio1' },
      { :day_seq => 6, :day => 'FRI', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Shockwave', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 6, :day => 'FRI', :start_time => 9, :end_time => 10, :price => 'Free', :class_name => 'Core', :instructor => 'Jim A. @ Studio2' },
      { :day_seq => 6, :day => 'FRI', :start_time => 9, :end_time => 10, :price => '$35.00', :class_name => 'Alpha Training', :instructor => 'Adam R.' },
      { :day_seq => 6, :day => 'FRI', :start_time => 10, :end_time => 11, :price => '$174.99', :class_name => 'T.E.A.M Fitness', :instructor => 'Kirsten D.' },
      { :day_seq => 6, :day => 'FRI', :start_time => 10, :end_time => 11, :price => 'Free', :class_name => 'Studio Cycle', :instructor => 'Patricia @ Cycle' },
      { :day_seq => 6, :day => 'FRI', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Warrior Sculpt', :instructor => 'Nick B. @ Studio1' },
      { :day_seq => 6, :day => 'FRI', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'INSANITY', :instructor => 'Julie S. @ Studio2' },
      { :day_seq => 6, :day => 'FRI', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Aqua', :instructor => 'Sara J. @ Lap Pool' },

      { :day_seq => 7, :day => 'SAT', :start_time => 7, :end_time => 8, :price => 'Free', :class_name => 'TCX', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 7, :day => 'SAT', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Zumba', :instructor => 'Tonia R. @ Studio1' },
      { :day_seq => 7, :day => 'SAT', :start_time => 8, :end_time => 9, :price => 'Free', :class_name => 'Shockwave', :instructor => 'Angie C. @ Studio2' },
      { :day_seq => 7, :day => 'SAT', :start_time => 9, :end_time => 10, :price => 'Free', :class_name => 'Core', :instructor => 'Jim A. @ Studio2' },
      { :day_seq => 7, :day => 'SAT', :start_time => 9, :end_time => 10, :price => '$35.00', :class_name => 'Alpha Training', :instructor => 'Adam R.' },
      { :day_seq => 7, :day => 'SAT', :start_time => 10, :end_time => 11, :price => '$174.99', :class_name => 'T.E.A.M Fitness', :instructor => 'Kirsten D.' },
      { :day_seq => 7, :day => 'SAT', :start_time => 10, :end_time => 11, :price => 'Free', :class_name => 'Studio Cycle', :instructor => 'Patricia @ Cycle' },
      { :day_seq => 7, :day => 'SAT', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Warrior Sculpt', :instructor => 'Nick B. @ Studio1' },
      { :day_seq => 7, :day => 'SAT', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'INSANITY', :instructor => 'Julie S. @ Studio2' },
      { :day_seq => 7, :day => 'SAT', :start_time => 11, :end_time => 12, :price => 'Free', :class_name => 'Aqua', :instructor => 'Sara J. @ Lap Pool' }
    ]

    @today = Time.now
    @daily_classes = @weekly_classes.select { |wc| wc[:day] == @today.strftime('%a').upcase }
    sort_classes(:start_time, :start_time) { |c| [c[:day_seq], c[:start_time], c[:class_name]] }

    self.display_date.text = @today.strftime("%a, %b %d, %Y")
  end

  def viewWillAppear(animated)
    self.daily.setEnabled !@daily_format
    self.weekly.setEnabled @daily_format
    super
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    @display_classes.length
  end

  def tableView(tableView, heightForRowAtIndexPath:path)
    60
  end
  
  def tableView(tableView, heightForHeaderInSection:section)
    24
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    @display_classes[section].length
  end

  def tableView(tableView, viewForHeaderInSection:section)
    header = tableView.dequeueReusableCellWithIdentifier(ScheduleGroupCell.name)
    item = @display_classes[section].first 
    case @group
    when :start_time
      header.populate("#{item[:start_time]}:00")
    else
      header.populate(item[@group])
    end

    header
  end 
  
  def tableView(tableView, cellForRowAtIndexPath:path)
    cell = tableView.dequeueReusableCellWithIdentifier(ScheduleCell.name)
    cell.populate(@display_classes[path.section][path.row], self.view)
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

    # show classes
    sort_classes(:start_time, :start_time) { |c| [c[:day_seq], c[:start_time], c[:class_name]] }
    self.table_view.reloadData
    self.table_view.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated:false)
  end

  def weeklyPressed
    @daily_format = !@daily_format
    self.daily.setEnabled !@daily_format
    self.weekly.setEnabled @daily_format
    today = Time.now
    next_week = today + (DAY * 7)
    self.display_date.text = "#{today.strftime('%a, %b %d, %Y')}  |  #{next_week.strftime('%a, %b %d, %Y')}"

    # show classes
    sort_classes(:day_seq, :day) { |c| [c[:day_seq], c[:start_time], c[:class_name]] }
    self.table_view.reloadData
    self.table_view.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated:false)
  end

  def backPressed
    @today -= DAY
    @daily_classes = @weekly_classes.select { |wc| wc[:day] == @today.strftime('%a').upcase }
    sort_classes(@group_by, @group) { |c| [c[:day_seq], c[:start_time], c[:class_name]] }
    self.display_date.text = @today.strftime("%a, %b %d, %Y")
    self.table_view.reloadData
    self.table_view.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated:false)
  end

  def forwardPressed
    @today += DAY
    @daily_classes = @weekly_classes.select { |wc| wc[:day] == @today.strftime('%a').upcase }
    sort_classes(@group_by, @group) { |c| [c[:day_seq], c[:start_time], c[:class_name]] }
    self.display_date.text = @today.strftime("%a, %b %d, %Y")
    self.table_view.reloadData
    self.table_view.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated:false)
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
      sort_classes(:start_time, :start_time) { |c| [c[:start_time], c[:day_seq], c[:class_name]] }
    when 1 # Class
      sort_classes(:class_name, :class_name) { |c| [c[:class_name], c[:start_time], c[:day_seq]] }
    when 2 # Instructor
      sort_classes(:instructor, :instructor) { |c| [c[:instructor], c[:start_time], c[:day_seq]] }
    end
    self.table_view.reloadData
    self.table_view.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated:false)
  end


  ############################################################################
  # Internal

  private

    def sort_classes(group_by, group_display, &block)
      @group_by = group_by
      @group = group_display
      classes = @daily_format ? @daily_classes : @weekly_classes
      @display_classes = classes.sort_by { |c| block.call(c) }.group_by { |g| g[group_by] }.sort.collect { |dc| dc.last }
    end

end