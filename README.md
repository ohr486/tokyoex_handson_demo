# tokyoex_handson_demo
tokyo.ex phoenix handson demo app

Gitterのイベントルームを用意しました、[こちら][gitter]からご参加下さい。

## 事前準備

- elixirのインストール
- MySQLのインストール
    - ハンズオンで使用するdatabaseとアカウントの作成
- (可能であれば)AWSアカウントの作成
- 必要無いが、静的ファイルを管理する為にnpmとbrunch.ioが有ると良い

MySQL rootパスワード設定は下記の通りです。

```sh
$ # MySQL 5.7.6 以後
$ mysql -u root -p -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '';"
$
$ # MySQL 5.7.5 以前
$ mysql -u root -p -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('');"
```

## セットアップ

```sh
$ mix deps.get
$ mix compile
$ mix ecto.setup
$ npm install
```

## config/prod.secret.exsの再生方

```sh
$ SECRET_KEY_BASE=$(elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts")
$ sed "s|SECRET_KEY_BASE|$SECRET_KEY_BASE|" config/prod.secret.exs.example >config/prod.secret.exs
```

新しいsecret_key_baseが欲しい時に下記のコマンドが役に立ちます。

```sh
$ elixir -e ":crypto.strong_rand_bytes(48) |> Base.encode64 |> IO.puts"
```

## 起動

```sh
$ iex -S mix phoenix.server
```

* TOP
``$ open http://localhost:4000``

* Admin
``$ open http://localhost:4000/articles``

* Site List
``$ open http://localhost:4000/list``

## クローリング

```sh
$ iex -S mix phoenix.server
```

```elixir
> TokyoexHandsonDemo.Crawler.Storage.start_link
> TokyoexHandsonDemo.Crawler.Engine.crawl("http://postd.cc",1,~r/^http:\/\/postd\.cc\/.*\/$/)
> TokyoexHandsonDemo.Crawler.Storage.store_to_db
```

## リンク

- [Conpass tokyo.ex #4 phoenixハンズオン][conpass]
- [Gitter, ohr486/tokyo_ex_event][gitter]

[conpass]: http://beam-lang.connpass.com/event/34985/
[gitter]: https://gitter.im/ohr486/tokyo_ex_event?utm_source=share-link&utm_medium=link&utm_campaign=share-link

