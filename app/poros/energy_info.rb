class EnergyInfo
  #Standardizes external API data, and provides calculations/functionality
  #NOTE: will need to decide if state average data is handled here, or by a separate model and DB / PORO

  attr_reader :residence_name, :state, :energy_consumption, :cost, :residence_type,
              :efficiency_index, :coordinates, :num_residents,
              :zip_code, :zip_res_rate, :zip_ind_rate, :zip_comm_rate,
              :state_ind_rate, :state_ind_average, :state_comm_average,
              :average_state_rate, :state_res_average, :zipcode
  attr_writer :zip_res_rate, :zip_ind_rate, :zip_comm_rate,
              :state, :state_res_average, :state_ind_average, :state_comm_average,
              :average_state_rate

  def initialize(user_search_data)
    #Assume very simple clean structure for now.  THIS MIGHT CHANGE LATER.
    @residence_name = user_search_data[:nickname]
    @zip_code = user_search_data[:zip_code].to_i #Determine/associate later (API call - might be outside MVP too)
    @residence_type = user_search_data[:residence_type]
    @num_residents = user_search_data[:num_residents]
    @efficiency_index = user_search_data[:efficiency_level]
    #Set to dummy values for now.  WILL CHANGE LATER.
    @state = nil                #Alternate: have it in a DB table for lookup
    @average_state_rate = nil   #ALternate: same
    @zip_res_rate = nil
    @zip_ind_rate = nil
    @zip_comm_rate = nil
    @state_res_average = nil
    @state_ind_average = nil
    @state_comm_average = nil
    @energy_consumption = 2500
    @cost = 380
  end

  def self.analyze_energy_and_cost(user_search_data)
    #Returns EnergyInfo object will fully sanitized and calculated data, ready for rendering/other
    
    residence_data = self.new(user_search_data)
    require 'pry'; binding.pry
    rate = CsvHelper.price_by_zip(residence_data.zip_code)

    residence_data.zip_res_rate = rate[:residential]
    residence_data.zip_ind_rate = rate[:industrial]
    residence_data.zip_comm_rate = rate[:commercial]
    residence_data.state = CsvHelper.state_by_zip(residence_data.zip_code)
    eia_reports = EiaGateway.report_details(residence_data.state)
    residence_data.state_res_average = eia_reports[:residential]
    residence_data.state_ind_average = eia_reports[:industrial]
    residence_data.state_comm_average = eia_reports[:commercial]

    #Latitude/longitude/zip code/state API call (geocoding) via gateway
    #CSV utility rate lookup
    #EIA state average utility rate API call via gateway
    #Create new residence object based on these data
    #Update residence_data instance vars based on API call responses (facade / other sanitizing method(s))
    #Calculate energy consumption and cost based on all the above (dummy values and empty methods for now, can implement near the very end of project)
    residence_data.calculate_energy_consumption
    residence_data.calculate_cost
    return residence_data
  end

  #Here are a few planned methods laid out for future implementation...
  
  def calculate_energy_consumption
    #Estimate / calculate energy consumption

  end
  
  def calculate_cost
    #Calculate electricity cost based on determined rate (and perhaps return two values)

  end

end
