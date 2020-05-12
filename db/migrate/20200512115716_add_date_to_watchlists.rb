class AddDateToWatchlists < ActiveRecord::Migration
  def change
    add_column :watchlists, :date_created, :text
  end
end
