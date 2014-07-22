module Google

  class Direction

    BASE_HTTP = "https://maps.googleapis.com/maps/api/directions/json"

    def self.directions(origin, destination, waypoints=nil, &block)
      wpts = waypoints.inject('') { |r, e| r.empty? ? Geo::format(e) : "#{r}|#{Geo::format(e)}" } unless waypoints.nil?
      data = {origin: Geo::format(origin), destination: Geo::format(destination), waypoints: wpts, sensor: false}
      BW::HTTP.get(BASE_HTTP, {payload: data}) do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
          route = json['routes'].first['overview_polyline']['points']
          block.call(route) if block
        else
          App.alert(response.error_message)
        end
      end
    end

  end

  class Geo

    BASE_HTTP = "https://maps.googleapis.com/maps/api/geocode/json"

    def self.position(address, &block)
      data = {address: address, sensor: false}
      BW::HTTP.get(BASE_HTTP, {payload: data}) do |response|
        if response.ok?
          json = BW::JSON.parse(response.body.to_str)
          location = json['results'].first['geometry']['location']
          block.call(CLLocationCoordinate2DMake(location[:lat], location[:lng])) if block
        else
          App.alert(response.error_message)
        end
      end
    end

    def self.format(position)
      "#{position.latitude}, #{position.longitude}"
    end

    def self.mapAddMarker(position, map_view, title="Title", snippet="Snippet")
      marker = GMSMarker.alloc.init
      marker.position = CLLocationCoordinate2DMake(position.latitude, position.longitude)
      marker.title = title
      marker.snippet = snippet
      marker.icon = GMSMarker.markerImageWithColor(UIColor.colorWithRed(236.0/255.0, green:96.0/255.0, blue:77.0/255.0, alpha:1.0))
      marker.map = map_view
      marker
    end

  end  

end