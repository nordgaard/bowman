class AddAvatarToProduct < ActiveRecord::Migration[5.0]
  def up
    add_attachment :products, :avatar
  end

  def down
    remove_attachment :products, :avatar
  end
end
