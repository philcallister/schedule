class ClubsEditViewController < UIViewController

  extend IB

  # Outlets

  attr_accessor :club

  def viewDidLoad
    super
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
  end

  def tableView(tableView, heightForRowAtIndexPath:path)
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
  end

  def tableView(tableView, cellForRowAtIndexPath:path)
  end

  def tableView(tableView, didSelectRowAtIndexPath:path)
  end

  # We do this to avoid having separators after the last cell
  def tableView(tableView, heightForFooterInSection:section)
    return 0.01
  end


  ############################################################################
  # Actions

  def donePressed
    self.dismissModalViewControllerAnimated(true)
  end

  def addPressed
    puts "!!!!! addPressed..."
  end

end