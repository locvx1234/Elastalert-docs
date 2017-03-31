
## Manual

### Install git

	# apt-get update
	# apt-get install git -y
	
### Clone the ElastAlert repository

	# git clone https://github.com/Yelp/elastalert.git
	
### Install the module

	# apt-get install python-pip -y
	# apt-get install python-dev -y
	# cd elastalert
	# pip install -r requirements.txt
	# python setup.py install
	
### Elasticsearch 5.0+:

	# pip install "elasticsearch>=5.0.0"
### Elasticsearch 2.X:

	# pip install "elasticsearch<3.0.0"

	
### Config 

	# cp config.yaml.example config.yaml
	# vi config.yaml
	
Thiết lập tham số : 

- `es_host` : địa chỉ của Elasticsearch 

### Tạo index trong Elasticsearch

ElastAlert lưu thông tin và metadata về các truy vấn và các alert của nó về Elasticsearch. Điều này tiện cho audit, debug và cho phép ElastAlert khởi động lại đúng chỗ mà nó ngừng trước đó.

Điều này không yêu cầu nhưng khuyến khích sử dụng.

	# elastalert-create-index
	
### Tạo một rule 

Ví dụ `any_rule.yaml`:

	# (Optional)
	# Elasticsearch host
	es_host: 192.168.169.136

	# (Optional)
	# Elasticsearch port
	es_port: 9200

	# (OptionaL) Connect with SSL to Elasticsearch
	use_ssl: False

	# (Optional) basic-auth username and password for Elasticsearch
	#es_username: someusername
	#es_password: somepassword

	# Rule name, must be unique
	name: ClamAV rule

	# (Required)
	# Type of alert.
	type: any

	# (Required)
	# Index to search, wildcard supported
	index: clamav-*

	summary_table_fields:
	  - value
	  - logsource

	filter:
	- bool:
		must_not:
		  - term:
			  value.keyword: "0"
		must:
		  - term:
			  content.keyword: "Infected files"

	# (Required)
	# The alert is use when a match is found
	alert:
	- "email"
	- "slack"
	
	# (required, email specific)
	# a list of email addresses to send alerts to
	email:
	- "locvx1234@gmail.com"

	slack_webhook_url:
	- "https://hooks.slack.com/services/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"
	
### Test file rule 

	# elastalert-test-rule example_rules/any_rule.yaml

### Running ElastAlert

	# python -m elastalert.elastalert --verbose --rule any_rule.yaml

## Script

