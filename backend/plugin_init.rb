require_relative 'lib/stats_collector'
require_relative 'lib/store'

unless AppConfig.has_key? :stats_collector
  AppConfig[:stats_collector] = {
    schedule: '* * * * *',
    store: {
      class: 'ArchivesSpace::StatsCollector::DatabaseStore',
      config: AppConfig[:db_url]
    }
  }
end

if AppConfig[:stats_collector][:store][:class] =~ /DynamoDB/
  # fog/aws is available in archivesspace
  require 'fog/aws/dynamodb'
end

Log.info "\n\n\nStats collector enabled!\n\n\n"

ArchivesSpaceService.loaded_hook do
  ArchivesSpaceService.settings.scheduler.cron(
    AppConfig[:stats_collector][:schedule], :tags => "stats-collector-#{Time.now.to_i}"
  ) do
    cfg = AppConfig[:stats_collector][:store][:config]
    sto = AppConfig[:stats_collector][:store][:class]
    store = sto.constantize.new(config: cfg)

    collector = ArchivesSpace::StatsCollector.new(
      db: DB,
      name: AppConfig[:cookie_prefix],
      url: AppConfig[:frontend_proxy_url],
    )
    Log.info "Gathering stats: #{Time.now}"
    store.save data: collector.gather
  end
end
