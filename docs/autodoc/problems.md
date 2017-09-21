## POST v1/problems
Creates problem.

### Example

#### Request
```
POST /v1/problems HTTP/1.1
Authorization: 1:_PfkK4MieymyVixQW8mv
Content-Type: multipart/form-data; boundary=----------XnJLe9ZIbbGUYtzPQJ16u1
Host: example.org

multipart/form-data
```

#### Response
```
HTTP/1.1 201
Content-Type: application/json; charset=utf-8
Location: https://example.org/v1/problems/1
Vary: Origin
X-Content-Type-Options: nosniff
X-Frame-Options: SAMEORIGIN

{
  "id": 1,
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/1/20170701170904.jpg",
  "latitude": 36.10830528664971,
  "longitude": 140.10114337330694,
  "user_id": 1,
  "created_at": "2017-07-01T17:09:04.178+09:00",
  "updated_at": "2017-07-01T17:09:04.178+09:00"
}
```

## GET /problems
Returns existing problems.

### Example

#### Request
```
GET /v1/problems HTTP/1.1
Authorization: 1:MhTzDTxuWH7zcvq2he-d
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
    "comment": "SOX is difficult",
    "image_url": "/uploads/problem/image/1/20170701170904.jpg",
    "latitude": 36.10830528664971,
    "longitude": 140.10114337330694,
    "user_id": 1,
    "created_at": "2017-07-01T17:09:04.750+09:00",
    "updated_at": "2017-07-01T17:09:04.750+09:00"
  },
  {
    "id": 2,
    "comment": "Where is Bus stop?",
    "image_url": "/uploads/problem/image/2/20170701170904.jpg",
    "latitude": 36.10830528664373,
    "longitude": 140.1011433733031,
    "user_id": 2,
    "created_at": "2017-07-01T17:09:04.904+09:00",
    "updated_at": "2017-07-01T17:09:04.904+09:00"
  }
]
```

## GET /problems/:id
Returns exisiting problem.

### Example

#### Request
```
GET /v1/problems/1 HTTP/1.1
Authorization: 1:mFNtBDo-4NMTjHyVyMpE
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
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/1/20170701170905.jpg",
  "latitude": 36.10830528664971,
  "longitude": 140.10114337330694,
  "user_id": 1,
  "created_at": "2017-07-01T17:09:05.277+09:00",
  "updated_at": "2017-07-01T17:09:05.277+09:00"
}
```

## GET /problems/:id
Returns 404 if user does not exist.

### Example

#### Request
```
GET /v1/problems/-1 HTTP/1.1
Authorization: 1:z6xMSVU2LNBT8DY9Tym1
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
  "error": "Couldn't find Problem with 'id'=-1"
}
```

## GET /problems/me
Returns first_users problem.

### Example

#### Request
```
GET /v1/problems/me HTTP/1.1
Authorization: 1:dKqXv3hKU4tE7X4jtvak
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
    "comment": "SOX is difficult",
    "image_url": "/uploads/problem/image/1/20170701170906.jpg",
    "latitude": 36.10830528664971,
    "longitude": 140.10114337330694,
    "user_id": 1,
    "created_at": "2017-07-01T17:09:06.039+09:00",
    "updated_at": "2017-07-01T17:09:06.039+09:00"
  },
  {
    "id": 3,
    "comment": "Bicycle is too many!!!",
    "image_url": "/uploads/problem/image/3/20170701170906.jpg",
    "latitude": 36.1181461,
    "longitude": 140.0903428,
    "user_id": 1,
    "created_at": "2017-07-01T17:09:06.234+09:00",
    "updated_at": "2017-07-01T17:09:06.234+09:00"
  }
]
```
