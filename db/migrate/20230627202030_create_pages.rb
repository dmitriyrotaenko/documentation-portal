class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :title, unique: true, null: false
      t.string :content, null: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
