class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      #実際のDB上では、user_idとして存在　foreign_keyは外部キー制約という
      # foreign_keyはRailsの機能ではなく、DBの機能だよ
      # 他のテーブル（たとえばユーザテーブル)を参照して、データを利用するときは
      # かならず紐付いた整合性のあるデータとして存在させたいよね
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
