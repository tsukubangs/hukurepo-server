## POST v1/problems
Returns authorization error(401).

### Example

#### Request
```
POST /v1/problems HTTP/1.1
Content-Type: multipart/form-data; boundary=----------XnJLe9ZIbbGUYtzPQJ16u1
Host: example.org

multipart/form-data
```

#### Response
```
HTTP/1.1 401
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "You need to sign in or sign up before continuing."
}
```

## GET /problems
Returns authorization error(401).

### Example

#### Request
```
GET /v1/problems HTTP/1.1
Host: example.org
```

#### Response
```
HTTP/1.1 401
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "You need to sign in or sign up before continuing."
}
```

## GET /problems/:id
Returns authorization error(401).

### Example

#### Request
```
GET /v1/problems/1 HTTP/1.1
Host: example.org
```

#### Response
```
HTTP/1.1 401
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "You need to sign in or sign up before continuing."
}
```

## GET /problems/me
Returns authorization error(401).

### Example

#### Request
```
GET /v1/problems/me HTTP/1.1
Host: example.org
```

#### Response
```
HTTP/1.1 401
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "You need to sign in or sign up before continuing."
}
```

## GET /users
Returns authorization error(401).

### Example

#### Request
```
GET /v1/users HTTP/1.1
Host: example.org
```

#### Response
```
HTTP/1.1 401
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "You need to sign in or sign up before continuing."
}
```

## GET /users/:id
Returns authorization error(401).

### Example

#### Request
```
GET /v1/users/1 HTTP/1.1
Host: example.org
```

#### Response
```
HTTP/1.1 401
Content-Type: application/json; charset=utf-8
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "error": "You need to sign in or sign up before continuing."
}
```
