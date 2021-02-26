class User < ApplicationRecord
  #事前にemail（自身)をすべて小文字へ置き換え(downcase!)
  before_save { self.email.downcase! }
  
  
  # validate for name
  validates :name, presence: true, length: { maximum: 50 }
  
  # validate for e-mail
  validates :email, presence: true, length: { maximum: 255 }, 
                    #mailアドレスの形式を正規表現で記述し対象データのフォーマット確認
                    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    #重複禁止(caase_sensitveで大小文字を区別するかどうかを設定)
                    uniqueness: { case_sensitive: false }
                    
  
    #password_digest(暗号文)カラムを用意し、モデルにhas~を記述する
  #利用する際には bcrypt のgemを有効かする必要がある
  # authenticate認証メソッド
  has_secure_password
  
  # UserモデルとMicropostモデルの関係性が
  # 1 vs 多 ということを表現している
  # has_many :多いmodel
  # 自動で書かれないので手打ち必須
  has_many :microposts
end
