class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :content, null: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
