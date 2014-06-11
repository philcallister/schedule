class AmenityViewController < UIViewController

  extend IB

  # Outlets

  attr_accessor :club

  def viewDidLoad
    super
    @amenities ||= [ { :name => 'CARDIO EQUIPMENT', :description => "Life Time Cardio features the latest, most sophisticated cardio equipment available, complementing it with small-group, sports-specific training." },
                     { :name => 'FREE WEIGHTS', :description => "Everything from kettlebells and barbells to the most sophisticated free weight equipment. Loaded with weights so you can avoid the wait." },
                     { :name => 'FITNESS STUDIOS', :description => "Nationally certified Group Fitness experts help you launch a smart exercise program, move beyond stubborn plateaus, break out of fitness ruts and re-energize your workout." },
                     { :name => 'CYCLE STUDIOS', :description => "Concert-quality cycling theater and classes for all levels."}, 
                     { :name => 'YOGA STUDIO', :description => "Dedicated studios that promote the mind/body balance of these revolutionary practices."},
                     { :name => 'CHILD CENTER', :description => "Life Time is the perfect place for families. With an available on-site child center, your children can have fun playing and learning — all while you work out."},
                     { :name => 'LOCKER ROOM', :description => "Plush, pristine facilities richly appointed with cherrywood and limestone with granite counters."},
                     { :name => 'FAMILY LOCKER ROOM', :description => "Plush, pristine facilities richly appointed with cherrywood and limestone with granite counters."},
                     { :name => 'INDOOR SWIMMING', :description => "State-of-the-art indoor and outdoor pools, nationally recognized coaches, daily swim classes, and programs for swimmers of all ages and skill levels."} ]
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    @amenities.length
  end

  def tableView(tableView, heightForRowAtIndexPath:path)
    80
  end
  
  def tableView(tableView, heightForHeaderInSection:section)
    24
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    1
  end

  def tableView(tableView, viewForHeaderInSection:section)
    header = tableView.dequeueReusableCellWithIdentifier(AmenityGroupCell.name)
    header.populate(@amenities[section][:name])
    header
  end 
  
  def tableView(tableView, cellForRowAtIndexPath:path)
    item = @amenities[path.row]
    cell = tableView.dequeueReusableCellWithIdentifier(AmenityCell.name)
    cell.populate(@amenities[path.section][:description])
    cell
  end

  # We do this to avoid having separators after the last cell
  def tableView(tableView, heightForFooterInSection:section)
    return 0.01
  end

end