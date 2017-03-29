# Elastalert-docs

## Overview

Elastalert là một framework để cảnh báo sự thay đổi bất thường, đột ngột từ dữ liệu Elasticsearch.

Nó kết hợp với Elasticsearch theo 2 thành phần chính là `rule type` và `alert`

Elasticsearch được query định kỳ, sử dụng các rule để match các event mong muốn và đưa ra một hoặc nhiều cảnh báo - alert.

## Use case 

Tùy thuộc mục đích, ta có thể sử dụng các rule được xây dựng sẵn của Elastalert:

- `frequency` type : phù hợp với những sự kiện X trong thời gian Y
- `spike` type : phù hợp khi tỉ lệ các sự kiện X tăng hoặc giảm
- `flatline` type : phù hợp khi có ít hơn X sự kiện trong thời gian Y
- `blacklist`, `whitelist` type : phù hợp khi một trường xác định matched với một blacklist/whitelist
- `any` type : phù hợp với bất kỳ sự kiện nào matching với một filter nào đó
- `change` type : phù hợp khi một trường có 2 giá trị khác nhau trong một khoảng thời gian


Elastalert hỗ trợ alert theo nhiều hình thức khác nhau : 

- Command
- Email
- JIRA
- OpsGenie
- SNS
- HipChat
- Slack
- Telegram
- Debug
- Stomp


