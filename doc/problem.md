
## <a name="resource-problem">Problem</a>

Stability: `prototype`

FIXME

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | comment | `"SOX is difficult"` |
| **created_at** | *date-time* | when problem was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of problem | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **image** | *string* | image | `"image.jpg"` |
| **updated_at** | *date-time* | when problem was updated | `"2015-01-01T12:00:00Z"` |

### <a name="link-POST-problem-/problems">Problem Create</a>

Create a new problem.

```
POST /problems
```


#### Curl Example

```bash
$ curl -n -X POST /problems \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "comment": "SOX is difficult",
  "image": "image.jpg",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-DELETE-problem-/problems/{(%23%2Fdefinitions%2Fproblem%2Fdefinitions%2Fidentity)}">Problem Delete</a>

Delete an existing problem.

```
DELETE /problems/{problem_id}
```


#### Curl Example

```bash
$ curl -n -X DELETE /problems/$PROBLEM_ID \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "comment": "SOX is difficult",
  "image": "image.jpg",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-problem-/problems/{(%23%2Fdefinitions%2Fproblem%2Fdefinitions%2Fidentity)}">Problem Info</a>

Info for existing problem.

```
GET /problems/{problem_id}
```


#### Curl Example

```bash
$ curl -n /problems/$PROBLEM_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "comment": "SOX is difficult",
  "image": "image.jpg",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-problem-/problems">Problem List</a>

List existing problems.

```
GET /problems
```


#### Curl Example

```bash
$ curl -n /problems
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "created_at": "2015-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "comment": "SOX is difficult",
    "image": "image.jpg",
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### <a name="link-PATCH-problem-/problems/{(%23%2Fdefinitions%2Fproblem%2Fdefinitions%2Fidentity)}">Problem Update</a>

Update an existing problem.

```
PATCH /problems/{problem_id}
```


#### Curl Example

```bash
$ curl -n -X PATCH /problems/$PROBLEM_ID \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "comment": "SOX is difficult",
  "image": "image.jpg",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


