class MenuViewController < UIViewController

  def viewDidLoad
    super
    @first_appearance = true

    @menu ||= [ { :group => 'CLUBS', :items => [
                  { :menu => 'Chanhassen', :club_id => 0, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'Lakeville', :club_id => 1, :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'Eden Prairie', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'Woodbury', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false } ]
                },

                { :group => 'ACTIVITIES', :items => [
                  { :menu => 'Zumba', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'CRT', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'Strictly Strength', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'Core', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false } ]
                },

                { :group => 'MEMBERSHIP', :items => [
                  { :menu => 'Reservations', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'Account', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'Card', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false } ]
                },

                { :group => 'PROFILE', :items => [
                  { :menu => 'Settings', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false },
                  { :menu => 'Logout', :func => :display_view, :params => { :id => 'InitialNavigation'}, :deselect => false } ]
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
    30
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
    item = @menu[path.section][:items][path.row][:menu]
    cell = tableView.dequeueReusableCellWithIdentifier(MenuCell.name)
    cell.populate(item)
    if @first_appearance
      @first_appearance = false
      tableView.selectRowAtIndexPath(path, animated:false, scrollPosition:UITableViewScrollPositionTop)
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