class MenuViewController < UIViewController

  def viewDidLoad
    super
    @menu ||= [ { :group => 'CLUBS', :items => [
                  { :menu => 'Edit Clubs...', :edit => true, :func => :modal_view, :params => { :id => 'ClubsEditSegue'}, :deselect => true },
                  { :menu => 'Chanhassen', :club_id => 0, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Lakeville', :club_id => 1, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Eden Prairie', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Woodbury', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true } ]
                },

                { :group => 'ACTIVITIES', :items => [
                  { :menu => 'Edit Activities...', :edit => true, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Zumba', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'CRT', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Strictly Strength', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Core', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true } ]
                },

                { :group => 'MEMBERSHIP', :items => [
                  { :menu => 'Reservations', :membership => true, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Account', :membership => true, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Card', :membership => true, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true },
                  { :menu => 'Logout', :membership => true, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => true } ]
                }
              ]

    @clubs ||= [ { :type => 'Life Time Fitness', :name => 'Chanhassen, MN', :phone => '952-380-0303', :address => "2901 Corporate Place\nChanhassen, MN 55317", :location => [44.8613635, -93.595238] },
                 { :type => 'Life Time Fitness', :name => 'Lakeville, MN', :phone => '952-985-8800', :address => "18425 Dodd Blvd\nLakeville, MN 55044", :location => [44.682659, -93.2515053] } ]

    #self.slidingViewController.setAnchorRightRevealAmount(280.0)
    self.slidingViewController.underLeftWidthLayout = ECFullWidth
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    @menu.length
  end

  def tableView(tableView, heightForRowAtIndexPath:path)
    44
  end
  
  def tableView(tableView, heightForHeaderInSection:section)
    24
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    @menu[section][:items].length
  end

  def tableView(tableView, viewForHeaderInSection:section)
    header = tableView.dequeueReusableCellWithIdentifier(MenuGroupCell.name)
    item = @menu[section][:group]
    header.populate(item)

    header
  end 
  
  def tableView(tableView, cellForRowAtIndexPath:path)
    item = @menu[path.section][:items][path.row]
    cell = nil
    if item[:membership]
      cell = tableView.dequeueReusableCellWithIdentifier(MenuMembershipCell.name)
      cell.populate(item[:menu])
    elsif item[:edit]
      cell = tableView.dequeueReusableCellWithIdentifier(MenuEditCell.name)
      cell.populate(item[:menu])
    else
      cell = tableView.dequeueReusableCellWithIdentifier(MenuCell.name)
      cell.populate(item[:menu])
    end
    
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:path)
    item = @menu[path.section][:items][path.row]
    club_id = item[:club_id] ? item[:club_id] : 0
    club = Club.new
    club.type = @clubs[club_id][:type]
    club.name = @clubs[club_id][:name]
    club.phone = @clubs[club_id][:phone]
    club.address = @clubs[club_id][:address]
    club.location = @clubs[club_id][:location]
    if self.respond_to?(item[:func])
      if item[:params]
        self.send(item[:func], item[:params], club)
      else
        self.send(item[:func], nil, club)
      end
    end
    tableView.deselectRowAtIndexPath(path, animated:true) if item[:deselect]
  end

  # We do this to avoid having separators after the last cell
  def tableView(tableView, heightForFooterInSection:section)
    return 0.01
  end


  ############################################################################
  # Actions

  def addPressed
    puts "!!!!! Pressed..."
  end


  ############################################################################
  # Internal

  def modal_view(params, club=nil)
    self.performSegueWithIdentifier(params[:id], sender:self)
  end

  def display_view(params, club=nil)
    newTopViewController = self.storyboard.instantiateViewControllerWithIdentifier(params[:id])
    newTopViewController.club = club
    self.slidingViewController.anchorTopViewOffScreenTo(ECRight, animations:nil, onComplete:lambda do
      frame = self.slidingViewController.topViewController.view.frame
      self.slidingViewController.topViewController = newTopViewController
      self.slidingViewController.topViewController.view.frame = frame
      self.slidingViewController.resetTopView
    end)
  end

end