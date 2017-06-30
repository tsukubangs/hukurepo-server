
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
  "latitude": 36.10830528664971,
  "longitude": 140.10114337330694,
  "user_id": 1,
  "created_at": "2017-06-30T15:41:41.767+09:00",
  "updated_at": "2017-06-30T15:41:41.767+09:00"
}
```

### <a name="link-GET-problem-/v1/problems/me">Problem Me</a>

ログインしているユーザの投稿した困りごと一覧を取得する 利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /v1/problems/me
```


#### Curl Example

```bash
$ curl -n http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/me \
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
    "latitude": 36.10830528664971,
    "longitude": 140.10114337330694,
    "user_id": 1,
    "created_at": "2017-06-30T15:41:41.767+09:00",
    "updated_at": "2017-06-30T15:41:41.767+09:00"
  }
]
```

### <a name="link-GET-problem-/v1/problems">Problem List</a>

困りごとの一覧を取得する（全ユーザが対象）利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /v1/problems
```


#### Curl Example

```bash
$ curl -n http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems \
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
    "latitude": 36.10830528664971,
    "longitude": 140.10114337330694,
    "user_id": 1,
    "created_at": "2017-06-30T15:41:41.767+09:00",
    "updated_at": "2017-06-30T15:41:41.767+09:00"
  }
]
```


