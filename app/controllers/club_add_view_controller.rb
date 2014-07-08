class ClubAddViewController < UIViewController

  extend IB

  # Outlets
  outlet :table, UITableView

  def viewDidLoad
    super

    Club.all_by_name { |clubs| @clubs = clubs }
 
    if (CLLocationManager.locationServicesEnabled)
      @location_manager = CLLocationManager.alloc.init
      @location_manager.desiredAccuracy = KCLLocationAccuracyKilometer 
      @location_manager.delegate = self
      @location_manager.startUpdatingLocation
    else
      puts("!!!!! Location not enabled...") 
    end
  end

  def viewWillAppear(animated)
    super
  end


  ############################################################################
  # Location Delegate

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    @current_location = newLocation
    @location_manager.stopUpdatingLocation
    Club.all_by_location(@current_location) { |clubs| @clubs = clubs }
    self.table.reloadData
  end

  def locationManager(manager, didFailWithError:error) 
    puts("!!!!! Location not enabled (#{error})") 
  end 
   
  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @clubs.length
  end

  def tableView(tableView, cellForRowAtIndexPath:path)
    item = @clubs[path.row]
    cell = tableView.dequeueReusableCellWithIdentifier(ClubAddCell.name)
    miles = nil
    if @current_location
      miles = item.distance_from_formatted(@current_location)
    else
      miles = "Loading..."
    end
    cell.populate("#{item.name}, #{item.state}", item.type_description, miles)
    cell
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

end