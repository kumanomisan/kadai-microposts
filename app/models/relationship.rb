class Relationship < ApplicationRecord
  belongs_to :user
  # user_idはモデル名_idの名称規則にのっとり、Railsが自動でUserを参照する
  # followは上記条件を満たさないので、手動でUserを参照するようにする必要がある
  belongs_to :follow, class_name: "User"
end
