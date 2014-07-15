class ClubAddViewController < UIViewController

  extend IB

  # Outlets
  outlet :table, UITableView

  def viewDidLoad
    super
    Club.all_by_name { |clubs| @clubs = clubs }

    @filtered_clubs = []

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
  # Search Delegate

  # def filterContentForSearchText(searchText, scope:scope)
  #   puts "!!!!! filterContentForSearchText"
  #   # resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
  #   # searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
  # end

  def searchDisplayController(controller, shouldReloadTableForSearchString:searchString)
    @filtered_clubs = @clubs.select { |c| c.club_name_full.downcase.match(searchString.downcase) }
    return true
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    if tableView == self.searchDisplayController.searchResultsTableView
      return @filtered_clubs.length
    else
      return @clubs.length
    end
  end

  def tableView(tableView, cellForRowAtIndexPath:path)
    item = nil
    if tableView == self.searchDisplayController.searchResultsTableView
      item = @filtered_clubs[path.row]
    else
      item = @clubs[path.row]
    end
    cell = self.table.dequeueReusableCellWithIdentifier(ClubAddCell.name)

    miles = nil
    if @current_location
      miles = item.distance_from_formatted(@current_location)
    else
      miles = "Loading..."
    end
    cell.populate(item.club_name_full, item.type_description, miles)
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