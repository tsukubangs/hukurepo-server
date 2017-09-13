## POST v1/users
Creates user.

### Example

#### Request
```
POST /v1/users HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Host: example.org

user[email]=kaname%40kaname.co.jp&user[password]=kaname&user[country_of_residence]=Japan&user[gender]=male&user[age]=20
```

#### Response
```
HTTP/1.1 201
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "email": "kaname@kaname.co.jp",
  "token_type": "Bearer",
  "user_id": 1,
  "access_token": "1:YXXdF8h_s7fifimHKVbU"
}
```

## GET v1/users
Returns valid accesstoken.

### Example

#### Request
```
GET /v1/users/me HTTP/1.1
Authorization: 1:m_-xzmgzsy-yX-H5vj6_
Host: example.org
```

#### Response
```
HTTP/1.1 500
Content-Type: application/json; charset=utf-8
Vary: Origin

{
  "id": "invalid_response_type",
  "message": "#/name: failed schema #/definitions/user/links/1/targetSchema/properties/name: For 'properties/name', nil is not a string."
}
```

## POST v1/users
Returns 422(unprocessable entity) if email has been already registered.

### Example

#### Request
```
POST /v1/users HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Host: example.org

user[email]=kaname%40kaname.co.jp&user[password]=kaname&user[country_of_residence]=Japan&user[gender]=male&user[age]=20
```

#### Response
```
HTTP/1.1 422
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "Validation failed: Email has already been taken"
}
```

## POST v1/users
Returns 422(unprocessable entity) if email as invalid.

### Example

#### Request
```
POST /v1/users HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Host: example.org

user[email]=email%40email&user[password]=kaname&user[country_of_residence]=Japan&user[gender]=male&user[age]=20
```

#### Response
```
HTTP/1.1 422
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "Validation failed: Email is invalid"
}
```

## POST v1/users
Returns 422(unprocessable entity) if the password is too short (under 6).

### Example

#### Request
```
POST /v1/users HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Host: example.org

user[email]=kaname%40kaname.co.jp&user[password]=kanam&user[country_of_residence]=Japan&user[gender]=male&user[age]=20
```

#### Response
```
HTTP/1.1 422
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "Validation failed: Password is too short (minimum is 6 characters)"
}
```

## POST v1/users
Returns 422(unprocessable entity) if password is too long(above 29).

### Example

#### Request
```
POST /v1/users HTTP/1.1
Content-Type: application/x-www-form-urlencoded
Host: example.org

user[email]=kaname%40kaname.co.jp&user[password]=kanamekanamekanamekanamekanamekanamekanamekanamekanamekaname&user[country_of_residence]=Japan&user[gender]=male&user[age]=20
```

#### Response
```
HTTP/1.1 422
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "Validation failed: Password is too long (maximum is 30 characters)"
}
```

## GET /users
Returns existing users.

### Example

#### Request
```
GET /v1/users HTTP/1.1
Authorization: 1:nX1Hsx3-QXTrsdoHUdZa
Host: example.org
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

[
  {
    "id": 1,
    "email": "kaname@kaname.co.jp",
    "name": null,
    "gender": "male",
    "age": 20,
    "country_of_residence": "Japan",
    "image": null,
    "created_at": "2017-07-01T17:09:06.823+09:00",
    "updated_at": "2017-07-01T17:09:06.851+09:00"
  },
  {
    "id": 2,
    "email": "tama@tama.co.jp",
    "name": null,
    "gender": "female",
    "age": 50,
    "country_of_residence": "Japan",
    "image": null,
    "created_at": "2017-07-01T17:09:06.839+09:00",
    "updated_at": "2017-07-01T17:09:06.839+09:00"
  }
]
```

## GET /users/:id
Returns exisiting user.

### Example

#### Request
```
GET /v1/users/1 HTTP/1.1
Authorization: 1:-oKETd4Fw2sQszc4PXuz
Host: example.org
```

#### Response
```
HTTP/1.1 200
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "id": 1,
  "email": "kaname@kaname.co.jp",
  "name": null,
  "gender": "male",
  "age": 20,
  "country_of_residence": "Japan",
  "image": null,
  "created_at": "2017-07-01T17:09:06.966+09:00",
  "updated_at": "2017-07-01T17:09:07.021+09:00"
}
```

## GET /users/:id
Returns 404 if problem does not exist.

### Example

#### Request
```
GET /v1/users/-1 HTTP/1.1
Authorization: 1:qe58tZUor1QkShza1enb
Host: example.org
```

#### Response
```
HTTP/1.1 404
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "Couldn't find User with 'id'=-1"
}
```
