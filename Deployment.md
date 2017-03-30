
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
	
Sửa tham số : 

- `es_host` : địa chỉ của Elasticsearch 

### Tạo index trong Elasticsearch

ElastAlert lưu thông tin và metadata về các truy vấn và các alert của nó về Elasticsearch. Điều này tiện cho audit, debug và cho phép ElastAlert khởi động lại đúng chỗ mà nó ngừng trước đó.

Điều này không yêu cầu nhưng khuyến khích sử dụng.

	# elastalert-create-index
	
### Tạo một rule 



