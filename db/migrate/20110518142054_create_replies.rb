class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.integer :message_id
      t.integer :user_id
      t.integer :sender_id
      t.string :body
      t.string :subject

      t.timestamps
    end
    
    
  end

  def self.down
    drop_table :replies
  end
end
