
## <a name="resource-session">Session</a>

Stability: `prototype`

FIXME

### <a name="link-POST-session-/login">Session Login</a>

Login to a specific user.

```
POST /login
```


#### Curl Example

```bash
$ curl -n -X POST /login \
  -H "Content-Type: application/json" \
  -H "authorization: EXAMPLE-HEADER"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "email": "test@example.com",
  "token_type": "Bearer",
  "user_id": "18",
  "access_token": "example"
}
```


