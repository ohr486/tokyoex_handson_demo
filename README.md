# tokyoex_handson_demo
tokyo.ex phoenix handson demo app

Gitterのイベントルームを用意しました、[こちら](https://gitter.im/ohr486/tokyo_ex_event?utm_source=share-link&utm_medium=link&utm_campaign=share-link)からご参加下さい。

## セットアップ

```
$ mix deps.get
$ mix compile
$ mix ecto.setup
$ npm install
```

## 起動

```
$ iex -S mix phoenix.server
```

* TOP
``$ open http://localhost:4000``

* Admin
``$ open http://localhost:4000/articles``

* Site List
``$ open http://localhost:4000/list``

## クローリング

```
$ iex -S mix phoenix.server
```

```
> TokyoexHandsonDemo.Crawler.Storage.start_link
> TokyoexHandsonDemo.Crawler.Engine.crawl("http://postd.cc",1,~r/^http:\/\/postd\.cc\/.*\/$/)
> TokyoexHandsonDemo.Crawler.Storage.store_to_db
```
