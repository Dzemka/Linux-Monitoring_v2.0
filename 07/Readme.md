# Install
##### Install grafana
`sudo apt-get install -y adduser libfontconfig1`
`wget https://dl.grafana.com/oss/release/grafana_10.0.0_amd64.deb`
`sudo dpkg -i grafana_10.0.0_amd64.deb`
`rm -rf grafana_10.0.0_amd64.deb`
##### Install prometheus
`sudo apt install prometheus`
##### Activate grafana
`sudo systemctl start grafana-server`

######  Or autorun at system startup
`sudo systemctl enable grafana-server`
###### open ports to grafana:
`sudo ufw allow 3000`

##### Activate prometheus
`sudo systemctl start prometheus`
###### Or autorun at system startup
`sudo systemctl enable prometheus`
###### open ports to prometheus and node-exporter:
`sudo ufw allow 9090`
`sudo ufw allow 9100`
###### Generete prometheus.yml
`./generatePrometheusConfig.sh`
###### Move prometheus.yml to /etc/prometheus
`sudo mv prometheus.yml /etc/prometheus/`
###### Restart prometheus
`sudo systemctl restart prometheus`
##### Install stress
`sudo apt install stress`

# Settings Virtual box
Settings->Network->Advanced->Port forwarding
Add ports:
    grafana 3000
    prometheus 9090
    node-exporter 9100

# Test

#### Test ex02

`cd ../02/ && ./main abcdef qwerty.log 1Mb && cd ../07/`
##### Before test
![begore](./test1.jpg)

#### After test
![after](./test2.jpg)


#### Test stress
`stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`
##### Before test
![begore](./test3.jpg)

#### After test
![after](./test4.jpg)
