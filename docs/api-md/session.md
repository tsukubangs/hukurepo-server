
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
$ curl -n -X POST http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/login \
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


