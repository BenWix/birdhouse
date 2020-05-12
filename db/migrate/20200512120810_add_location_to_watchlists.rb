class AddLocationToWatchlists < ActiveRecord::Migration
  def change
    add_column :watchlists, :location_id, :integer
  end
end
