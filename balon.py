import paho.mqtt.client as mqtt
import urllib.request
import RPi.GPIO as GPIO
import time

role=14
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.setup(role,GPIO.OUT)
client = mqtt.Client("P6")
contents=""

GPIO.output(role,GPIO.HIGH)

connected = False
url = ""



def on_connect(client, userdata, flags, rc):
    global connected
    global url
    global contents
    if rc == 0:
        print("Connected with result code " + str(rc))
        url = "[Text file link/path that contains clomosy Project GUID]""
        try:
            with urllib.request.urlopen(url) as f:
                contents = f.read().decode('utf-8')
            if contents != "":
                client.subscribe(contents + "/clomosy/#")
                connected = True
            else:
                print("[002] GUID Error For P6")
        except:
            print("[001] GUID Error For P6")
            client.disconnect()
    else:
        print("Connection failed with result code " + str(rc))


def on_message(client,userdata,message):
	
	strMsg=message.payload.decode("utf-8").split('!')
	print("message received from ",str(strMsg[0]))
	words=message.payload.decode("utf-8").split('!') 
	if  words[1] == 'ON1':
		GPIO.output(role,GPIO.LOW)
		client.publish(contents+"/clomosy","!IOT|OK")
		print('Role 1 ON')
	elif words[1] =='OFF1':
		
		GPIO.output(role,GPIO.HIGH)
		client.publish(contents+"/clomosy","!IOT|OK")
		print('Role 1 OFF')


def main():		
    client = mqtt.Client("P6")
    client.on_connect = on_connect
    client.on_message = on_message
    client.username_pw_set("1","1")

    global connected
    if not connected:
        client.connect("1.1.1.1", 1111)

	
    client.loop_forever(1, None, True)


if __name__ == "__main__":
    main()
