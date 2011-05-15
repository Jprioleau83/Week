class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :micropost_id
  end

  def self.down
    drop_table :comments
  end
end
