class RemoveNameFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :name, :string
  end
end
