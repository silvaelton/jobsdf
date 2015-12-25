class Collector
  def self.collect!
    ListJob.delete_all

    Collect::CorreioBraziliense.sync!
    puts "correio braziliense sincronizado..."


    Collect::BlogEmprego.sync!
    puts "blog do emprego sincronizado..."
  
  end
end