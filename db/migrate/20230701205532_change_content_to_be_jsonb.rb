class ChangeContentToBeJsonb < ActiveRecord::Migration[7.0]
  def change
    change_column :pages, :content, 'jsonb USING content::jsonb'
  end
end
