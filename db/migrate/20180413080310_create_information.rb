class CreateInformation < ActiveRecord::Migration[5.0]
  def change
    create_table :information do |t|
      t.references :user, foreign_key: true
      t.string :highschool
      t.string :university
      t.string :faculty
      t.text :content

      t.timestamps
    end
  end
end
