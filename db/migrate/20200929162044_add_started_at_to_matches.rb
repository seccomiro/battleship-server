class AddStartedAtToMatches < ActiveRecord::Migration[6.0]
  def change
    add_column :matches, :started_at, :datetime
  end
end
