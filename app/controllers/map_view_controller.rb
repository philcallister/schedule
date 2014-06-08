class MapViewController < UIViewController

  attr_accessor :club

  def loadView
    camera = GMSCameraPosition.cameraWithLatitude(self.club.location[0], longitude: self.club.location[1], zoom: 15)
    @map_view = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
    @map_view.myLocationEnabled = true
    @map_view.settings.myLocationButton = true
    @map_view.delegate = self
    @markers = []
    mapAddMarker(CLLocationCoordinate2DMake(self.club.location[0], self.club.location[1]), self.club.type, self.club.name)
    self.view = @map_view
  end


  ############################################################################
  # Map Delegate

  def mapView(mapView, idleAtCameraPosition:cameraPosition)
    # No more movement...
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