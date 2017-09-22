
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
| **japanese_comment** | *string* | japanese problem's comment(japanese) | `"SOXは難しい"` |
| **latitude** | *number* | latitude | `36.10830528664971` |
| **longitude** | *number* | longitude | `140.10114337330694` |
| **responded** | *boolean* | Indicate whether a reply is necessary | `true` |
| **responses_seen** | *boolean* | This indicates that it is a already read response | `true` |
| **thumbnail_url** | *string* | stored thumbnail url | `"/uploads/problem/image/1/thumb_20170609002537.jpg"` |
| **updated_at** | *date-time* | when problem was updated | `"2017-06-30T15:41:41.767+09:00"` |
| **user_id** | *integer* | user's id | `1` |

### <a name="link-POST-problem-/v1/problems">Problem Create</a>

困りごとを投稿するAPI　利用するにはアクセストークンをヘッダに付ける必要あり.

```
POST /v1/problems
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | problem's comment | `"SOX is difficult"` |
| **japanese_comment** | *string* | japanese problem's comment(japanese) | `"SOXは難しい"` |
| **latitude** | *number* | latitude | `36.10830528664971` |
| **longitude** | *number* | longitude | `140.10114337330694` |


#### Curl Example

```bash
$ curl -n -X POST https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems \
  -d '{
  "comment": "SOX is difficult",
  "japanese_comment": "SOXは難しい",
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
  "japanese_comment": "SOXは難しい",
  "image_url": "/uploads/problem/image/1/20170609002537.jpg",
  "thumbnail_url": "/uploads/problem/image/1/thumb_20170609002537.jpg",
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

ログインしているユーザの投稿した困りごとを全件取得する(降順). クエリパラメータ(page,per)を指定することで取得する件数を変更できる. (例：/v1/problems?page=2&per=3 １ページあたり３件ずつの２ページ目を取得する) (例：/v1/problems?page=1 このように、ページのみ指定した場合は1ページあたり5件取得） 利用するにはアクセストークンをヘッダに付ける必要あり.

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
$ curl -n https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/me \
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
    "japanese_comment": "SOXは難しい",
    "image_url": "/uploads/problem/image/1/20170609002537.jpg",
    "thumbnail_url": "/uploads/problem/image/1/thumb_20170609002537.jpg",
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

投稿されている困りごとを全件取得する（全ユーザが対象, 降順）. クエリパラメータ(page,per)を指定することで取得する件数を変更できる. (例：/v1/problems?page=2&per=3 １ページあたり３件ずつの２ページ目を取得する) (例：/v1/problems?page=1 このように、ページのみ指定した場合は1ページあたり5件取得） 利用するにはアクセストークンをヘッダに付ける必要あり.

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
$ curl -n https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems \
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
    "japanese_comment": "SOXは難しい",
    "image_url": "/uploads/problem/image/1/20170609002537.jpg",
    "thumbnail_url": "/uploads/problem/image/1/thumb_20170609002537.jpg",
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

### <a name="link-GET-problem-/v1/problems/{id}">Problem Show</a>

指定したidの困りごとを1件取得する.利用するにはアクセストークンをヘッダに付ける必要あり.

```
GET /v1/problems/{id}
```


#### Curl Example

```bash
$ curl -n https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$ID \
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
  "japanese_comment": "SOXは難しい",
  "image_url": "/uploads/problem/image/1/20170609002537.jpg",
  "thumbnail_url": "/uploads/problem/image/1/thumb_20170609002537.jpg",
  "latitude": 36.10830528664971,
  "longitude": 140.10114337330694,
  "user_id": 1,
  "responded": true,
  "responses_seen": true,
  "created_at": "2017-06-30T15:41:41.767+09:00",
  "updated_at": "2017-06-30T15:41:41.767+09:00"
}
```

### <a name="link-DELETE-problem-/v1/problems/{id}">Problem Destroy</a>

指定したidの困りごとを1件削除する.困りごとに関連した返信も一緒に削除される.利用するには、困りごとを投稿したユーザのアクセストークンをヘッダに付ける必要あり.

```
DELETE /v1/problems/{id}
```


#### Curl Example

```bash
$ curl -n -X DELETE https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$ID \
  -H "Content-Type: application/json" \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 202 Accepted
```



## <a name="resource-response">Response</a>

Stability: `prototype`

困りごとに対してコメントをする，コメントを閲覧するAPI

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | comment to the problem | `"We are in test"` |
| **id** | *integer* | unique identifier of response | `1` |
| **japanese_comment** | *string* | japanese reponse comment | `"私たちはテスト中です"` |
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
| **japanese_comment** | *string* | japanese reponse comment | `"私たちはテスト中です"` |


#### Curl Example

```bash
$ curl -n -X POST https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$PROBLEM_ID/responses \
  -d '{
  "comment": "We are in test",
  "japanese_comment": "私たちはテスト中です"
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
  "japanese_comment": "私たちはテスト中です",
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
$ curl -n https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$PROBLEM_ID/responses/ \
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
    "japanese_comment": "私たちはテスト中です",
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
$ curl -n -X PUT https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$PROBLEM_ID/responses/seen \
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
$ curl -n https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems/$PROBLEM_ID/responses/seen \
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
$ curl -n https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/responses/$ID \
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
  "japanese_comment": "私たちはテスト中です",
  "problem_id": 1,
  "user_id": 1
}
```

### <a name="link-DELETE-response-/v1/responses/{id}">Response Destory</a>

指定したidの返信コメントを1件削除する.利用するには、返信コメントを投稿したユーザ、もしくは困りごとを投稿したユーザのアクセストークンをヘッダに付ける必要あり.

```
DELETE /v1/responses/{id}
```


#### Curl Example

```bash
$ curl -n -X DELETE https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/responses/$ID \
  -H "Content-Type: application/json" \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 202 Accepted
```



## <a name="resource-session">Session</a>

Stability: `prototype`

ユーザのセッションを管理するAPI

### <a name="link-POST-session-/v1/login">Session Login</a>

あるユーザにログインするときのAPI

```
POST /v1/login
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *string* | unique email of user<br/> **pattern:** ` /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i` | `"test@example.com"` |
| **password** | *string* | password of user<br/> **pattern:** `within: 5..30` | `"example"` |


#### Curl Example

```bash
$ curl -n -X POST https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/login \
  -d '{
  "email": "test@example.com",
  "password": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "email": "test@example.com",
  "token_type": "Bearer",
  "user_id": 1,
  "access_token": "1:ABCDabcd"
}
```


## <a name="resource-user">User</a>

Stability: `prototype`

Userの情報，投稿などを管理するAPI

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **Authorization Key** | *string* | unique token for user | `"1:ABCDabcd"` |
| **age** | *integer* | age range of user | `20` |
| **country_of_residence** | *string* | country_of_residence of user | `"Japan"` |
| **device_token** | *string* | unique token for user's fcm device token | `"cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuBoQBOstB9stqo6I-z0Iv5M9fcbz3Zifib4ewcdznSRf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLTmTHCwMKVtGXx"` |
| **email** | *string* | unique email of user<br/> **pattern:** `([a-zA-Z0-9_]+[-.]*)+@[a-z0-9]+(.[a-z]+)+` | `"test.example@example.co.jp"` |
| **gender** | *string* | gender of user | `"male"` |
| **name** | *string* | unique name of user | `"Wataru Sakamoto"` |

### <a name="link-POST-user-/v1/users">User Create</a>

新たなユーザを作成するAPI

```
POST /v1/users
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *string* | unique email of user<br/> **pattern:** `([a-zA-Z0-9_]+[-.]*)+@[a-z0-9]+(.[a-z]+)+` | `"test.example@example.co.jp"` |
| **password** | *string* | password of user<br/> **pattern:** `.{6,29}` | `"example"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age range of user | `20` |
| **country_of_residence** | *string* | country_of_residence of user | `"Japan"` |
| **gender** | *string* | gender of user | `"male"` |
| **name** | *string* | unique name of user | `"Wataru Sakamoto"` |


#### Curl Example

```bash
$ curl -n -X POST https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users \
  -d '{
  "email": "test.example@example.co.jp",
  "password": "example",
  "name": "Wataru Sakamoto",
  "gender": "male",
  "age": 20,
  "country_of_residence": "Japan"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "email": "test.example@example.co.jp",
  "token_type": "Bearer",
  "user_id": 1,
  "access_token": "1:ABCDabcd"
}
```

### <a name="link-GET-user-/v1/users/me">User Me</a>

ログインした状態の自分の情報の一覧を取得する　利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /v1/users/me
```


#### Curl Example

```bash
$ curl -n https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users/me \
  -H "authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "Authorization Key": "1:ABCDabcd",
  "name": "Wataru Sakamoto",
  "gender": "male",
  "age": 20,
  "country_of_residence": "Japan",
  "email": "test.example@example.co.jp",
  "device_token": "cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuBoQBOstB9stqo6I-z0Iv5M9fcbz3Zifib4ewcdznSRf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLTmTHCwMKVtGXx"
}
```

### <a name="link-PUT-user-/v1/users/me/device_token">User DeviceToken Update</a>

自分のデバイストークンの情報を更新する　利用するにはアクセストークンをヘッダに付ける必要あり

```
PUT /v1/users/me/device_token
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **device_token** | *string* | unique token for user's fcm device token | `"cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuBoQBOstB9stqo6I-z0Iv5M9fcbz3Zifib4ewcdznSRf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLTmTHCwMKVtGXx"` |


#### Curl Example

```bash
$ curl -n -X PUT https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users/me/device_token \
  -d '{
  "device_token": "cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuBoQBOstB9stqo6I-z0Iv5M9fcbz3Zifib4ewcdznSRf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLTmTHCwMKVtGXx"
}' \
  -H "Content-Type: application/json" \
  -H "authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "device_token": "cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuBoQBOstB9stqo6I-z0Iv5M9fcbz3Zifib4ewcdznSRf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLTmTHCwMKVtGXx"
}
```


