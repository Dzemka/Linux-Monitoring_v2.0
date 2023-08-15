# Install
##### Install iperf3
###### server
`sudo apt install iperf3`
`sudo ufw allow 5201`
`iperf3 -s`

###### client
`sudo apt install iperf3`
`iperf3 -c server-ip`

#### result iperf3
![iperf3Test](iperf3Test.jpg)