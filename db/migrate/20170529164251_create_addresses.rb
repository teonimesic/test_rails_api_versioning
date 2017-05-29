class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :zipcode
      t.string :city
      t.string :region
      t.string :country
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
