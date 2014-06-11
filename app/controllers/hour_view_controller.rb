class HourViewController < UIViewController

  def viewDidLoad
    super
    @hours ||= [ { :group => 'CLUB', :items => [
                   { :header => 'Phone: (952) 985-8800' },
                   { :name => 'Daily', :hours => '24/7'} ]
                 },

                 { :group => 'ACTIVITY CENTER', :items => [
                   { :header => 'Phone: (952) 232-1319' },
                   { :name => 'Sunday', :hours => 'Closed'},
                   { :name => 'Monday – Thursday', :hours => '9am – 7pm'},
                   { :name => 'Friday', :hours => '9am – 2pm'},
                   { :name => 'Saturday', :hours => '9am – 1pm'} ]
                 },

                 { :group => 'CHILD CENTER', :items => [
                   { :header => 'Phone: (952) 232-1344' },
                   { :name => 'Sunday', :hours => '8am - 6pm'},
                   { :name => 'Monday – Thursday', :hours => '8am – 9pm'},
                   { :name => 'Friday - Saturday', :hours => '8am – 6pm'},
                   { :header => 'Child Center (Infant Hours)' },
                   { :name => 'Sunday', :hours => '8am - 5pm'},
                   { :name => 'Monday – Thursday', :hours => '8am – 8pm'},
                   { :name => 'Friday - Saturday', :hours => '8am – 6pm'} ]
                 },

                 { :group => 'GYMNASIUM', :items => [
                   { :header => 'Open Gym' },
                   { :name => 'Daily', :hours => '24/7'},
                   { :header => 'Family Gym' },
                   { :name => 'Sunday', :hours => '8am - 6pm'},
                   { :name => 'Monday – Friday', :hours => '1:30pm – 7pm'},
                   { :name => 'Saturday', :hours => '8am – 6pm'} ]
                 },

                 { :group => 'LIFE SPA', :items => [
                   { :header => 'Phone: (952) 232-1324' },
                   { :name => 'Sunday', :hours => '10am - 5pm'},
                   { :name => 'Monday', :hours => '11am – 8pm'},
                   { :name => 'Tuesday – Thursday', :hours => '10am – 8pm'},
                   { :name => 'Friday - Saturday', :hours => '10am – 6pm'} ]
                 }

               ]
  end


  ############################################################################
  # Table Delegate

  def numberOfSectionsInTableView(tableView)
    @hours.length
  end

  def tableView(tableView, heightForRowAtIndexPath:path)
    item = @hours[path.section][:items][path.row]
    if item.has_key?(:header)
      return 36
    end
    return 24 
  end
  
  def tableView(tableView, heightForHeaderInSection:section)
    24
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    @hours[section][:items].length
  end

  def tableView(tableView, viewForHeaderInSection:section)
    header = tableView.dequeueReusableCellWithIdentifier(HourGroupCell.name)
    item = @hours[section][:group]
    header.populate(item)

    header
  end 
  
  def tableView(tableView, cellForRowAtIndexPath:path)
    item = @hours[path.section][:items][path.row]
    cell = nil
    if item.has_key?(:header)
      cell = tableView.dequeueReusableCellWithIdentifier(HourHeadCell.name)
      cell.populate(item[:header])
    else
      cell = tableView.dequeueReusableCellWithIdentifier(HourCell.name)
      cell.populate(item)
    end
    
    cell
  end

  # We do this to avoid having separators after the last cell
  def tableView(tableView, heightForFooterInSection:section)
    return 0.01
  end

end