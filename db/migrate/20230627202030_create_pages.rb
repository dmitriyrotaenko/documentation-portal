class CreatePages < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :pages, id: :uuid do |t|
      t.string :title
      t.string :content
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
