
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


## Các loại rule và cấu hình tùy chọn 

NOTE : Tất cả các "time" theo dạng: `unit: X`. Unit là một trong các loại weeks, days, hours, minutes hoặc seconds.

Ví dụ : `minutes: 15`, `hours: 1`

Các file rule mẫu xem trong folder `example_rules`

Các tham số và kiểu giá trị tương ứng, [xem thêm ... ](https://elastalert.readthedocs.io/en/latest/ruletypes.html#rule-configuration-cheat-sheet)

#### Các tùy chọn cấu hình chung 

Required: 

`es_host` : hostname của Elasticsearch cluster

`es_port` : port của Elasticsearch cluster 

`index` : tên index cần tìm kiếm. Wildcard có thể được áp dụng. Bạn có thể sử dụng dạng string chứa `%Y`, +
--------------------------------------------------------------------------------------------------------------------------------------
 