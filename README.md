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
- [Elixir School日本語版][elixir_school_jp]
- [「プログラミングElixir」書籍、2016年8月発売予定][elixir_book]
- [【英語】Elixir言語のホームページ][elixir_home]
- [【英語】Phoenixフレームワークのホームページ][phoenix_home]
- [【英語】「Programming Phoenix」書籍][phoenix_book]
- [【英語】「Metaprogramming Elixir」書籍][metaprogramming_book]
- [【英語】「Elixir and Phoenix」書籍、2016年9月10日発売予定][elixir_phoenix_book]
- [【英語】「ElixirConfEU 2016」動画][elixirconfeu-2016]
- [【英語】「ElixirConfUS 2015」動画][elixirconfus-2015]
- [【英語】「The Road to 2 Million Websocket Connections in Phoenix」記事][phoenix-2-million]

[conpass]: http://beam-lang.connpass.com/event/34985/
[gitter]: https://gitter.im/ohr486/tokyo_ex_event?utm_source=share-link&utm_medium=link&utm_campaign=share-link
[elixir_school_jp]: https://elixirschool.com/jp/
[elixir_book]: http://shop.ohmsha.co.jp/shopdetail/000000004675/
[elixir_home]: http://elixir-lang.org
[phoenix_home]: http://www.phoenixframework.org
[phoenix_book]: https://pragprog.com/book/phoenix/programming-phoenix
[metaprogramming_book]: https://pragprog.com/book/cmelixir/metaprogramming-elixir
[elixir_phoenix_book]: https://pragprog.com/book/lhelph/elixir-and-phoenix
[elixirconfeu-2016]: http://bit.ly/1TrVaqC
[elixirconfus-2015]: http://bit.ly/1Ly8Dug
[phoenix-2-million]: http://www.phoenixframework.org/blog/the-road-to-2-million-websocket-connections

