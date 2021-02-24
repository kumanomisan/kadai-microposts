class ApplicationController < ActionController::Base
	
	#HelperはControllerから使うときはincludeが必要
	#erbから呼び出すときはいらぬ
	include SessionsHelper
	
	
	private
	
	def require_user_logged_in
		#unlessはifの反対 falseの時に処理を実施
		unless logged_in?
			redirect_to login_url
		end
	end
end
