class CreateForeignKeys < ActiveRecord::Migration
  def self.up
    begin
      #add_foreign_key (:fromtable, :totable, :name)
      add_foreign_key(:abstracts, :users)
     rescue Exception => error
      puts "unable to add user_id foreign keys. Probably already exist"
    end
  end

  def self.down
  end
end
