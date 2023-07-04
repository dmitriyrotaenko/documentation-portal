class AllowPageTitleToBeEmpty < ActiveRecord::Migration[7.0]
  def change
    change_column :pages, :title, :string, null: true
  end
end
