
## <a name="resource-user">User</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **Authorization Key** | *string* | Authozation Key | `"example"` |

### <a name="link-POST-user-/v1/users">User </a>

Create a new user.

```
POST /v1/users
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **email** | *string* | unique email of user | `"test@example.com"` |
| **password** | *string* | passwordof user | `"example"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age range of user | `"20"` |
| **gender** | *string* | gender of user | `"male"` |
| **image** | *string* | image of the user | `"image.jp"` |
| **name** | *string* | unique name of user | `"Wataru Sakamoto"` |
| **nationality** | *string* | nationality of user | `"Japan"` |


#### Curl Example

```bash
$ curl -n -X POST /v1/users \
  -d '{
  "email": "test@example.com",
  "password": "example",
  "name": "Wataru Sakamoto",
  "gender": "male",
  "age": "20",
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
  "user_id": "18",
  "access_token": "example"
}
```

### <a name="link-GET-user-/v1/users/me">User </a>

Get information of login user.

```
GET /v1/users/me
```


#### Curl Example

```bash
$ curl -n /v1/users/me \
  -H "authorization: EXAMPLE-HEADER"
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
  "age": "20",
  "nationality": "Japan",
  "image": "image.jp"
}
```


