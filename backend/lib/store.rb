module ArchivesSpace
  class StatsCollector
    class Store
      attr_reader :backend, :config, :destination
      def initialize(config: {})
        @backend = nil
        @config  = build_config(config)
        @destination = set_destination(config)
        setup
      end

      def build_config(config)
        return config unless config.respond_to? :fetch

        parts = [
          'jdbc:',
          "#{config[:adapter]}://",
          "#{config[:host]}:3306/",
          "#{config[:database]}?user=#{config[:user]}&password=#{config[:password]}",
        ].join
      end

      def save(data:)
        raise 'Implement in subclass!'
      end

      def setup
        raise 'Implement in subclass!'
      end

      private

      def set_destination(config)
        return 'stats_collector_data' unless config.respond_to? :fetch

        config.fetch(:destination, 'stats_collector_data')
      end
    end

    class DatabaseStore < Store
      def save(data:)
        @backend[destination.to_sym].insert(data)
      end

      def setup
        @backend = Sequel.connect(config)
      end
    end

    # class DynamoDBStore < Store
    #   def save(data:)
    #     # TODO
    #   end

    #   def setup
    #     @backend = Aws::DynamoDB::Client.new(config)
    #   end
    # end
  end
end
