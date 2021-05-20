class RemoveIsDeleatedFromMembers < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :is_deleated, :boolean
  end
end
