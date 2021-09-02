# Creates certifications

sudo su asterisk -

mkdir /home/asterisk/certs

# Generate self-signed certificate and private key
openssl req -x509 -nodes -newkey rsa:2048 -days 3650 \
-keyout /home/asterisk/certs/self-signed.key         \
-out /home/asterisk/certs/self-signed.crt            \
-subj "/C=NO/ST=Viken/L=Eidsvoll/O=ShiftEight/CN=shifteight.org"

# Change permissions of /home/asterisk/certs/ folder to 
# asterisk user read/write and asterisk group read 
sudo chmod 640 /home/asterisk/certs/*


# # This gives you a CLI prompt for values
# openssl req -x509 -nodes -newkey rsa:2048 -days 3650  \
# -keyout /home/asterisk/certs/self-signed.key          \
# -out /home/asterisk/certs/self-signed.crt
