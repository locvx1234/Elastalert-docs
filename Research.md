# Các nội dung chính 

[1. Các tham số trong file config](#config)

[2. Các loại rule và cấu hình tùy chọn ](#rule)

[3. Viết filter cho rule ](#filter)


<a name="config"></a>
## Các tham số trong file config (`config.yaml`)

`rules_folder` : folder chứa file cấu hình. Elastalert sẽ load các file .yaml từ thư mục này.

`run_every` : khoảng thời gian Elastalert sẽ truy vấn Elasticsearch

`es_host` : địa chỉ Elasticsearch cluster

`es_port` : port của `es_host`

`use_ssl` : (optional) Sử dụng TLS, đặt là `True` hoặc `False`

`verify_certs` : (optional) xác nhận TLS certificate đặt là `True` hoặc `False`, mặc định là `True`

`es_username` : (optional) xác thực username kết nối vào Elasticsearch

`es_password` : (optional) xác thực password kết nối vào Elasticsearch

`es_url_prefix` : (optional)

`es_send_get_body_as` : (optional) phương thức truy vấn Elasticsearch - `GET`, `POST` hoặc `source`. Mặc định là `GET`

`writeback_index` : tên index Elastalert sẽ lưu trữ dữ liệu

`alert_time_limit` : thời gian cửa sổ gửi cảnh báo không thành công

<a name="rule"></a>
## Các loại rule và cấu hình tùy chọn 

NOTE : Tất cả các "time" theo dạng: `unit: X`. Unit là một trong các loại weeks, days, hours, minutes hoặc seconds.

Ví dụ : `minutes: 15`, `hours: 1`

Các file rule mẫu xem trong folder `example_rules`

Các tham số và kiểu giá trị tương ứng, [xem thêm ... ](https://elastalert.readthedocs.io/en/latest/ruletypes.html#rule-configuration-cheat-sheet)

#### Các tùy chọn cấu hình chung 

###### Required: 

`es_host` : hostname của Elasticsearch cluster

`es_port` : port của Elasticsearch cluster 

`index` : tên index cần tìm kiếm. Wildcard có thể được áp dụng. Bạn có thể sử dụng dạng string chứa `%Y` cho year, `%m` cho month, `%d` cho day. Để sử dụng được điều này, bạn phải đặt `use_strftime_index` là true .

`name` : tên của rule, tên phải là duy nhất trong các rule

`type` :  [`RuleType`](#RuleType) được sử dụng. Sử dụng các `RuleType` được xây dựng sẵn hoặc load từ module

`alert` : [`Alerts`](#Alerts) được sử dụng. Nó có thể là một hoặc nhiều alerter được xây dựng sẵn hoặc load từ module

###### Optional

[See more ...](https://elastalert.readthedocs.io/en/latest/ruletypes.html#optional-settings)

#### Test file rule 
	
	$ elastalert-test-rule example_rules/example_frequency.yaml

Nếu không có thêm đối số nào, nó sẽ chạy ElastAlert trong 24h trước, và in ra bất kỳ cảnh báo nào có thể xảy ra. 

Xác định sử dụng một file config khác, thêm option `config` 

	$ elastalert-test-rule –config <path-to-config-file> example_rules/example_frequency.yaml
	

<a name="RuleType"></a>
#### Rule Types 

Class `RuleType` được định nghĩa trong `elastalert/ruletypes.py.

Cú pháp 

`type: <rule type>`

###### Any

`any` : any rule sẽ match mọi thứ. Để lấy những dữ liệu cần thiết, ta phải tạo filter cho nó

###### Blacklist 

`blacklist` : Blacklist rule sẽ kiểm tra một trường xác định và match nếu nó có trong blacklist.

Rule này yêu cầu thêm 2 option :

`compare_key` : tên trường sử dụng để so sánh với blacklist. Nếu trường này null, sự kiện đó sẽ bị bỏ qua

`blacklist` : một danh sách các giá trị blacklist

###### Whitelist

`whitelist` : tương tự `blacklist`,  rule này sẽ kiểm tra một trường xác định và match nếu nó không có trong `whitelist`

Rule này yêu cầu thêm 3 option :

`compare_key` : tên trường sử dụng để so sánh với whitelist

`ignore_null` : nếu true, các sự kiện không có `compare_key` sẽ không match 

`whitelist` : một danh sách các giá trị whitelist

###### Change

`change` : rule này sẽ giám sát một trường xác định và match nếu trường đó thay đổi. 

Rule này yêu cầu thêm 3 option :

`compare_key` : tên của trường để giám sát sự thay đổi 

`ignore_null` : nếu true, sự kiện không có trường `compare_key` sẽ không được tính là thay đổi

`query_key` : rule này được áp dụng trên mỗi `query_key`, trường này phải có trong tất cả các sự kiện được kiểm tra

Một trường option : 

`timeframe` : Thời gian maximum giữa các thay đổi. Sau khoảng thời gian này, Elastalert sẽ bỏ qua những giá trị cũ của trường `compare_key`

###### Frequency

File cấu hình có sẵn : `example_rules/example_frequency.yaml`

`frequency` : rule này sẽ match khi có ít nhất một số sự kiện nhất định trong một frame thời gian được đưa ra.  

Rule này yêu cầu thêm 2 option :

`num_events` : số sự kiện sẽ kích hoạt cảnh báo 

`timeframe` : thời gian `num_events` phải xảy ra 

###### Các rule xây dựng sẵn khác 

Spike

Flatline

New Term

Cardinality

Metric Aggregation


<a name="Alerts"></a>
#### Alerts 

Mỗi rule có thể có một số alert đi kèm. Để set alert cho một rule, đặt tên của alert, hoặc một list tên alert

Ví dụ 

	alert: email
	
hoặc 

	alert:
	- email
	- jira

	
Tiêu đề alert có thể sửa đổi bằng `alert_subject`

	alert_subject: "Virus detection !"
	
###### Email 

Alert sẽ gửi tới một email. Nó kết nối tới một smtp server được thiết lập bằng `stmp_host` hoặc mặc định là localhost. 

Alert này cần thêm 1 option:

`email` : Một địa chỉ email hoặc một list email nhận alert 



###### Slack 

Slack alerter sẽ gửi thông báo về channel Slack. Định dạng alert gửi về giống các loại alert khác.

Alerter này cần một option: 

`slack_webhook_url` : url webhook để xác định channel muốn nhận alert. Truy cập https://XXXXX.slack.com/services/new/incoming-webhook và chọn channel bằng cách click 'Add Incoming Webhooks Integration'. Copy URL và đặt vào làm giá trị cho đối số này.


###### Một số các alert khác 

[See more ...](https://elastalert.readthedocs.io/en/latest/ruletypes.html#alerts)

<a name="filter"></a>
## Viết filter cho rule 

Filter sử dụng các rule dựa trên [ Elasticsearch query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)

#### Các loại filter chung 

###### query_string

	filter:
	- query:
		query_string:
		  query: "username: bob"
	- query:
		query_string:
		  query: "_type: login_logs"
	- query:
		query_string:
		  query: "field: value OR otherfield: othervalue"
	- query:
		query_string:
		   query: "this: that AND these: those"


###### term

	filter:
	- term:
		name_field: "bob"
	- term:
		_type: "login_logs"		   
		
		
###### terms

Kết hợp nhiều term filter 

	filter:
	- terms:
		field: ["value1", "value2"]
		
###### wildcard

		filter:
	- query:
		wildcard:
		  field: "foo*bar"		
	
###### range

	filter:
	- range:
		status_code:
		  from: 500
		  to: 599


###### Negation, and, or

	filter:
	- or:
		- term:
			field: "value"
		- wildcard:
			field: "foo*bar"
		- and:
			- not:
				term:
				  field: "value"
			- not:
				term:
				  _type: "something"

Cú pháp query đối với Elastic 5.0 trở đi có sự [thay đổi](https://www.elastic.co/guide/en/elasticsearch/reference/current/breaking_50_search_changes.html#_deprecated_queries_removed)
		
Với truy vấn bool : https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-bool-query.html 
		