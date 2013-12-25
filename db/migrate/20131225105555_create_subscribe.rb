class CreateSubscribe < ActiveRecord::Migration
  def change
    create_table :subscribes do |t|
      t.string  :email
      t.string  :sub_token
      t.string  :unsub_token
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
