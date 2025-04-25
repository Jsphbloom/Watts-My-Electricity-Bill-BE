require "rails_helper"

RSpec.describe "EnergyInfo object (non-model)" do
  describe "initialization and loading data" do
    context "happy paths" do
      #Correctly initializes with baseline search data
      it "exists, initializes correctly with baseline data" do
        search_data = {
          #Move to before(:each) if used again?
          nickname: "van down by the river",
          residence_type: "apartment",         #Not really, but need valid data
          num_residents: 2,
          efficiency_level: 1,
          zip_code: 80236
        }

        energy_info = EnergyInfo.new(search_data)

        expect(energy_info).to be_a(EnergyInfo)
        expect(energy_info.residence_name).to eq("van down by the river")
        expect(energy_info.residence_type).to eq("apartment")
        expect(energy_info.num_residents).to eq(2)
        expect(energy_info.efficiency_index).to eq(1)
        expect(energy_info.zip_code).to eq(80236)
      end

      #Check analyze_energy_and_cost() method (once external APIs exist and data can be stubbed)

    end

    context "sad paths" do
      #Returns null or raises error if API call / CSV results invalid (or should this only be handled in gateways/facades/CSV parser?)

      #Maybe: return null or raise error if calculation problem (might not need this, can't think of when this would happen if all data comes back correctly...)

    end
  end

end
