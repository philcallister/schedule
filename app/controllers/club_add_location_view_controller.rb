class ClubAddLocationViewController < UIViewController

  extend IB

  # Outlets
  outlet :club_map_view, UIView

  attr_accessor :delegate

  def loadView
    super
    camera = GMSCameraPosition.cameraWithLatitude(0, longitude: 0, zoom: 15)
    @map_view = GMSMapView.mapWithFrame(self.club_map_view.bounds, camera: camera)
    @map_view.myLocationEnabled = true
    @map_view.settings.myLocationButton = true
    @map_view.delegate = self
    self.club_map_view.addSubview(@map_view)

    if (CLLocationManager.locationServicesEnabled)
      @location_manager = CLLocationManager.alloc.init
      @location_manager.desiredAccuracy = KCLLocationAccuracyKilometer 
      @location_manager.delegate = self
      @location_manager.startUpdatingLocation
    else
      puts("!!!!! Location not enabled...") 
    end
  end


  ############################################################################
  # Location Delegate

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    @current_location = newLocation
    @map_view.camera = GMSCameraPosition.cameraWithTarget(@current_location.coordinate, zoom:10)
    @location_manager.stopUpdatingLocation
    Club.all_by_location(@current_location) do |clubs|
      clubs.each do |club|
        Google::Geo.mapAddMarker(CLLocationCoordinate2DMake(club.location[0], club.location[1]), @map_view, club.type_description, club.name)
      end
    end
  end

  def locationManager(manager, didFailWithError:error) 
    puts("!!!!! Location not enabled (#{error})") 
  end


  ############################################################################
  # Map Delegate

  def mapView(mapView, idleAtCameraPosition:cameraPosition)
    # No more movement...
  end

  def mapView(mapView, didTapInfoWindowOfMarker:marker)
    puts "!!!!! Tap Tap..."
  end
  

  ############################################################################
  # Actions

  def listPressed
    self.dismissModalViewControllerAnimated(true)
  end

  def donePressed
    self.dismissModalViewControllerAnimated(false)
    delegate.dismissModalViewControllerAnimated(true)
  end

end