# Transferring files to/from android wirelessly

1. Create a mobile hotspot with your phone
2. Select the mobile hotspot as your new network from your laptop
3. Open WiFi FTP server from your android device, click start
4. Open nautilus on ubuntu, then select '+ Other Locations'
5. Enter the Server URL given in WiFi FTP Server
6. When the prompt for username and pwd come up, use those given by WiFi FTP Server below the Server URL
7. If you need to get something not in internal memory from the phone, go into settings in the app and select 'Root Folder', select custom, and select the SD card (for example).  Then disconnect from the app, and start again from the beginning.

Note, this is probably not as awesome, quick, or secure as doing this over a cable, but for some reason, Ubuntu seems to have a bug where using mtp with the usb cable fails when there are a large number of files ('large' being something like 250?).  Anyway, this is far more effective at the time of this writing and with my limited knowledge.
