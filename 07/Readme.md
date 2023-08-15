# Install
##### Install grafana
`sudo apt-get install -y adduser libfontconfig1`
`wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.0.0_amd64.deb`
`sudo dpkg -i grafana-enterprise_10.0.0_amd64.deb`
##### Install prometheus
`sudo apt install prometheus`
##### Activate grafana
`sudo systemctl start grafana-server`
###### Or autorun at system startup
`sudo systemctl enable grafana-server`
##### Activate prometheus
`sudo systemctl start prometheus`
###### Or autorun at system startup
`sudo systemctl enable prometheus`
##### Install stress
`sudo apt install stress`

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