from flask import Flask, request, render_template_string
import os

app = Flask(__name__)

html = '''
<!doctype html>
<html>
<head>
    <title>Connect to WiFi</title>
</head>
<body>
    <h1>Connect to WiFi</h1>
    <form action="/" method="post">
        <label for="ssid">SSID:</label>
        <input type="text" id="ssid" name="ssid" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password"><br><br>
        <input type="submit" value="Connect">
    </form>
</body>
</html>
'''

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        ssid = request.form['ssid']
        password = request.form['password']
        connect_to_wifi(ssid, password)
    return render_template_string(html)

def connect_to_wifi(ssid, password):
    wpa_supplicant_conf = f"""
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={{
    ssid="{ssid}"
    psk="{password}"
}}
"""
    with open('/etc/wpa_supplicant/wpa_supplicant.conf', 'w') as f:
        f.write(wpa_supplicant_conf)

    os.system('sudo systemctl stop hostapd')
    os.system('sudo ifconfig wlan0 down')
    os.system('sudo ifconfig wlan0 up')
    os.system('sudo systemctl restart wpa_supplicant')
    os.system('sudo systemctl restart dhcpcd')
    os.system('sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf')
   # os.system('sudo reboot')
    os._exit(0) 

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
