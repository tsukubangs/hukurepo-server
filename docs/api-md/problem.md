
## <a name="resource-problem">Problem</a>

Stability: `prototype`

外国人訪問者の困りごとを投稿，閲覧するAPI

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | problem's comment | `"SOX is difficult"` |
| **created_at** | *date-time* | when problem was created | `"2015-01-01T12:00:00Z"` |
| **id** | *integer* | unique identifier of problem | `1` |
| **image_url** | *string* | stored image url | `"/uploads/problem/image/:id/image-name.jpg"` |
| **latitude** | *number* | latitude | `12.345` |
| **longitude** | *number* | longitude | `67.89` |
| **updated_at** | *date-time* | when problem was updated | `"2015-01-01T12:00:00Z"` |
| **user_id** | *integer* | user's id | `1` |

### <a name="link-POST-problem-/problems">Problem Create</a>

困りごとを投稿するAPI　利用するにはアクセストークンをヘッダに付ける必要あり。

```
POST /problems
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | problem's comment | `"SOX is difficult"` |
| **image_url** | *string* | stored image url | `"/uploads/problem/image/:id/image-name.jpg"` |
| **latitude** | *number* | latitude | `12.345` |
| **longitude** | *number* | longitude | `67.89` |


#### Curl Example

```bash
$ curl -n -X POST http://api.acroquest.work/v1/problems \
  -d '{
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/:id/image-name.jpg",
  "latitude": 12.345,
  "longitude": 67.89
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
  "image_url": "/uploads/problem/image/:id/image-name.jpg",
  "latitude": 12.345,
  "longitude": 67.89,
  "user_id": 1,
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-problem-/problems/me">Problem Me</a>

ログインしているユーザの投稿した困りごと一覧を取得する 利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /problems/me
```


#### Curl Example

```bash
$ curl -n http://api.acroquest.work/v1/problems/me \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 1,
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/:id/image-name.jpg",
  "latitude": 12.345,
  "longitude": 67.89,
  "user_id": 1,
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-problem-/problems">Problem List</a>

困りごとの一覧を取得する（全ユーザが対象）利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /problems
```


#### Curl Example

```bash
$ curl -n http://api.acroquest.work/v1/problems \
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
    "image_url": "/uploads/problem/image/:id/image-name.jpg",
    "latitude": 12.345,
    "longitude": 67.89,
    "user_id": 1,
    "created_at": "2015-01-01T12:00:00Z",
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```


