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
	def counts(user)
		@count_microposts = user.microposts.count
	end
	
end
