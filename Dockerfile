FROM nginx:alpine

# Cloud Runの仕様に合わせてポート8080を公開
EXPOSE 8080

# Nginxの設定ファイルをコピー
COPY nginx.conf /etc/nginx/conf.d/default.conf

# オリジナルのHTMLファイルをNginxの公開フォルダにコピー
COPY index.html /usr/share/nginx/html/index.html

CMD ["nginx", "-g", "daemon off;"]