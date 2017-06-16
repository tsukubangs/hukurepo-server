
## <a name="resource-problem">Problem</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **access_token** | *string* | access token | `"1:ABCDabcd"` |

### <a name="link-POST-problem-/problems">Problem Create</a>

Create a new problem.

```
POST /problems
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | problem's comment | `"SOX is difficult"` |
| **image_url** | *string* | stored image url | `"/uploads/problem/image/:id/image-name.jpg"` |
| **latitude** | *number* | latitude | `12.345` |
| **longitude** | *number* | longitude | `67.89` |


#### Curl Example

```bash
$ curl -n -X POST http://api.acroquest.work/v1/problems \
  -d '{
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/:id/image-name.jpg",
  "latitude": 12.345,
  "longitude": 67.89
}' \
  -H "Content-Type: application/json" \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "id": 42,
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/:id/image-name.jpg",
  "latitude": 12.345,
  "longitude": 67.89,
  "use_id": 1,
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-problem-/problems/me">Problem Me</a>

Get for existing user's problem.

```
GET /problems/me
```


#### Curl Example

```bash
$ curl -n http://api.acroquest.work/v1/problems/me \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 42,
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/:id/image-name.jpg",
  "latitude": 12.345,
  "longitude": 67.89,
  "use_id": 1,
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-problem-/problems">Problem List</a>

Get list existing problems.

```
GET /problems
```


#### Curl Example

```bash
$ curl -n http://api.acroquest.work/v1/problems \
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": 42,
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/:id/image-name.jpg",
  "latitude": 12.345,
  "longitude": 67.89,
  "use_id": 1,
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


