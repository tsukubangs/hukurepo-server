
## <a name="resource-problem">Problem</a>

Stability: `prototype`

外国人訪問者の困りごとを投稿，閲覧するAPI

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | problem's comment | `"SOX is difficult"` |
| **created_at** | *date-time* | when problem was created | `"2017-06-30T15:41:41.767+09:00"` |
| **id** | *integer* | unique identifier of problem | `1` |
| **image_url** | *string* | stored image url | `"/uploads/problem/image/1/20170609002537.jpg"` |
| **latitude** | *number* | latitude | `36.10830528664971` |
| **longitude** | *number* | longitude | `140.10114337330694` |
| **responded** | *boolean* | Indicate whether a reply is necessary | `true` |
| **responses_seen** | *boolean* | This indicates that it is a already read response | `true` |
| **thumbnail_url** | *string* | stored image url | `"/uploads/problem/image/1/20170609002537.jpg"` |
| **updated_at** | *date-time* | when problem was updated | `"2017-06-30T15:41:41.767+09:00"` |
| **user_id** | *integer* | user's id | `1` |

### <a name="link-POST-problem-/v1/problems">Problem Create</a>

困りごとを投稿するAPI　利用するにはアクセストークンをヘッダに付ける必要あり。

```
POST /v1/problems
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | problem's comment | `"SOX is difficult"` |
| **latitude** | *number* | latitude | `36.10830528664971` |
| **longitude** | *number* | longitude | `140.10114337330694` |


#### Curl Example

```bash
$ curl -n -X POST http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems \
  -d '{
  "comment": "SOX is difficult",
  "latitude": 36.10830528664971,
  "longitude": 140.10114337330694
}' \
  -H "Content-Type: application/json" \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "id": 1,
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/1/20170609002537.jpg",
  "thumbnail_url": "/uploads/problem/image/1/20170609002537.jpg",
  "latitude": 36.10830528664971,
  "longitude": 140.10114337330694,
  "user_id": 1,
  "responded": false,
  "responses_seen": true,
  "created_at": "2017-06-30T15:41:41.767+09:00",
  "updated_at": "2017-06-30T15:41:41.767+09:00"
}
```

### <a name="link-GET-problem-/v1/problems/me">Problem Me</a>

ログインしているユーザの投稿した困りごとを全件取得する(降順) クエリパラメータ(page,per)を指定することで取得する件数を変更できる (例：/v1/problems?page=2&per=3 １ページあたり３件ずつの２ページ目を取得する) (例：/v1/problems?page=1 このように、ページのみ指定した場合は1ページあたり5件取得） 利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /v1/problems/me
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **page** | *integer* | Parameter that specifies the page (for pagenation) | `1` |
| **per** | *integer* | Parameter that specifies the number of data per page | `5` |


#### Curl Example

```bash
$ curl -n http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/me \
 -G \
  -d page=1 \
  -d per=5 \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": 1,
    "comment": "SOX is difficult",
    "image_url": "/uploads/problem/image/1/20170609002537.jpg",
    "thumbnail_url": "/uploads/problem/image/1/20170609002537.jpg",
    "latitude": 36.10830528664971,
    "longitude": 140.10114337330694,
    "user_id": 1,
    "responded": true,
    "responses_seen": true,
    "created_at": "2017-06-30T15:41:41.767+09:00",
    "updated_at": "2017-06-30T15:41:41.767+09:00"
  }
]
```

### <a name="link-GET-problem-/v1/problems">Problem List</a>

投稿されている困りごとを全件取得する（全ユーザが対象, 降順） クエリパラメータ(page,per)を指定することで取得する件数を変更できる (例：/v1/problems?page=2&per=3 １ページあたり３件ずつの２ページ目を取得する) (例：/v1/problems?page=1 このように、ページのみ指定した場合は1ページあたり5件取得） 利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /v1/problems
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **page** | *integer* | Parameter that specifies the page (for pagenation) | `1` |
| **per** | *integer* | Parameter that specifies the number of data per page | `5` |


#### Curl Example

```bash
$ curl -n http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems \
 -G \
  -d page=1 \
  -d per=5 \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": 1,
    "comment": "SOX is difficult",
    "image_url": "/uploads/problem/image/1/20170609002537.jpg",
    "thumbnail_url": "/uploads/problem/image/1/20170609002537.jpg",
    "latitude": 36.10830528664971,
    "longitude": 140.10114337330694,
    "user_id": 1,
    "responded": true,
    "responses_seen": true,
    "created_at": "2017-06-30T15:41:41.767+09:00",
    "updated_at": "2017-06-30T15:41:41.767+09:00"
  }
]
```


