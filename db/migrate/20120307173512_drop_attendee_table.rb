class DropAttendeeTable < ActiveRecord::Migration
  def up
    drop_table :attendees
  end

  def down
  end
end
