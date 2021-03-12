class ApplicationController < ActionController::Base
	
	#HelperはControllerから使うときはincludeが必要
	#erbから呼び出すときはいらぬ
	include SessionsHelper
	
	
	private
	
	# ログインしているかどうかの確認をする
	def require_user_logged_in
		#unlessはifの反対 falseの時に処理を実施
		unless logged_in?
			redirect_to login_url
		end
	end
	
	# Micropost の数のカウントを View で表示するためのメソッド
	# フォロー関係の数も取得
	def counts(user)
		@count_microposts = user.microposts.count
		@count_followings = user.followings.count
		@count_followers = user.followers.count
		@count_favorites = user.favorites.count
	end
	

end
