Rails.application.config.generators do |g|
    # CSS,JS,Helper関係のファイルを自動生成されないようにする設定
    g.stylesheet false
    g.javascripts false
    g.helper false
    # Routerにルーティングを自動的に追加もしない
    g.skip_routes true
end