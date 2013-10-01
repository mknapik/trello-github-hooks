class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :uid
      t.string :name
      #t.references :user, index: true

      t.timestamps
    end
  end
end
