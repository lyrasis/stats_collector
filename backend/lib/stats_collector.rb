module ArchivesSpace
  class StatsCollector
    attr_reader :data, :db
    def initialize(db:, name:, url:)
      @data = { name: name, url: url }
      @db = db
    end

    def gather
      @data[:date] = Time.now
      @data[:global] = gather_global_data
      @data[:repository] = gather_repository_data
      @data[:user] = gather_user_data
      data
    end

    private

    def gather_global_data
      d = {}
      db.open do |aspacedb|
        d[:accession] = aspacedb[:accession].count
        d[:archival_object] = aspacedb[:archival_object].count
        d[:digital_object] = aspacedb[:digital_object].count
        d[:location] = aspacedb[:location].count
        d[:repository] = aspacedb[:repository].where(hidden: 0).count
        d[:subject] = aspacedb[:subject].count
        d[:top_container] = aspacedb[:top_container].count
        d[:user] = aspacedb[:user].where(is_system_user: 0).count
      end
      d[:total] = d.values.inject(:+)
      JSON.generate(d)
    end

    def gather_repository_data
      JSON.generate({})
    end

    def gather_user_data
      JSON.generate({})
    end
  end
end
