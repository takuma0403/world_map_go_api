# Dockerfile
FROM golang:1.23-alpine AS builder

# 作業ディレクトリを設定
WORKDIR /app

# 必要な依存ライブラリをインストール
RUN apk update && apk add --no-cache git

# 必要なファイルをコピー
COPY go.mod go.sum ./
RUN go mod download

# ソースコードをコピー
COPY . .

# air のインストール
RUN go install github.com/air-verse/air@latest

# 開発用ステージにビルドアーティファクトを残しておく
RUN go build -o main src/cmd/main.go

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
