class ClubAddLocationViewController < UIViewController

  extend IB

  # Outlets
  outlet :club_map_view, UIView

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
  end

  def locationManager(manager, didFailWithError:error) 
    puts("!!!!! Location not enabled (#{error})") 
  end


  ############################################################################
  # Map Delegate

  def mapView(mapView, idleAtCameraPosition:cameraPosition)
    # No more movement...
  end

  
  ############################################################################
  # Actions

  def listPressed
    self.dismissModalViewControllerAnimated(true)
  end


  ############################################################################
  # Internal

  private

    def mapAddMarker(position, title="Title", snippet="Snippet")
      marker = GMSMarker.alloc.init
      marker.position = CLLocationCoordinate2DMake(position.latitude, position.longitude)
      marker.title = title
      marker.snippet = snippet
      marker.icon = GMSMarker.markerImageWithColor(UIColor.colorWithRed(236.0/255.0, green:96.0/255.0, blue:77.0/255.0, alpha:1.0))
      marker.map = @map_view
      @markers << marker
      marker
    end

end