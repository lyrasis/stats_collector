# Stats Collector plugin

Stats collector plugin for ArchivesSpace.

## Configuration

Defaults:

```ruby
AppConfig[:stats_collector] = {
  schedule: '0 0 * * *',
  store: {
    class: 'ArchivesSpace::StatsCollector::DatabaseStore',
    config: AppConfig[:db_url]
  }
}
```

Explanation:

### Schedule

A [cron](#) expression that defines the frequency of stats collection.

### Store

#### Class

Class name for a store used to collect stats.

#### Config

Defines what is necessary to setup the store. The default config will
use ArchivesSpace's own database to store data.

Example for a custom MySQL database:

```ruby
config: {
  adaptor: :mysql2,
  host: ENV.fetch('STATS_DB_HOST'),
  database: 'statscollector',
  user: ENV.fetch('STATS_DB_USER'),
  password: ENV.fetch('STATS_DB_PASS'),
  encoding: 'UTF-8',
}
```

An optional `destination` value can be set to specify the table name
for storing stats data. By default `stats_collector_data` is used and
needs to be [created](setup/stats_collector_data.sql) if NOT using
ArchivesSpaces's own database.

## License

The project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

---
