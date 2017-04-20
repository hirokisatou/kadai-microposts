class CreateFavos < ActiveRecord::Migration[5.0]
  def change
    create_table :favos do |t|
      t.references :user, options: 'ON UPDATE CASCADE ON DELETE CASCADE' ,foreign_key: true 
      t.references :micropost, options: 'ON UPDATE CASCADE ON DELETE CASCADE',foreign_key: true

      t.timestamps
      
      t.index [:user_id, :micropost_id], unique: true
    end
  end
end
