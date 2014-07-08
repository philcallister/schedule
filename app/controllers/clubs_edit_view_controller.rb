class ClubsEditViewController < UIViewController

  extend IB

  # Outlets
  outlet :table, UITableView

  attr_accessor :club

  def viewDidLoad
    super
    Club.all_by_name { |clubs| @clubs = clubs }
  end

  def viewWillAppear(animated)
    self.table.setEditing(true, animated: false)
    super
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
    cell = tableView.dequeueReusableCellWithIdentifier(MenuEditClubCell.name)
    cell.populate(item.name)
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:path)
  end

  # We do this to avoid having separators after the last cell
  def tableView(tableView, heightForFooterInSection:section)
    return 0.01
  end

  def tableView(tableView, targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath, toProposedIndexPath:proposedDestinationIndexPath)
    proposedDestinationIndexPath
  end

  def tableView(tableView, moveRowAtIndexPath:from_index_path, toIndexPath:to_index_path)
  end

  def tableView(tableView, commitEditingStyle:editing_style, forRowAtIndexPath:index_path)
    if editing_style == UITableViewCellEditingStyleDelete
    end
  end



  ############################################################################
  # Actions

  def donePressed
    self.dismissModalViewControllerAnimated(true)
  end

  # def addPressed
  #   puts "!!!!! addPressed..."
  # end

end