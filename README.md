# wtms

A Flutter app that feauteres account registration, login, autologin, profile screen, and logout. 

# Setting up the database using XAMPP

After starting XAMPP, create a new database called `wtms_db`, then create a table called `workers` with the following query:
```
CREATE TABLE `wtms_db`.`workers` ( 
  `id` INT NOT NULL AUTO_INCREMENT , 
  `fullName` VARCHAR(100) NOT NULL , 
  `email` INT(100) NOT NULL , 
  `password` INT(255) NOT NULL , 
  `phoneNum` INT(20) NOT NULL , 
  `address` TEXT NOT NULL , 
  PRIMARY KEY (`id`), 
  UNIQUE `EMAIL_UNIQUE` (`email`)
) ENGINE = InnoDB;
```

# Importing PHP API backend

Copy the `wtms` folder in https://github.com/MuhdHadif/wtms/tree/master/wtms and paste it in your XAMPP's `htdocs` folder. Example can be seen below:

![image](https://github.com/user-attachments/assets/152ed359-0607-4859-975f-cc0de1937712)

# Configuring myconfig.dart

`myconfig.dart` contains the IP address that is used to access the PHP API. To configure this correctly, open `cmd` and run `ipconfig /all` to find your IPv4 address.

![image](https://github.com/user-attachments/assets/d67f830b-ca5b-466b-bb93-aff719c78b31)

# Using external devices to test the app

When trying to test the app using an external device (e.g. real Android phone), connect the phone to the computer via USB. Enable USB debugging and USB tethering to connect both the phone and the device on the same network. Run `ipconfig /all` and configure `myconfig.dart` correctly. 

