class AddPlayerToLogs < ActiveRecord::Migration[6.0]
  def change
    add_reference :logs, :player, null: false, foreign_key: true
  end
end
