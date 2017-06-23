
## <a name="resource-response">Response</a>

Stability: `prototype`

困りごとに対してコメントをする，コメントを閲覧するAPI

### <a name="link-POST-response-problems/PROBLEM_ID/responses">Response Create</a>

困りごとに対してコメントを投稿するAPI, PROBLEM_IDをURLに入れる必要がある. 利用するにはアクセストークンをヘッダに付ける必要あり．

```
POST problems/PROBLEM_ID/responses
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **comment** | *string* | comment to the problem | `"We are in test"` |
| **problem_id** | *integer* | id of the problem | `1` |
| **user_id** | *integer* | id of the user who poseted the problem | `1` |


#### Curl Example

```bash
$ curl -n -X POST http://bigclout-api.kde.cs.tsukuba.ac.jp/v1problems/PROBLEM_ID/responses \
  -d '{
  "comment": "We are in test",
  "problem_id": 1,
  "user_id": 1
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
  "id": 1,
  "comment": "We are in test",
  "problem_id": 1,
  "user_id": 1
}
```


