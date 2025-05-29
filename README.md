# wtms

A Flutter app that feauteres account registration, login, autologin, profile screen, task screen, task submission screen, and logout. 

# Setting up the database using XAMPP

Detailed `.sql` files can be found at [wtms/tree/master/sql](https://github.com/MuhdHadif/wtms/tree/master/sql).

After starting XAMPP, create a new database called `wtms_db`, then create a tablea `workers`, `works`, and `submission` with the following queries:
```
CREATE TABLE `workers` (
  `id` int(11) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phoneNum` varchar(20) NOT NULL,
  `address` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `works` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `assignedTo` int(11) NOT NULL,
  `dateAssigned` date NOT NULL,
  `dueDate` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `submissions` (
  `id` int(11) NOT NULL,
  `workId` int(11) NOT NULL,
  `workerId` int(11) NOT NULL,
  `submissionText` text NOT NULL,
  `submittedAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

After creating the tables, add indexes and set auto increments with the following queries:
```
ALTER TABLE `workers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

ALTER TABLE `workers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `works`
  ADD CONSTRAINT `FK_assignedTo` FOREIGN KEY (`assignedTo`) REFERENCES `workers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_workId` (`workId`),
  ADD KEY `FK_workerId` (`workerId`);
```

Finally, insert sample data for `workers` and `works`.
```
INSERT INTO `workers` (`id`, `fullName`, `email`, `password`, `phoneNum`, `address`) VALUES
(1, 'Muhammad Hadif bin Azri ', 'muhdhadif.azri@gmail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0123456789', 'A1, Jalan Test 1/10, 10000, Selangor'),
(2, 'Test Worker 2', 'worker2@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0122222222', 'N2, Jalan 2/22, 20000'),
(3, 'Worker Jones 3', 'worker3@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0133333333', 'N3, Jalan 3/33, 30000'),
(4, 'John Worker 4', 'worker4@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0144444444', 'N4, Jalan 4/44, 40000'),
(5, 'Jimmy Worker 5', 'worker5@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0155555555', 'N5, Jalan 5/55, 50000');

INSERT INTO `works` (`id`, `title`, `description`, `assignedTo`, `dateAssigned`, `dueDate`, `status`) VALUES
(1, 'Prepare Material A', 'Prepare raw material A for assembly.', 1, '2025-05-25', '2025-05-28', 'pending'),
(2, 'Inspect Machine X', 'Conduct inspection for machine X.', 2, '2025-05-25', '2025-05-29', 'pending'),
(3, 'Clean Area B', 'Deep clean work area B before audit.', 3, '2025-05-25', '2025-05-30', 'pending'),
(4, 'Test Circuit Board', 'Perform unit test for circuit batch 4.', 4, '2025-05-25', '2025-05-28', 'pending'),
(5, 'Document Process', 'Write SOP for packaging unit.', 5, '2025-05-25', '2025-05-29', 'pending'),
(6, 'Paint Booth Check', 'Routine check on painting booth.', 1, '2025-05-25', '2025-05-30', 'pending'),
(7, 'Label Inventory', 'Label all boxes in section C.', 2, '2025-05-25', '2025-05-28', 'pending'),
(8, 'Update Database', 'Update inventory in MySQL system.', 3, '2025-05-25', '2025-05-29', 'pending'),
(9, 'Maintain Equipment', 'Oil and tune cutting machine.', 4, '2025-05-25', '2025-05-30', 'pending'),
(10, 'Prepare Report', 'Prepare monthly performance report.', 5, '2025-05-25', '2025-05-30', 'pending');
```

# Importing PHP API backend

Copy the `wtms` folder in [wtms/tree/master/wtms](https://github.com/MuhdHadif/wtms/tree/master/wtms) and paste it in your XAMPP's `htdocs` folder. Example can be seen below:

![image](https://github.com/user-attachments/assets/a6e93436-ad33-4da8-9beb-8c09833073b0)

# Configuring myconfig.dart

`myconfig.dart` contains the IP address that is used to access the PHP API. To configure this correctly, open `cmd` and run `ipconfig /all` to find your IPv4 address.

![image](https://github.com/user-attachments/assets/d67f830b-ca5b-466b-bb93-aff719c78b31)

# Using external devices to test the app

When trying to test the app using an external device (e.g. real Android phone), connect the phone to the computer via USB. Enable USB debugging and USB tethering to connect both the phone and the device on the same network. Run `ipconfig /all` and configure `myconfig.dart` correctly. 

