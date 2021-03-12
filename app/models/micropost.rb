class Micropost < ApplicationRecord
  # UserモデルとMicropostモデルの関係性が
  # 1 vs 多 ということを表現している
  # belongs=所属の意 belongs=が1の相手
  
  # belongs_to :user の関連付けによって、
  # Micropost のインスタンスでインスタンスメソッド user が使えるようになります。
  # 使用例：micropost.user  
  # has_manyも同様です
  # user.microposts
  
  # 上記メソッド(microposts.user=この投稿したユーザのインスタンス取得)
  # user.microposts = ユーザのつぶやき全件ゲット
  
  # 投稿の作成は user.microposts.build(Micropost.new(user: user)と同じ処理)
  belongs_to :user
  
  # Tweet内容255文字までだよ
  validates :content, presence: true, length: { maximum:255 }
  
  has_many :favorites
  has_many :registered_users, through: :favorites, source: :user
  
end
