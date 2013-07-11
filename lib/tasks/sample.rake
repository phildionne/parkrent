namespace :db do
  desc "Populates database with sample data"
  task sample: :environment do
    require 'factory_girl_rails'
    require File.join(Rails.root, 'db', 'sample')
  end
end
