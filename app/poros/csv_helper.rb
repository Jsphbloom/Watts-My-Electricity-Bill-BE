require 'csv'

class CsvHelper
  attr_reader :data

  @data = []

  def self.utilityCSV(csv_data)
    CSV.foreach(csv_data, headers: true, header_converters: :symbol) do |row|
      @data << CsvUtility.new(
        row[:zip].to_i,
        row[:state],
        row[:res_rate].to_f,
        row[:ind_rate].to_f,
        row[:comm_rate].to_f
      )
    end
    @data
  end

  def self.price_by_zip(zipcode)
    zip_data = @data.select { |area| area.zipcode == zipcode.to_i }
    require 'pry'; binding.pry
    zip_data[0].state
    {
      residential: zip_data[0].res_rate,
      industrial: zip_data[0].ind_rate,
      commercial: zip_data[0].comm_rate
    }
  end

  def self.state_by_zip(zipcode)
    zip_data = @data.select { |area| area.zipcode == zipcode }
    zip_data[0].state
  end

  def self.price_by_state(state)
    state_data = @data.select { |area| area.state == state }
    state_total = state_data.sum { |area| area.res_rate }
    return state_total / state_data.length
  end

end
