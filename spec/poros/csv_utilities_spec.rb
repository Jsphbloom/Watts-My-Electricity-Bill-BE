require "rails_helper"

RSpec.describe "CsvUtilities" do
  describe "initialize" do
    it "exits" do
      utils = CsvUtility.new(80236, 'CO', 20, 15, 5)

      expect(utils).to be_an_instance_of(CsvUtility)
      expect(utils.zipcode).to eq(80236)
      expect(utils.state).to eq('CO')
      expect(utils.res_rate).to eq(20)
      expect(utils.ind_rate).to eq(15)
      expect(utils.comm_rate).to eq(5)
    end
  end
end
