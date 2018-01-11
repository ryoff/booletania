ActiveRecord::Base.configurations = YAML.load_file("config/database.yml")
ActiveRecord::Base.establish_connection :test

class CreateAllTables < ActiveRecord::Migration[4.2]
  def self.up
    create_table(:invitations) do |t|
      t.boolean :accepted
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up
