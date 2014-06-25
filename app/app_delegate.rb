GOOGLE_MAP_API_KEY = "AIzaSyC94xyjVSuQZuYJ5n3j0WMlOYjxQ-l9770"

class AppDelegate

  #include MotionDataWrapper::Delegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    #TestFlight.takeOff("acde9e93-d73e-44b5-86e7-18c2070ddc29")
    #application.setStatusBarStyle(UIStatusBarStyleDarkContent)
    GMSServices.provideAPIKey(GOOGLE_MAP_API_KEY)
    true
  end

  def applicationWillResignActive(application)
  end

  def applicationWillEnterForeground(application)
  end

  def applicationDidEnterBackground(application)
  end

  def applicationDidBecomeActive(application)
  end
  
  def applicationWillTerminate(application)
  end

  # Cannot define these using attr_accessor :window. 
  def window
    @window
  end
  
  def setWindow(window)
    @window = window
  end

end
