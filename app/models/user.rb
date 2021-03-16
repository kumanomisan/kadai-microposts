class User < ApplicationRecord
  # 事前にemail（自身)をすべて小文字へ置き換え(downcase!)
  before_save { self.email.downcase! }

  # validate for name
  validates :name, presence: true, length: { maximum: 50 }
  
  # validate for e-mail
  validates :email, presence: true, length: { maximum: 255 }, 
                    #mailアドレスの形式を正規表現で記述し対象データのフォーマット確認
                    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    #重複禁止(case_sensitveで大小文字を区別するかどうかを設定)
                    uniqueness: { case_sensitive: false }
  
  # password_digest(暗号文)カラムを用意し、モデルにhas~を記述する
  # 利用する際には bcrypt のgemを有効かする必要がある
  # authenticate認証メソッド
  has_secure_password
  
  # UserモデルとMicropostモデルの関係性が
  # 1 vs 多 ということを表現している
  # has_many :多いmodel
  # 自動で書かれないので手打ち必須
  has_many :microposts

  # 『多対多』の関係は2つの『一対多』の関係の組み合わせ
  # ここで言うrelationship は フォローしているユーザ（多)
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  
  # reverses_of_relationshipはシンボル型の変数名を[関係]としてここで宣言
  # 参照するCalssはRelationship(中間テーブル)
  # 外部参照キーはfollow_idとする
  # 理由:UserモデルからRelationshipを取得するとuser_idが返されるけど、
  # ここでは自分「を」フォローしているUserへの参照を意味したいため。
  # 関係性を明示している？ どこ to どこ　のような矢印の定義がhas_many:xxxのxxx?
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  # お気に入り機能
  has_many :favorites
  has_many :favorite_microposts, through: :favorites, source: :micropost, dependent: :destroy 
  
  # お気に入りに追加されたまま削除されてもエラーにならないようにする
  

  # ================ここにルーティン的なメソッドを書く==================
  # 常にフォロー/フォロワーの動作は、
  # 対象が自分自身でないことと、
  # すでに関係性があるかないかをチェックすることを常に行う。
  
  # 実行した User(自分自身) のインスタンスが self 
  
  # フォローするときのメソッド
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  # リムるメソッド
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  # 既に関係があるかないかの確認メソッド
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  # following_ids は User モデルの has_many :followings, 
  # ... によって自動的に生成されるメソッドです。
  # User がフォローしている User の id の配列を返す
  # フォローユーザ＋自分　がタイムラインなので、配列に自身のIDを足す
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end 
  
  # お気に入り機能のメソッド
  
  # お気に入り追加
  def register_favorite(favorite_post)
    self.favorites.find_or_create_by(micropost_id: favorite_post.id)
  end    
  
  # お気に入り削除
  def release_favorite(favorite_post)
    favorite_relationship = self.favorites.find_by(micropost_id: favorite_post.id)
    favorite_relationship.destroy if favorite_relationship
  end
  
  # お気に入り関係チェック
  def in_favorite?(favorite_post)
    self.favorite_microposts.include?(favorite_post)
  end    

  
end

