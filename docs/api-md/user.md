
## <a name="resource-user">User</a>

Stability: `prototype`

Userの情報，投稿などを管理するAPI

### <a name="link-POST-user-/users">User </a>

新たなユーザを作成するAPI

```
POST /users
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *string* | unique email of user | `"test@example.com"` |
| **password** | *string* | password of user | `"example"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age range of user | `20` |
| **gender** | *string* | gender of user | `"male"` |
| **image** | *string* | image of the user | `"image.jp"` |
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
  "nationality": "Japan",
  "image": "image.jp"
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

### <a name="link-GET-user-/users/me">User </a>

ログインした状態の自分の情報の一覧を取得する　利用するにはアクセストークンをヘッダに付ける必要あり

```
GET /users/me
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
  "nationality": "Japan",
  "image": "image.jp"
}
```


