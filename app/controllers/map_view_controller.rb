class MapViewController < UIViewController

  attr_accessor :club

  def loadView
    super
    camera = GMSCameraPosition.cameraWithLatitude(self.club.location[0], longitude: self.club.location[1], zoom: 15)
    @map_view = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
    @map_view.myLocationEnabled = true
    @map_view.settings.myLocationButton = true
    @map_view.delegate = self
    Google::Geo.mapAddMarker(CLLocationCoordinate2DMake(self.club.location[0], self.club.location[1]), @map_view, self.club.type_description, self.club.name)
    self.view = @map_view
  end


  ############################################################################
  # Map Delegate

  def mapView(mapView, idleAtCameraPosition:cameraPosition)
    # No more movement...
  end

end