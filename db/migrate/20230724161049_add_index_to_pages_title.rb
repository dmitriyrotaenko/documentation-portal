class AddIndexToPagesTitle < ActiveRecord::Migration[7.0]
  def change
    add_index(:pages, :title)
  end
end
