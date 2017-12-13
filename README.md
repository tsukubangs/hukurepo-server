# サーバプログラム起動方法
## 概要
外国人訪問者の困りごとを集めるためのプラットフォーム*HUKUREPO*のサーバプログラムです。
外国人訪問者に困りごとを投稿してもらい、ボランティアなどがその困りごとに助言できるシステムとなっています。
外国人訪問者の困りごとを集め、外国人訪問者に合った施策を考える参考にして下さい。


## 準備
### 必要なもの
1. Ubutnu16.04が載っているサーバ(80番・443番ポートを開放）
1. サーバのドメイン

### 取得推奨
1. Google翻訳用のTranslation APIのキー[(参考)](https://cloud.google.com/translate/)
1. プッシュ通知用のFCM APIのキー[(参考)](https://firebase.google.com/docs/cloud-messaging/?hl=ja)


## サーバプログラム起動
以下の手順でサーバプログラムを起動させることができます。
sudo権限が付与されているユーザから実行してください。

1. リポジトリ取得
1. ユーザ固有設定（ドメインなど）
1. セットアップシェルの実行

### 1. リポジトリ取得
本リポジトリをサーバにクローンします。
gitをインストールしてない場合はgitをインストールしてください。
```bash
sudo apt-get install -y git
git clone https://github.com/tsukubangs/hukurepo-server
```

### 2. ユーザ固有設定（ドメインなど）
環境設定ファイル.env.sampleを.envにリネームしてください。
```bash
mv .env.sample .env
```

viなどを使い.envを編集して以下の設定を行って下さい。
- DOMAINSをサーバのドメインに変更してください
- セキュリティを気にする場合は、DBのパスワードや暗号キーベースを変更してください
- Google翻訳用のGOOGLE_TRANSLATION_APIのキーや、プッシュ通知用のFCMキーを取得している場合は設定してください


### 3. セットアップシェルの実行
以下のセットアップシェルを実行してください。
サーバプログラムに必要なものをダウンロード・インストールしたあとに起動します。
この処理は10～15分ほどかかります。

./setup.sh
```bash
mv .env.sample .env
```

「サーバの起動に成功しました」というメッセージが出たらサーバプログラムの起動は完了です。
https://[your domain]でアクセスすることができます。
