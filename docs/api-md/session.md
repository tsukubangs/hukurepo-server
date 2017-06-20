
## <a name="resource-session">Session</a>

Stability: `prototype`

ユーザのセッションを管理するAPI

### <a name="link-POST-session-/login">Session Login</a>

あるユーザにログインするときのAPI　アクセストークンが必要

```
POST /login
```


#### Curl Example

```bash
$ curl -n -X POST /login \
  -H "Content-Type: application/json" \
  -H "authorization: 1:ABCDabcd"
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
  "access_token": "example"
}
```


