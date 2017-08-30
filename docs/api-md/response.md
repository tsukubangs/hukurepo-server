
## <a name="resource-response">Response</a>

Stability: `prototype`

困りごとに対してコメントをする，コメントを閲覧するAPI

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | comment to the problem | `"We are in test"` |
| **id** | *integer* | unique identifier of response | `1` |
| **problem_id** | *integer* | id of the problem | `1` |
| **user_id** | *integer* | id of the user who poseted the problem | `1` |

### <a name="link-POST-response-/v1/problems/{problem_id}/responses">Response Create</a>

困りごとに対してコメントを投稿するAPI, problem_idをURLに入れる必要がある. 利用するにはアクセストークンをヘッダに付ける必要あり．

```
POST /v1/problems/{problem_id}/responses
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | comment to the problem | `"We are in test"` |


#### Curl Example

```bash
$ curl -n -X POST http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$PROBLEM_ID/responses \
  -d '{
  "comment": "We are in test"
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
  "comment": "We are in test",
  "problem_id": 1,
  "user_id": 1
}
```

### <a name="link-GET-response-/v1/problems/{problem_id}/responses/">Response List</a>

困りごとに対応するコメントを取得するAPI.problem_idをURLに入れる必要がある. 利用するにはアクセストークンをヘッダに付ける必要あり.

```
GET /v1/problems/{problem_id}/responses/
```


#### Curl Example

```bash
$ curl -n http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$PROBLEM_ID/responses/ \
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
    "comment": "We are in test",
    "problem_id": 1,
    "user_id": 1
  }
]
```

### <a name="link-PUT-response-/v1/problems/{problem_id}/responses/seen">Response Seen Update</a>

困りごとに対応するコメントを読んだことを示すAPI. problem_idをURLに入れる必要がある. エンドポイントにアクセスすると既読になる.困りごとの投稿者以外のアクセスは受け付けない． 利用するにはアクセストークンをヘッダに付ける必要あり.

```
PUT /v1/problems/{problem_id}/responses/seen
```


#### Curl Example

```bash
$ curl -n -X PUT http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$PROBLEM_ID/responses/seen \
  -H "Content-Type: application/json" \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "seen": true
}
```

### <a name="link-GET-response-/v1/problems/{problem_id}/responses/seen">Response Seen Get</a>

困りごとに対応するコメントを読んだことを示すAPI.problem_idをURLに入れる必要がある. エンドポイントにアクセスすると既読フラグが取得できる. 利用するにはアクセストークンをヘッダに付ける必要あり.

```
GET /v1/problems/{problem_id}/responses/seen
```


#### Curl Example

```bash
$ curl -n http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$PROBLEM_ID/responses/seen \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "seen": true
}
```

### <a name="link-GET-response-/v1/responses/{id}">Response Show</a>

指定したidの返信コメントを1件取得する.利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /v1/responses/{id}
```


#### Curl Example

```bash
$ curl -n http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/responses/$ID \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 1,
  "comment": "We are in test",
  "problem_id": 1,
  "user_id": 1
}
```

### <a name="link-DELETE-response-/v1/responses/{id}">Response Destory</a>

指定したidの返信コメントを1件削除する.利用するには、困りごとを投稿したユーザのアクセストークンをヘッダに付ける必要あり.

```
DELETE /v1/responses/{id}
```


#### Curl Example

```bash
$ curl -n -X DELETE http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/responses/$ID \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 204 No Content
```
