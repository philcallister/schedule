class ProgramViewController < UIViewController

  extend IB

  # Outlets

  attr_accessor :club

  def viewDidLoad
    super
    @programs ||= [ { :name => 'CYCLE', :image => 'programs/Cycle.png', :description => "Train, join a riding club or compete in an event. Regardless of your skill level, we have the staff and coaches to support you."},
                    { :name => 'RUN', :image => 'programs/Run.png', :description => "Meet up with fellow runners of all ages and abilities. Train or just keep in shape. Come run. Come all."},
                    { :name => 'SWIM', :image => 'programs/Swim.png', :description => "We'll help you jump right in with programs for swimmers of all ages and skill levels, the best facilities and nationally known coaches."},
                    { :name => 'BASKETBALL', :image => 'programs/UltimateHoops.png', :description => "For new hoops enthusiasts and pros we offer a professional, lifelong basketball experience."},
                    { :name => 'TENNIS', :image => 'programs/Tennis.png', :description => "Train, compete and play in our socially inviting leagues and events."},
                    { :name => 'SQUASH', :image => 'programs/Squash.png', :description => "Burn calories, get a heart-pounding cardio workout, build core muscles and also work your brain in this fast-paced challenging sport."},
                    { :name => 'TRAINING', :image => 'programs/Training.png', :description => "An affordable, simple and convenient health solution based on nutrition, exercise and education."},
                    { :name => 'GROUP FITNESS', :image => 'programs/GF.png', :description => "Meet your health, fitness and athletic goals with like-minded people in a motivating and empowering community."},
                    { :name => 'YOGA', :image => 'programs/Yoga.png', :description => "Our all-inclusive community enlightens and inspires our students while also training the industry’s best teachers."} ]
  end

  def prepareForSegue(segue, sender:sender)
    vc = segue.destinationViewController

    case segue.identifier
    when 'ProgramToScheduleSegue'
      # Nothing for now...
    end
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, heightForRowAtIndexPath:path)
    110
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    @programs.length
  end

  def tableView(tableView, cellForRowAtIndexPath:path)
    item = @programs[path.row]
    cell = tableView.dequeueReusableCellWithIdentifier(ProgramCell.name)
    cell.populate(item)
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:path)
    self.performSegueWithIdentifier("ProgramToScheduleSegue", sender:self)
    tableView.deselectRowAtIndexPath(path, animated:true)
  end

  # We do this to avoid having separators after the last cell
  def tableView(tableView, heightForFooterInSection:section)
    return 0.01
  end

end