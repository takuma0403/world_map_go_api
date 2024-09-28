# Dockerfile
FROM golang:1.23-alpine AS builder

# 作業ディレクトリを設定
WORKDIR /app

# 必要な依存ライブラリをインストール
RUN apk update && apk add --no-cache git openssl

# 必要なファイルをコピー
COPY go.mod go.sum ./
RUN go mod download

# ソースコードをコピー
COPY . .

# air のインストール
RUN go install github.com/air-verse/air@latest

# 自己署名証明書を作成（開発用）
RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=localhost"

# 開発用の最終ステージ（Go環境も含む）
FROM golang:1.23-alpine

# 作業ディレクトリを設定
WORKDIR /app

# 必要なファイルをコピー
COPY --from=builder /app /app
COPY --from=builder /go/bin/air /usr/bin/air

# 依存ライブラリを再インストール（ランタイム用）
RUN apk update && apk add --no-cache git

EXPOSE 8080

# デフォルトコマンドを air に設定
CMD ["air"]
