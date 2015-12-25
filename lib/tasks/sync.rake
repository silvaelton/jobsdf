namespace :job do
  desc "Sync jobs"
  task :sync => :environment do
    Collector::collect!
  end
end