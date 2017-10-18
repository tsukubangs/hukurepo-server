
## <a name="resource-user">User</a>

Stability: `prototype`

Userの情報，投稿などを管理するAPI

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age range of user | `20` |
| **country_of_residence** | *string* | country_of_residence of user | `"Japan"` |
| **created_at** | *date-time* | when user was created | `"2017-06-30T15:41:41.767+09:00"` |
| **gender** | *string* | gender of user | `"male"` |
| **role** | *string* | role of user | `"poster"` |
| **updated_at** | *date-time* | when user was updated | `"2017-06-30T15:41:41.767+09:00"` |

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
| **role** | *string* | role of user | `"poster"` |


#### Curl Example

```bash
$ curl -n -X POST https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users \
  -d '{
  "email": "test.example@example.co.jp",
  "password": "example",
  "gender": "male",
  "age": 20,
  "country_of_residence": "Japan",
  "role": "poster"
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
  "user_id": 1,
  "gender": "male",
  "age": 20,
  "country_of_residence": "Japan",
  "role": "poster",
  "created_at": "2017-06-30T15:41:41.767+09:00",
  "updated_at": "2017-06-30T15:41:41.767+09:00",
  "email": "test.example@example.co.jp"
}
```

### <a name="link-PUT-user-/v1/users/me/device_token">User DeviceToken Update</a>

自分のデバイストークンの情報を更新する(PUT/PATCHどちらでも可)．device_tokenのみがパラメータに含まれているときは、device_tokenのみを更新する. roleのみの更新はこのエンドポイントではできない．roleは"poster", "respondent"のみ受け付ける. それ以外の値をroleに格納すると、HTTPステータス422を返す．利用するにはアクセストークンをヘッダに付ける必要あり

```
PUT /v1/users/me/device_token
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **device_token** | *string* | unique token for user's fcm device token | `"cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuqoGBOssBastqo6I-z0Iv7M9fczz3Zifib43dcezaSqf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLSdTHCwMKVtGXx"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **role** | *string* | role of user | `"poster"` |


#### Curl Example

```bash
$ curl -n -X PUT https://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users/me/device_token \
  -d '{
  "role": "poster",
  "device_token": "cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuqoGBOssBastqo6I-z0Iv7M9fczz3Zifib43dcezaSqf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLSdTHCwMKVtGXx"
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
  "role": "poster",
  "device_token": "cHCy7-HAA:APA91bHtkXlUuCwEWJFREIOxTSEgoO41GwNZn0GuqoGBOssBastqo6I-z0Iv7M9fczz3Zifib43dcezaSqf6CqiCGI7wEmaOjmBIsZQaO5hY12LLz-A74FjaZtfVRyLSdTHCwMKVtGXx"
}
```


