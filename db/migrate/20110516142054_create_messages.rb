class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.integer :sender_id
      t.string :body
      t.string :subject

      t.timestamps
    end
    
    
  end

  def self.down
    drop_table :messages
  end
end
