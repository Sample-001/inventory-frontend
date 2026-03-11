# -----------------------------------------------------------------------------
# ステージ1: ビルド環境 (Node.js)
# Reactアプリケーションをビルドして静的ファイル(HTML/CSS/JS)を生成します
# -----------------------------------------------------------------------------
FROM node:20-alpine AS builder

# 作業ディレクトリの設定
WORKDIR /app

# 依存関係のインストール (キャッシュ活用のためにpackage.jsonを先にコピー)
COPY package.json package-lock.json ./
RUN npm ci

# ソースコードを全てコピーしてビルド実行
COPY . .
RUN npm run build
# ※ビルド成果物は通常 /app/build または /app/dist に作成されます


# -----------------------------------------------------------------------------
# ステージ2: 本番環境 (Nginx)
# ビルド済みの静的ファイルを軽量なNginxサーバーで配信します
# -----------------------------------------------------------------------------
FROM nginx:alpine

# Cloud Run の仕様に合わせてポート8080を公開
EXPOSE 8080

# 作成したNginxの設定ファイルをコンテナ内の所定の位置にコピー
COPY nginx.conf /etc/nginx/conf.d/default.conf

# ステージ1で作成したビルド成果物をNginxの公開ディレクトリにコピー
# ※Reactのバージョンや設定により build ではなく dist の場合があるので適宜修正してください
COPY --from=builder /app/build /usr/share/nginx/html

# Nginxをフォアグラウンドで起動
CMD ["nginx", "-g", "daemon off;"]
