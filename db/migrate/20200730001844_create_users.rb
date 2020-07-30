class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :alias_name
      t.string :name
      t.text :self_introduction
      t.string :image
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
