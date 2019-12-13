Sequel.migration do
  up do
    create_table(:stats_collector_data) do
      primary_key :id

      String :application, default: 'archivesspace', null: false
      DateTime :date, null: false
      TextBlobField :global, null: false
      String :name, null: false
      TextBlobField :repository, null: false
      String :url, null: false
      TextBlobField :user, null: false
    end

    alter_table(:stats_collector_data) do
      add_index([:name], name: "stats_collector_data_name_idx")
    end
  end
end
