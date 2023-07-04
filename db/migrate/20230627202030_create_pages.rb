class CreatePages < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :pages, id: :uuid do |t|
      t.string :title, null: true
      t.text :content, null: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
