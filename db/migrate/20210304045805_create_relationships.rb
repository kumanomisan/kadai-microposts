class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      # テーブルのuserをusersテーブルの外部キーとして参照するよ
      t.references :user, foreign_key: true
      # テーブルのfollowをfollowsテーブルではなく、
      # usersテーブルを外部キーとして参照するよ
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
      
      # すでにフォローしている人をフォローさせない
      # つまり中間テーブルに同じペアのレコードを存在させない
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
