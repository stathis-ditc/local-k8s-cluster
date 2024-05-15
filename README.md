raspberry pi metrics

install influxdb
```
sudo apt install influxdb
```

install telegraf
```
wget -q https://repos.influxdata.com/influxdb.key
echo '23a1c8836f0afc5ed24e0486339d7cc8f6790b83886c4c96995b88a061c5bb5d influxdb.key' | sha256sum -c && cat influxdb.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdb.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdb.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list
https://www.influxdata.com/blog/linux-package-signing-key-rotation/
sudo apt update
sudo apt install telegraf 
```

influxdb create
```
https://linuxhint.com/monitor-raspberry-pi-system-using-influxdb-telegraf-grafana/
```

telegraf config
```
[[outputs.influxdb]]
urls = ["http://127.0.0.1:8086"]
database = "telegraf"
username = "telegraf_linux"
password = "12345"
#In order to monitor both Network interfaces, eth0 and wlan0, uncomment, or add the next:
[[inputs.net]]
[[inputs.netstat]]
[[inputs.file]]
files = ["/sys/class/thermal/thermal_zone0/temp"]
name_override = "cpu_temperature"
data_format = "value"
data_type = "integer"

[[inputs.exec]]
commands = ["/opt/vc/bin/vcgencmd measure_temp"]
name_override = "gpu_temperature"
data_format = "grok"
grok_patterns = ["%{NUMBER:value:float}"]
```

grafana dashboardid: 10578 / correct system value `SELECT * FROM "autogen"."cpu_temperature" `

open nodeport 8086 in node-exporter svc


