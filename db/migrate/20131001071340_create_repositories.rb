class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
