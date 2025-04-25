namespace :csv_task do
  desc "Load utility CSV after database setup"
  task seed_utilities_csv: :environment do
    load 'lib/tasks/seed_csv.rake'
    CsvHelper.utilityCSV("./db/data/iou_zipcodes_2023.csv")
    puts "CSV seeding complete."
  end
end
