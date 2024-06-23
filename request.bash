#!/bin/bash

# 送信先のURL
url="http://omochi.local:30080"

# 1000回のリクエストを繰り返す
for i in {1..10000}
do
   curl $url
   # 応答を確認したい場合は、上記のコマンドの出力を利用します。
   # 必要に応じてsleepを入れてサーバーへの負荷を調整することもできます。
   # sleep 1
done