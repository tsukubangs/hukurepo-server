
## <a name="resource-test">Test</a>

Stability: `prototype`

ここにAPIの簡単な説明を書く

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when test was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of test | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of test | `"kaname takahashi"` |
| **updated_at** | *date-time* | when test was updated | `"2015-01-01T12:00:00Z"` |

### <a name="link-POST-test-/tests">Test Create</a>

Create a new test.

```
POST /tests
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *uuid* | unique identifier of test | `"01234567-89ab-cdef-0123-456789abcdef"` |


#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **name** | *string* | unique name of test | `"kaname takahashi"` |


#### Curl Example

```bash
$ curl -n -X POST https://api.acroquest.work/v1/tests \
  -d '{
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "kaname takahashi"
}' \
  -H "Content-Type: application/json" \
  -H "Authorization: token_sample" \
  -H "other-header: hogehoge"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "kaname takahashi",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-test-/tests/{(%23%2Fdefinitions%2Ftest%2Fdefinitions%2Fidentity)}">Test Info</a>

Info for existing test.

```
GET /tests/{test_id}
```


#### Curl Example

```bash
$ curl -n https://api.acroquest.work/v1/tests/$TEST_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": "01234567-89ab-cdef-0123-456789abcdef"
}
```

### <a name="link-GET-test-/tests">Test List</a>

List existing tests.

```
GET /tests
```


#### Curl Example

```bash
$ curl -n https://api.acroquest.work/v1/tests
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "kaname takahashi"
  }
]
```

### <a name="link-DELETE-test-/tests/{(%23%2Fdefinitions%2Ftest%2Fdefinitions%2Fidentity)}">Test Delete</a>

Delete an existing test.

```
DELETE /tests/{test_id}
```


#### Curl Example

```bash
$ curl -n -X DELETE https://api.acroquest.work/v1/tests/$TEST_ID \
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
  "name": "kaname takahashi",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-GET-test-/tests/{(%23%2Fdefinitions%2Ftest%2Fdefinitions%2Fidentity)}">Test Info</a>

Info for existing test.

```
GET /tests/{test_id}
```


#### Curl Example

```bash
$ curl -n https://api.acroquest.work/v1/tests/$TEST_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "kaname takahashi",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-PATCH-test-/tests/{(%23%2Fdefinitions%2Ftest%2Fdefinitions%2Fidentity)}">Test Update</a>

Update an existing test.

```
PATCH /tests/{test_id}
```


#### Curl Example

```bash
$ curl -n -X PATCH https://api.acroquest.work/v1/tests/$TEST_ID \
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
  "name": "kaname takahashi",
  "updated_at": "2015-01-01T12:00:00Z"
}
```
