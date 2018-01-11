ActiveRecord::Base.configurations = if ENV['TRAVIS']
                                      YAML.load_file("config/database.yml")
                                    else
                                      { 'test' => { 'adapter' => 'sqlite3', 'database' => ':memory:' } }
                                    end
ActiveRecord::Base.establish_connection :test

class CreateAllTables < ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration[4.2]
  def self.up
    create_table(:invitations) do |t|
      t.boolean :accepted
    end
  end
end

ActiveRecord::Migration.verbose = false
CreateAllTables.up
