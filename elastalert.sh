#!bin/bash

# Install ELastAlert 
# Date : 31/03/2017

[ $(id -u) -eq 0 ] || { echo "$0: Only root may run this script."; exit 1;}


apt-get update

git --version  &> /dev/null
if test $? -ne 0
then
    echo "Installing Git ..." 
	apt-get install git -y
fi

git clone https://github.com/Yelp/elastalert.git

pip -V  &> /dev/null
if test $? -ne 0
then
    echo "Installing Pip ..." 
	apt-get install python-pip -y
fi

apt-get install python-dev -y
cd elastalert
pip install -r requirements.txt
python setup.py install

pip install "elasticsearch>=5.0.0"

cp config.yaml.example config.yaml

echo -n "IP elasticsearch: "
read ip_es
sed -i 's/elasticsearch.example.com/'"$ip_es"'/g' config.yaml 

elastalert-create-index

