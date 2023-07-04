class AddParentToPages < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :parent_id, :uuid, null: true
  end
end
