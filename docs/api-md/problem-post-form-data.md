### <a name="link-POST-problem-/problems">Problem Create (form-data形式)</a>

困りごとを投稿するAPI　利用するにはアクセストークンをヘッダに付ける必要あり。

```
POST /problems
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **problem[comment]** | *string* | problem's comment | `"SOX is difficult"` |
| **problem[image]** | *file* | upload image | `@path/image.jpg;type:image/jpg` |
| **problem[latitude]** | *number* | latitude | `36.10830528664971` |
| **problem[longitude]** | *number* | longitude | `140.10114337330694` |


#### Curl Example

```bash
$ curl -n -X POST http://bigclout-api.kde.cs.tsukuba.ac.jp/v1/problems \
  -F 'problem[comment]="SOX is difficult"'\
  -F 'problem[image]=@path/image.jpg;type=image/jpg'\
  -F 'problem[latitude]=36.10830528664971'\
  -F 'problem[longitude]=140.1011433733069'\
  -H "Authorization: 1:ABCDabcd"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "id": 1,
  "comment": "SOX is difficult",
  "image_url": "/uploads/problem/image/1/20170609002537.jp",
  "latitude": 36.10830528664971,
  "longitude": 140.10114337330694,
  "user_id": 1,
  "responded": false,
  "responses_seen": true,
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```
