module SessionsHelper
  
  #現在ログインしているユーザを取得するメソッド
  def current_user
    #a ||= xxx　・・・ a が false か nil なら a に xxx を代入する
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #find_by(id: id) と find(id) には大きな違いがある
  #検索結果がない時に.findはエラーがおきる find_byはnilを返す
  
  def logged_in?
    #!(not)なので!!(true)とする 判定をしたいがため一行で書くとこうなる
    !!current_user
  end 
  
end
