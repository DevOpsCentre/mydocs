
CHEF SERVER, CHEF Workstation and CHEF NODE SETUP..
========================================================

Create two EC2 INSTANCEs in AWS ..(ignore if already exists/created..)
one will be used as CHEF WORKSTATION and the other one as NODE


1.DOWNLOAD WINSCP TO UR LAPTOP.. and install it 
https://cdn.winscp.net/files/WinSCP-5.15.3-Setup.exe?secure=a9XKMEpoCdtZIGSAppSaYA==,1563862759

2. CONNECT TO EC2 INSTANCE ( CHEF WORKSTATION) THROUGH WINSCP. 
USING SCP PROTOCOL, pubic IP of EC2 Instance and  .pem FILE..

3. CREATE AN ACCOUNT IN CHEF MANAGMENT..   (THIS IS USED AS CHEF SERVER)
https://manage.chef.io/signup

    - sign up and create an organization..
	- download the starter kit to ur laptop. 
	- upload to the ec2 machine through WINSCP (drag and drop )



4. TO download chef packages  - go to below website.. 
https://downloads.chef.io/chefdk

5. Chef installation in LINUX machine..

	-CONNECT TO THE CHEF WORKSTATION through Putty using IP and ..ppk file.  

	-SWITCH USER (use following command)
   sudo su 

  I) DOWNLOAD chef packages (use following command)
wget https://packages.chef.io/files/stable/chefdk/4.2.0/el/7/chefdk-4.2.0-1.el7.x86_64.rpm

  II) INSTALL chef  (use following command)
rpm -Uvh  chefdk-4.2.0-1.el7.x86_64.rpm

6.  Also unzip the uploaded starterkit (use following command)
unzip chef-starter.zip



7.  To establish a connection between CHEF Workstation and node.. 
	In the chef workstation...
      i) create  RSA key (use following command)
	    ssh-keygen
		
	  ii) Now go to the following location...(use following commands one by one..)
	      cd /root/.ssh; ll;
		  cat id_rsa.pub
	  iii) Now the code will be displayed on the screen..
	       copy that code into notepad file in ur laptop.

8. LOGIN TO THE NODE.. through putty  (use following commands one by one..)
	        sudo su;
			cd /root/.ssh; ll;
			vi authorized_keys
	i) Now copy the code from notepad file (copied in step [7. iii] above.) and 
	paste (append to the exisiting code) it in authorized_keys file and save it.
---------------------------------------------------------------------------------	
	NOTE : This above step is for root level access..
	
	To give access to ec2-user..
    go to this location.. (Use the following command )
	
	cd /home/ec2-user/.ssh; ll;
	vi authorized_keys
	
    - Now copy the code from notepad file (copied in step [7. iii] above.) and 
	paste (append to the exisiting code) it in authorized_keys file and save it.
---------------------------------------------------------------------------------	
	
	ii) GO TO THIS LOCATION.(use following commands one by one..)
	   cd /etc/ssh; ll;
	   vi sshd_config
	iii) Uncomment this line and save it.
	   #PermitRootLogin yes
	   
	iv.) Now use the following command..
	     service sshd restart

9. Now go to the CHEF WORKSTATION..(use the following command ) and try to connect.
         ssh <node-ipadress>   (for example: ssh 10.23.12.092)
		 
10. now exit from connection (if NODE is connected through ssh from CHEF WORKSTATION )
     in the CHEF WORKSTATION go to chef repo.. 

11. CHEF BOOTSTRAPPING ..
    in chef repo directory run the following command..(in place node ip give ur node ip address.)
	
	knife bootstrap <node-ip> --connection-user root --ssh-identity-file /root/.ssh/id_rsa --node-name WebServer

	 (for example: knife bootstrap 10.23.12.092 --connection-user root --ssh-identity-file /root/.ssh/id_rsa --node-name WebServer)
	 
BootStrapping is Done....


12. Now go to the CHEF SERVER.. 
https://manage.chef.io 

CHECK THE NODE SECTION.. for status.. 

13. Now CHECK THE CHEF-CLIENT Version IN CHEF WORKSTATION.. (use the following command)
chef -v

14. Creating COOKBOOKS IN WORKSTATION...

     i) GO TO THIS LOCATION (use following command..)
	 cd /home/ec2-user/chef-repo/cookbooks/
	 
	 ii)create cookbook (use following command..)
	 chef generate cookbook <cookbook name>
	 
     (for example: chef generate cookbook mycookbook)
	 
	 iii) AFTER COOKBOOK GENERATED.. GO TO THIS LOCATION..
	 cd mycookbook/recipes
	 vi default.rb
	 
	  (write ur recipe and save it.. )
	
	 iv) now again goto this location..(use following command..)
	 cd /home/ec2-user/chef-repo/cookbooks
	 
      v) Upload ur cookbook to CHEF SERVER..(use following command..)
	 knife upload <cookbook name>
	 
	 (for example: knife upload mycookbook)
	 
15. NOW GO TO CHEF SERVER.. 
	select ur node  ---> CLICK ON EDIT RUN LIST ---> u can check ur uploaded cookbooks .. drag and drop in current run list --> click on save run list..
	
16 . NOW GO TO CHEF NODE.. EXECUTE COOKBOOK (use following command..)
		chef-client

	 
   ============================================================
   #cook book references
   https://docs.chef.io/cookbooks.html
   #search for resources


		
		
			

 
