class Club #< MotionDataWrapper::Model
  
  @@clubs_loaded = false

  # type
  # name
  # phone
  # address
  # location

  attr_accessor :id, :name, :city, :state, :address, :zip, :phone, :type, :type_description, :location

  def initialize args=nil
    if args
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
  end

  def self.force_load(&block)
    load_clubs do
      block.call()
    end
  end

  def self.all_by_name(&block)
    load_clubs do
      block.call(@@clubs_all)
    end
  end

  def self.all_by_location(other_location, &block)
    load_clubs do
      clubs = @@clubs_all.sort { |x, y| x.distance_from_meters(other_location) <=> y.distance_from_meters(other_location) }
      block.call(clubs)
    end
  end

  def self.find_by_id(id, &block)
    load_clubs do
      club = @@clubs_all.detect { |c| c.id == id }
      block.call(club)
    end
  end

  def self.find_by_name(name, &block)
    load_clubs do
      filter_clubs = @@clubs_all.select { |club| club.name == name }
      block.call(filter_clubs)
    end
  end

  def club_name_full
    "#{self.name}, #{self.state}"
  end

  def distance_from_meters(other_location)
    this_location = CLLocation.alloc.initWithLatitude(self.location[0], longitude:self.location[1])
    this_location.distanceFromLocation(other_location)
  end

  def distance_from_formatted(other_location)
    meters = distance_from_meters(other_location)
    "#{'%.1f' % (meters * 0.000621371)} Miles"
  end

  private

    def self.load_clubs(&block)
      if @@clubs_loaded
        block.call
      else
        @@clubs_loaded = true
        @@clubs_all = []
        client = AFMotion::Client.build("https://schedule.lifetimefitness.com/") do
          header "Accept", "application/json"
          response_serializer :json
        end
        client.get("clubs.json") do |result|
          result.object["clubs"].each do |club|
            c = Club.new(:id => club["id"], :name => club["name"], :city => club["city"], :state => club["state_abbr"],
                     :address => club["address"], :zip => club["zip"], :phone => club["phone"],
                     :type => club["type"], :location => [club["lat"], club["lng"]])
            c.name = c.name.gsub(/Life Time Athletic,?/, '').gsub(/Life Time Fitness,?/, '').gsub(/Athletic,?/, '').gsub(/and LifeSpa,?/, '').gsub(/and Tennis,?/, '').strip
            c.type_description = c.type < 4 ? 'Life Time Fitness' : 'Life Time Athletic'
            @@clubs_all << c
          end

          puts "!!!!! CLUBS: #{@@clubs_all.length}"

          block.call
        end
      end
    end

end