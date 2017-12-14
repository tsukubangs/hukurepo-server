# サーバプログラム起動方法
## 概要
外国人訪問者の困りごとを集めるためのプラットフォーム*HUKUREPO*のサーバプログラムです。
外国人訪問者に困りごとを投稿してもらい、ボランティアなどがその困りごとに助言できるシステムとなっています。
外国人訪問者の困りごとを集め、外国人訪問者に合った施策を考える参考にして下さい。
<br>
<br>

## 準備
### 必要なもの
1. 80番・443番ポートを開放したサーバ（**推奨アーキテクチャ: Ubuntu16.04以上 amd64**）
1. サーバのドメイン

### 取得推奨
1. Google翻訳用のTranslation APIのキー[(参考)](https://cloud.google.com/translate/)
1. プッシュ通知用のFCM APIのキー[(参考)](https://firebase.google.com/docs/cloud-messaging/?hl=ja)
<br>

## サーバプログラム起動
以下の手順でサーバプログラムを起動させることができます。
sudo権限が付与されているユーザから実行してください。

1. リポジトリ取得
1. ユーザ固有設定（ドメインなど）
1. Dockerインストール
1. セットアップシェルの実行

<br>

### 1. リポジトリ取得
gitをインストールしてない場合はgitをインストールしてください。　
- 例：Ubuntuでのインストール方法
```bash
sudo apt-get install -y git
```
本リポジトリをサーバにクローンしてください。
```bash
git clone https://github.com/tsukubangs/hukurepo-server
```
リポジトリ取得後に、ディレクトリを移動して下さい
```bash
cd hukurepo-server
```

<br>
<br>

### 2. ユーザ固有設定（ドメインなど）
環境設定ファイル.env.sampleを.envとしてコピーしてください。
```bash
cp .env.sample .env
```

<br>

viなどを使い.envを編集して以下の設定を行って下さい。
- DOMAINSをサーバのドメインに変更してください
- セキュリティを気にする場合は、DBのパスワードや暗号キーベースを変更してください
- Google翻訳用のGOOGLE_TRANSLATION_APIのキーや、プッシュ通知用のFCMキーを取得している場合は設定してください

<br>
<br>

### 3. Dockerインストール
Docker-CEを使い、データベースやWebサーバプログラムを動かします。

Ubuntu16以上 amd64のサーバを使用している場合は、インストール作業をシェルで自動化しているため、そのまま「4.セットアップシェルの実行」に進んでください。

それ以外のアーキテクチャを使用する場合は[こちら](https://www.docker.com/community-edition)からインストールしてください。
Linuxの場合は[こちら](https://docs.docker.com/compose/install/#prerequisites)を参照してdocker-composeをインストールしてください。

<br>
<br>

### 4. セットアップシェルの実行
セットアップシェルを実行してください。
サーバプログラムに必要なものをダウンロード・インストールしたあとに起動します。
この処理は10～15分ほどかかります。

- サーバがUbuntu16以上amd64の場合
以下のシェルでDockerインストールとサーバプログラム起動を同時に行えます。
```bash
./setup_for_ubuntu16amd64.sh
```

- その他アーキテクチャの場合
Dockerインストール後に以下のシェルを実行してください。
```bash
./setup.sh
```
「サーバの起動に成功しました」というメッセージが出たらサーバプログラムの起動は完了です。

https://[your domain]でアクセスすることができます。
