# frozen_string_literal: true

class CreatePushbulletSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :pushbullet_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :access_token
      t.string :device_iden

      t.timestamps
    end
  end
end
