class AddSlugAndPositionToPages < ActiveRecord::Migration[7.0]
  def change
    add_column :pages, :slug, :string
    add_column :pages, :position, :integer
  end
end
