class CalendarController < UIViewController

  attr_accessor :calendar, :button, :label

  def loadView
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight
    view.autoresizesSubviews = true
    view.backgroundColor = UIColor.whiteColor

    today = Time.now
    day = 3600 * 24
    d = [today, today + day, today + (day * 2), today + (day * 3), today + (day * 4), today + (day * 5), today + (day * 6),
         today + (day * 7), today + (day * 8), today + (day * 9), today + (day * 11), today + (day * 12), today + (day * 13)]
    self.calendar = DIDatepicker.alloc.initWithFrame(CGRectMake(0, 20, self.view.frame.size.width, 50))
    self.calendar.bottomLineColor = UIColor.lightGrayColor
    self.calendar.setDates(d)
    self.calendar.addTarget(self, action: "updateSelectedDate", forControlEvents:UIControlEventValueChanged)
    self.calendar.backgroundColor = UIColor.colorWithRed(236.0/255.0, green:241.0/255.0, blue:246.0/255.0, alpha:1.0)
    self.view.addSubview(self.calendar)

    self.button = UIButton.alloc.init
    self.button.setTitle("Select Date", forState: UIControlStateNormal)
    self.button.backgroundColor = UIColor.orangeColor
    self.button.frame = [[100, 100], [100, 50]]
    self.button.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 3)
    self.button.addTarget(self, action: "buttonSelected", forControlEvents:UIControlEventTouchUpInside)
    self.view.addSubview(self.button)

    self.label = UILabel.alloc.initWithFrame(CGRectZero)
    self.label.text = "Please pick a date..."
    self.label.color = UIColor.blackColor
    self.label.sizeToFit
    self.label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)
    self.view.addSubview(self.label)
  end

  def viewDidLoad
    super
  end

  def viewWillAppear(animated)
    super
  end

  def buttonSelected
    puts "!!!!! buttonSelected..."
    self.calendar.selectDate(Time.now)
  end

  def updateSelectedDate
    self.label.text = self.calendar.selectedDate.to_s
  end

end
