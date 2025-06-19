# wtms

A Flutter app that feauteres account registration, login, autologin, profile screen, task screen, task submission screen, and logout. 

# Setting up the database using XAMPP

Full database dump file (.sql) can be found at [wtms/tree/master/sql](https://github.com/MuhdHadif/wtms/tree/master/sql). Simply use XAMPP's Import feature or other methods that can execute the .sql file to import the full database in one go. If you want to import the individual tables and data, see the following:

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
  ADD UNIQUE KEY `email` (`email`),
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `works`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_assignedTo` (`assignedTo`),
  ADD CONSTRAINT `FK_assignedTo` FOREIGN KEY (`assignedTo`) REFERENCES `workers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

ALTER TABLE `submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_workId` (`workId`),
  ADD KEY `FK_workerId` (`workerId`),
  ADD CONSTRAINT `FK_workId` FOREIGN KEY (`workId`) REFERENCES `works` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_workerId` FOREIGN KEY (`workerId`) REFERENCES `workers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
```

Finally, insert sample data for `workers`, `works` and `submissions`.
```
INSERT INTO `workers` (`id`, `fullName`, `email`, `password`, `phoneNum`, `address`) VALUES
(1, 'Muhammad Hadif bin Azri', 'muhdhadif.azri@gmail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0123456789', 'A1, Jalan Test 1/10, 10000'),
(2, 'Test Worker 2', 'worker2@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0122222222', 'N2, Jalan 2/22, 20000'),
(3, 'Worker Jones 3', 'worker3@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0133333333', 'N3, Jalan 3/33, 30000'),
(4, 'John Worker 4', 'worker4@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0144444444', 'N4, Jalan 4/44, 40000'),
(5, 'Jimmy Worker 5', 'worker5@mail.com', '6367c48dd193d56ea7b0baad25b19455e529f5ee', '0155555555', 'N5, Jalan 5/55, 50000');


INSERT INTO `works` (`id`, `title`, `description`, `assignedTo`, `dateAssigned`, `dueDate`, `status`) VALUES
(1, 'Prepare Material A', 'Prepare raw material A for assembly.', 1, '2025-05-25', '2025-05-28', 'complete'),
(2, 'Inspect Machine X', 'Conduct inspection for machine X.', 2, '2025-05-25', '2025-05-29', 'complete'),
(3, 'Clean Area B', 'Deep clean work area B before audit.', 3, '2025-05-25', '2025-05-30', 'complete'),
(4, 'Test Circuit Board', 'Perform unit test for circuit batch 4.', 4, '2025-05-25', '2025-05-28', 'complete'),
(5, 'Document Process', 'Write SOP for packaging unit.', 5, '2025-05-25', '2025-05-29', 'complete'),
(6, 'Paint Booth Check', 'Routine check on painting booth.', 1, '2025-05-25', '2025-05-30', 'complete'),
(7, 'Label Inventory', 'Label all boxes in section C.', 2, '2025-05-25', '2025-05-28', 'complete'),
(8, 'Update Database', 'Update inventory in MySQL system.', 3, '2025-05-25', '2025-05-29', 'complete'),
(9, 'Maintain Equipment', 'Oil and tune cutting machine.', 4, '2025-05-25', '2025-05-30', 'complete'),
(10, 'Prepare Report', 'Prepare monthly performance report.', 5, '2025-05-25', '2025-05-30', 'complete');

INSERT INTO `submissions` (`id`, `workId`, `workerId`, `submissionText`, `submittedAt`) VALUES
(12, 1, 1, 'Prepared raw material A, configured machine Alpha for Step 2.', '2025-06-18 00:22:55'),
(13, 6, 1, 'Checked booths, cleaned residual paint off surfaces, wiped environment clean for next use.', '2025-06-18 00:23:27'),
(14, 2, 2, 'Inspected machine X, found minor defects, ordered spare parts for scheduled maintenance.', '2025-06-18 00:24:39'),
(15, 7, 2, 'Labelled all boxes in Section C, sorted through all inventory, should be organised.', '2025-06-18 00:25:05'),
(16, 3, 3, 'Performed deep clean at area B, prepared audit procedures for relevant officers.', '2025-06-18 00:26:19'),
(17, 8, 3, 'Updated all records of inventory in the database system, backups copied to remote site.', '2025-06-18 00:26:49'),
(18, 4, 4, 'Performed unit tests for batch 4, packaged all circuits for further assembly.', '2025-06-18 00:31:33'),
(19, 9, 4, 'Cutting machine inspected and tuned, replaced oil before completing service.', '2025-06-18 00:32:01'),
(24, 5, 5, 'Wrote SOP for packaging unit.', '2025-06-18 00:50:11'),
(25, 10, 5, 'Collated operations data and prepared performance report, uploaded to dashboard.', '2025-06-18 00:51:15');
```

# Importing PHP API backend

Copy the `wtms` folder in [wtms/tree/master/wtms](https://github.com/MuhdHadif/wtms/tree/master/wtms) and paste it in your XAMPP's `htdocs` folder. Example can be seen below:

![image](https://github.com/user-attachments/assets/dce8632c-1ed3-4ad2-ba55-58fccae0f0c3)


# Configuring myconfig.dart

Before you start, make sure both your computer and mobile device are on the same network. `myconfig.dart` contains the IP address that the app uses to access the PHP API. To configure this correctly, open `cmd` and run `ipconfig /all` to find your computer's local IPv4 address.

![image](https://github.com/user-attachments/assets/1b6278af-6079-45d5-8789-e483215ee38d)

Then, copy the address and paste it into `myconfig.dart`, like so:

![image](https://github.com/user-attachments/assets/01be216b-7d77-42c3-b15f-ef4591962e68)

# Using external devices to test the app

When trying to test the app using an external device (e.g. real Android phone), connect the phone to the computer via USB. Enable USB debugging and USB tethering to connect both the phone and the device on the same network. Run `ipconfig /all` and configure `myconfig.dart` as previously described. 

