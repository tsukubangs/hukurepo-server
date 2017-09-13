
## <a name="resource-user">User</a>

Stability: `prototype`

Userの情報，投稿などを管理するAPI

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **Authorization Key** | *string* | unique token for user | `"1:ABCDabcd"` |
| **age** | *integer* | age range of user | `20` |
| **device_token** | *string* | unique token for user's fcm device token | `"cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuBoQBOstB9stqo6I-z0Iv5M9fcbz3Zifib4ewcdznSRf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLTmTHCwMKVtGXx"` |
| **email** | *string* | unique email of user<br/> **pattern:** `([a-zA-Z0-9_]+[-.]*)+@[a-z0-9]+(.[a-z]+)+` | `"test.example@example.co.jp"` |
| **gender** | *string* | gender of user | `"male"` |
| **name** | *string* | unique name of user | `"Wataru Sakamoto"` |
| **country_of_residence** | *string* | country_of_residence of user | `"Japan"` |

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
| **gender** | *string* | gender of user | `"male"` |
| **name** | *string* | unique name of user | `"Wataru Sakamoto"` |
| **country_of_residence** | *string* | country_of_residence of user | `"Japan"` |


#### Curl Example

```bash
$ curl -n -X POST http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users \
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
$ curl -n http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users/me \
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
$ curl -n -X PUT http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users/me/device_token \
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
