class CreateWatchlists < ActiveRecord::Migration
  def change
    create_table :watchlists do |t|
      t.string :notes
      t.integer :user_id
    end
  end
end
