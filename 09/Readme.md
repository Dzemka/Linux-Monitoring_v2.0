# Install
##### Install nginx
`sudo apt instll nginx`
# Settings Virtual box
Settings->Network->Advanced->Port forwarding
Add ports:
    nginx 9111
# Setting nginx, prometheus and grafana
###### Copy sites config
`sudo cp default /etc/nginx/sites-available/default`
###### Copy prometheus config
`sudo cp prometheus.yml /etc/prometheus/`
###### Restart nginx
`sudo systemctl restart nginx`
###### Restart prometheus
`sudo systemctl restart prometheus`
On grafana import 09_dashboard.json
# Run exporter
`sudo ./main.sh`
