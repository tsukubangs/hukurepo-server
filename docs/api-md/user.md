
## <a name="resource-user">User</a>

Stability: `prototype`

Userの情報，投稿などを管理するAPI

### <a name="link-POST-user-/v1/users">User Create</a>

新たなユーザを作成するAPI

```
POST /v1/users
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *string* | unique email of user<br/> **pattern:** ` /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i` | `"test@example.com"` |
| **password** | *string* | password of user<br/> **pattern:** `within: 5..30` | `"example"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age range of user | `20` |
| **gender** | *string* | gender of user | `"male"` |
| **name** | *string* | unique name of user | `"Wataru Sakamoto"` |
| **nationality** | *string* | nationality of user | `"Japan"` |


#### Curl Example

```bash
$ curl -n -X POST http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/users \
  -d '{
  "email": "test@example.com",
  "password": "example",
  "name": "Wataru Sakamoto",
  "gender": "male",
  "age": 20,
  "nationality": "Japan"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "email": "test@example.com",
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
  "email": "test@example.com",
  "password": "example",
  "name": "Wataru Sakamoto",
  "gender": "male",
  "age": 20,
  "nationality": "Japan"
}
```


