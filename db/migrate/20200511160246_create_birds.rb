class CreateBirds < ActiveRecord::Migration
  def change
    create_table :birds do |t|
      t.string :name
    end
  end
end
