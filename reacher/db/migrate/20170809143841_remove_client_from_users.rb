class RemoveClientFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :users, :client
  end
end
