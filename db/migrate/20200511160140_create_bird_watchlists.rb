class CreateBirdWatchlists < ActiveRecord::Migration
  def change
    create_table :bird_watchlists do |t|
      t.integer :quantity, default: 1
      t.integer :watchlist_id
      t.integer :bird_id
    end
  end
end
