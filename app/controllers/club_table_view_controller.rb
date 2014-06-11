class ClubTableViewController < UITableViewController

  extend IB

  # Outlets
  outlet :table, UITableView

  attr_accessor :club

  def viewDidLoad
    super
  end

  def viewWillAppear(animated)
    if self.club.nil?
      self.club = Club.new
      self.club.type = 'Life Time Fitness'
      self.club.name = 'Chanhassen, MN'
      self.club.phone = '952-380-0303'
      self.club.address = "2901 Corporate Place\nChanhassen, MN 55317"
      self.club.location = [44.8613635, -93.595238]
    end
    super
  end

  def prepareForSegue(segue, sender:sender)
    vc = segue.destinationViewController
    case segue.identifier
    when 'LocationSegue'
      vc.club = self.club
    when 'ProgramSegue'
      vc.club = self.club
    when 'AmenitySegue'
      vc.club = self.club
    end
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    3
  end

  def tableView(tableView, heightForRowAtIndexPath:path)
    50
  end
  
  def tableView(tableView, heightForHeaderInSection:section)
    section == 0 ? 75 : 24
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    case section
    when 0
      return 2
    when 1
      return 4
    when 2
      return 1
    end
  end

  def tableView(tableView, viewForHeaderInSection:section)
    header = nil
    case section
    when 0
      header = tableView.dequeueReusableCellWithIdentifier(ClubGroupCell.name)
      header.populate(self.club.type, self.club.name)
    else
      header = tableView.dequeueReusableCellWithIdentifier(ClubGroupEmptyCell.name)
    end

    header
  end 
  
  def tableView(tableView, cellForRowAtIndexPath:path)
    cell = nil
    case path.section
    when 0
      cell = tableView.dequeueReusableCellWithIdentifier(ClubCell.name)
      case path.row
      when 0
        cell.populate('Phone', self.club.phone)
      when 1
        cell.populate('Address', self.club.address)
      end
    when 1
      cell = tableView.dequeueReusableCellWithIdentifier(ClubDetailCell.name)
      case path.row
      when 0
        cell.populate('Today At The Club')
      when 1
        cell.populate('Programs')
      when 2
        cell.populate('Amenities')
      when 3
        cell.populate('Hours')
      end
    when 2
      cell = tableView.dequeueReusableCellWithIdentifier(ClubLinkCell.name)
      cell.populate('Directions To Here')
    end
    
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:path)
    case path.section
    when 0
      case path.row
      when 0
        @selected_cell = tableView.cellForRowAtIndexPath(path)
        title = @selected_cell.description.text
        alert = UIAlertView.alloc.initWithTitle(title,
                                                message: nil,
                                                delegate:self,
                                                cancelButtonTitle:"Cancel",
                                                otherButtonTitles:"Call", nil)
        alert.show
        tableView.deselectRowAtIndexPath(path, animated:true)
      when 1
        self.performSegueWithIdentifier("LocationSegue", sender:self)
      end
    when 1
      case path.row
      when 0
        self.performSegueWithIdentifier("ScheduleSegue", sender:self)
      when 1
        self.performSegueWithIdentifier("ProgramSegue", sender:self)
      when 2
        self.performSegueWithIdentifier("AmenitySegue", sender:self)
      when 3
        self.performSegueWithIdentifier("HourSegue", sender:self)
      end
    when 2
      place = MKPlacemark.alloc.initWithCoordinate(CLLocationCoordinate2DMake(self.club.location[0], self.club.location[1]), addressDictionary: nil)
      destination = MKMapItem.alloc.initWithPlacemark(place)
      destination.name = "#{self.club.type}\n#{self.club.name}"
      destination.phoneNumber = self.club.phone
      items = [destination]
      options = { MKLaunchOptionsDirectionsModeDriving => MKLaunchOptionsDirectionsModeKey }
      MKMapItem.openMapsWithItems(items, launchOptions: options)
      tableView.deselectRowAtIndexPath(path, animated:true)
    end
  end

  # We do this to avoid having separators after the last cell
  def tableView(tableView, heightForFooterInSection:section)
    return 0.01
  end

  def alertView(alertView, clickedButtonAtIndex:buttonIndex)

    if buttonIndex == 1
      phoneNumber = @selected_cell.description.text
      phoneFormat = "tel:#{phoneNumber}"
      phoneURL = NSURL.URLWithString(phoneFormat)
      UIApplication.sharedApplication.openURL(phoneURL)
    end
  end


  ############################################################################
  # Actions

  def menuPressed
    self.slidingViewController.anchorTopViewTo(ECRight)
  end

end