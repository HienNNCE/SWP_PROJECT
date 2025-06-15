CREATE DATABASE DriveXO

USE DriveXO;
GO

-- Tạo bảng Role
CREATE TABLE Role (
    role_id INT PRIMARY KEY,
    role_name NVARCHAR(255) NOT NULL
);
GO

-- Tạo bảng User
CREATE TABLE [User] (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone DECIMAL(15, 0) NOT NULL,
    address NVARCHAR(255),
    role_id INT,
    user_status NVARCHAR(255),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);
GO

-- Tạo bảng Category
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);
GO

-- Tạo bảng Car
CREATE TABLE Car (
    car_id INT PRIMARY KEY,
    car_name VARCHAR(255) NOT NULL,
    car_brand VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    car_price DECIMAL(10, 2) NOT NULL,
    car_year date NOT NULL,
    car_img varchar(255),
    car_stock INT NOT NULL,
    car_odo DECIMAL(10, 2),
    fuel_type varchar(255),
    displacement DECIMAL(10, 2),
	category_id int,
	FOREIGN KEY (category_id) REFERENCES Category(category_id)

);
GO

-- Tạo bảng Part
CREATE TABLE Part (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(255) NOT NULL,
    part_brand VARCHAR(255) NOT NULL,
    car_model VARCHAR(255) NOT NULL,
    description NVARCHAR(255),
    part_img varchar(255),
    part_stock INT NOT NULL,
    part_price DECIMAL(10, 2) NOT NULL,
);
GO

-- Tạo bảng Cart
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY,
    user_id INT,
    count_item INT NOT NULL,
    cart_price DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);
GO

-- Tạo bảng PartCartDetail
CREATE TABLE CartDetail (
    part_id INT,
    cart_id INT,
    pt_order_quantity INT NOT NULL,
    PRIMARY KEY (part_id, cart_id),
    FOREIGN KEY (part_id) REFERENCES Part(part_id),
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id)
);
GO

-- Tạo bảng CarBooking
CREATE TABLE CarAppointment (
    car_appointment_id INT PRIMARY KEY,
    user_id INT,
    car_id INT,
    ca_date DATETIME NOT NULL,
    ca_note NVARCHAR(255),
    ca_status VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
    FOREIGN KEY (car_id) REFERENCES Car(car_id)
);
GO

-- Tạo bảng RepairService
CREATE TABLE Service (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(255) NOT NULL,
    service_description NVARCHAR(255),
    service_price DECIMAL(10, 2) NOT NULL,
    estimate_time DATETIME NOT NULL,
    service_img VARCHAR(255)
);
GO

-- Tạo bảng RepairServiceBooking
CREATE TABLE ServiceSchedule (
    service_schedule_id INT PRIMARY KEY,
	service_id int,
    user_id INT,
    ss_date DATETIME NOT NULL,
    ss_note NVARCHAR(255),
    ss_status VARCHAR(255) NOT NULL,
	car_info VARCHAR,
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);
GO

-- Tạo bảng Payment
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    payment_method VARCHAR(255) NOT NULL,
);
GO

-- Tạo bảng Order
CREATE TABLE [Order] (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_price DECIMAL(10, 2) NOT NULL,
    order_status VARCHAR(255) NOT NULL,
    order_date DATETIME NOT NULL,
	payment_id int,
	FOREIGN KEY (payment_id) REFERENCES Payment (payment_id),
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
);
GO

-- Tạo bảng Comment
CREATE TABLE Comment (
    comment_id INT PRIMARY KEY,
    user_id INT,
    comment_text NVARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);
GO

--Tạo bảng Orderdetail
CREATE TABLE OrderDetail (
	order_detail_id int PRIMARY KEY,
	order_id INT,
	part_id INT,
	quantity INT  NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	total_price DECIMAL(20,2)  NOT NULL
	FOREIGN KEY (order_id) REFERENCES [Order](order_id),
	FOREIGN KEY (part_id) REFERENCES Part(part_id)
);
GO


-- Chèn dữ liệu vào bảng Role
INSERT INTO Role (role_id, role_name) VALUES
(1, 'Admin'),
(2, 'Customer'),
(3, 'Guest'),
(4, 'Staff');
GO

-- Chèn dữ liệu vào bảng Category
INSERT INTO Category (category_id, category_name) VALUES
(1, 'New'),
(2, 'Used'),
(3, 'Luxury'),
(4, 'Sport')
GO

-- Chèn dữ liệu vào bảng Car
INSERT INTO Car (car_id, car_name, car_brand, model, car_price, car_year, car_img, car_stock, car_odo, fuel_type, displacement, category_id) VALUES
(1, 'Toyota Camry', 'Toyota', 'Camry SE', 35000.00, '2022-05-01', 'toyota_camry.jpg', 10, 0, 'Gasoline', 2.5, 1),
(2, 'Honda Civic', 'Honda', 'Civic Turbo', 28000.00, '2023-01-10', 'honda_civic.jpg', 8, 0, 'Gasoline', 1.5, 1),
(3, 'Tesla Model 3', 'Tesla', 'Model 3', 45000.00, '2023-03-20', 'tesla_model_3.jpg', 6, 0, 'Electric', 0, 1),
(4, 'BMW X5', 'BMW', 'X5 xDrive40i', 75000.00, '2022-07-15', 'bmw_x5.jpg', 4, 5000, 'Gasoline', 3.0, 3),
(5, 'Mercedes S-Class', 'Mercedes-Benz', 'S500', 100000.00, '2021-12-01', 'mercedes_s-class.jpg', 2, 10000, 'Gasoline', 4.0, 3),
(6, 'Ford Ranger', 'Ford', 'Ranger Wildtrak', 42000.00, '2023-06-10', 'ford_ranger.jpg', 7, 0, 'Diesel', 2.0, 1),
(7, 'Hyundai Tucson', 'Hyundai', 'Tucson 1.6T', 32000.00, '2022-09-20', 'hyundai_tucson.jpg', 5, 1000, 'Gasoline', 1.6, 2),
(8, 'Kia Sportage', 'Kia', 'Sportage Signature', 30000.00, '2022-08-01', 'kia_sportage.jpg', 9, 0, 'Gasoline', 2.0, 1),
(9, 'Audi Q7', 'Audi', 'Q7 45 TFSI', 85000.00, '2023-01-15', 'audi_q7.jpg', 3, 2000, 'Gasoline', 3.0, 3),
(10, 'Mazda CX-5', 'Mazda', 'CX-5 Signature', 34000.00, '2021-11-10', 'mazda_cx-5.jpg', 6, 8000, 'Gasoline', 2.5, 2),

(11, 'Chevrolet Corvette', 'Chevrolet', 'Corvette Stingray', 65000.00, '2023-02-28', 'chevrolet_corvette.jpg', 2, 0, 'Gasoline', 6.2, 4),
(12, 'Porsche 911', 'Porsche', '911 Carrera', 120000.00, '2022-04-22', 'porsche_911.jpg', 1, 500, 'Gasoline', 3.0, 4),
(13, 'Lexus RX500h', 'Lexus', 'RX500h F Sport', 60000.00, '2023-07-01', 'lexus_rx500h.jpg', 4, 0, 'Hybrid', 2.4, 3),
(14, 'VinFast VF 8', 'VinFast', 'VF 8 Plus', 46000.00, '2023-05-20', 'vinfast_vf_8.jpg', 8, 0, 'Electric', 0, 1),
(15, 'Toyota Corolla', 'Toyota', 'Corolla Cross', 28000.00, '2021-10-10', 'toyota_corolla.jpg', 5, 6000, 'Gasoline', 1.8, 2),
(16, 'Honda CR-V', 'Honda', 'CR-V G', 36000.00, '2022-06-30', 'honda_cr-v.jpg', 7, 3000, 'Gasoline', 1.5, 2),
(17, 'Subaru WRX', 'Subaru', 'WRX STI', 41000.00, '2023-03-01', 'subaru_wrx.jpg', 4, 0, 'Gasoline', 2.0, 4),
(18, 'Nissan Leaf', 'Nissan', 'Leaf EV', 33000.00, '2022-08-10', 'nissan_leaf.jpg', 5, 0, 'Electric', 0, 1),
(19, 'Jeep Wrangler', 'Jeep', 'Wrangler Sahara', 48000.00, '2021-05-05', 'jeep_wrangler.jpg', 3, 12000, 'Gasoline', 3.6, 2),
(20, 'Mini Cooper', 'Mini', 'Cooper S', 29000.00, '2022-11-15', 'mini_cooper.jpg', 6, 500, 'Gasoline', 2.0, 1),

(21, 'Volvo XC90', 'Volvo', 'XC90 Recharge', 72000.00, '2023-01-10', 'volvo_xc90.jpg', 3, 0, 'Plug-in Hybrid', 2.0, 3),
(22, 'Hyundai Ioniq 5', 'Hyundai', 'Ioniq 5 AWD', 47000.00, '2023-04-25', 'hyundai_ioniq_5.jpg', 7, 0, 'Electric', 0, 1),
(23, 'Peugeot 3008', 'Peugeot', '3008 GT', 35000.00, '2022-03-10', 'peugeot_3008.jpg', 5, 2000, 'Gasoline', 1.6, 2),
(24, 'BMW M4', 'BMW', 'M4 Competition', 90000.00, '2023-06-15', 'bmw_m4.jpg', 2, 0, 'Gasoline', 3.0, 4),
(25, 'Ferrari Roma', 'Ferrari', 'Roma', 220000.00, '2023-02-14', 'ferrari_roma.jpg', 1, 100, 'Gasoline', 3.9, 4),
(26, 'Mitsubishi Outlander', 'Mitsubishi', 'Outlander PHEV', 42000.00, '2022-12-01', 'mitsubishi_outlander.jpg', 5, 0, 'Plug-in Hybrid', 2.4, 1),
(27, 'Suzuki Swift', 'Suzuki', 'Swift GLX', 21000.00, '2021-09-05', 'suzuki_swift.jpg', 8, 3000, 'Gasoline', 1.2, 2),
(28, 'Toyota Hilux', 'Toyota', 'Hilux Adventure', 40000.00, '2023-03-03', 'toyota_hilux.jpg', 6, 0, 'Diesel', 2.4, 1),
(29, 'Mazda 3', 'Mazda', 'Mazda 3 Sport', 28000.00, '2022-07-07', 'mazda_3.jpg', 7, 1000, 'Gasoline', 1.5, 2),
(30, 'Rolls-Royce Ghost', 'Rolls-Royce', 'Ghost Series II', 320000.00, '2022-10-01', 'rolls-royce_ghost.jpg', 1, 0, 'Gasoline', 6.6, 3);


-- Chèn dữ liệu vào bảng Part
INSERT INTO Part (part_id, part_name, part_brand, car_model, description, part_img, part_stock, part_price) VALUES
(1, 'Engine Oil Filter', 'Bosch', 'Camry', 'High efficiency filter', 'engine_oil_filter.jpg', 50, 15.99),
(2, 'Brake Pad Set', 'Ate', 'CR-V', 'Long-lasting brake pads', 'brake_pad_set.jpg', 30, 45.50),
(3, 'Shock Absorber', 'Monroe', 'F-150', 'Improved ride quality', 'shock_absorber.jpg', 20, 75.00),
(4, 'Seat Cover', 'Custom', '3', 'Leather seat cover', 'seat_cover.jpg', 40, 120.00),
(5, 'Spark Plug', 'NGK', 'Camry', 'High performance plug', 'spark_plug.jpg', 60, 10.99),
(6, 'Exhaust Pipe', 'MagnaFlow', 'CR-V', 'Stainless steel pipe', 'exhaust_pipe.jpg', 15, 150.00),
(7, 'Radiator', 'Denso', 'F-150', 'Efficient cooling', 'radiator.jpg', 10, 200.00),
(8, 'Transmission Fluid', 'Valvoline', '3', 'Synthetic fluid', 'transmission_fluid.jpg', 25, 25.50),
(9, 'Steering Pump', 'TRW', 'Camry', 'Reliable steering', 'steering_pump.jpg', 12, 100.00),
(10, 'Wheel Hub', 'SKF', 'CR-V', 'Durable hub', 'wheel_hub.jpg', 18, 80.00),
(11, 'Air Filter', 'Fram', 'F-150', 'Clean air intake', 'air_filter.jpg', 35, 12.99),
(12, 'Brake Disc', 'Brembo', '3', 'High friction disc', 'brake_disc.jpg', 20, 90.00),
(13, 'Strut Mount', 'KYB', 'Camry', 'Stable mount', 'strut_mount.jpg', 15, 60.00),
(14, 'Dashboard Cover', 'Covercraft', 'CR-V', 'Protective cover', 'dashboard_cover.jpg', 30, 150.00),
(15, 'Battery', 'Optima', 'F-150', 'Long-lasting power', 'battery.jpg', 8, 120.00),
(16, 'Muffler', 'Walker', '3', 'Noise reduction', 'muffler.jpg', 10, 130.00),
(17, 'Coolant', 'Prestone', 'Camry', 'Anti-freeze coolant', 'coolant.jpg', 40, 20.00),
(18, 'Clutch Kit', 'Luk', 'CR-V', 'Complete clutch set', 'clutch_kit.jpg', 5, 250.00),
(19, 'Tie Rod', 'Moog', 'F-150', 'Steering control', 'tie_rod.jpg', 12, 70.00),
(20, 'Tire', 'Michelin', '3', 'All-season tire', 'tire.jpg', 25, 200.00),
(21, 'Fuel Filter', 'Wix', 'Camry', 'Fuel system protection', 'fuel_filter.jpg', 30, 18.99),
(22, 'Brake Line', 'Dorman', 'CR-V', 'Stainless steel line', 'brake_line.jpg', 15, 35.00),
(23, 'Control Arm', 'ACDelco', 'F-150', 'Suspension support', 'control_arm.jpg', 10, 85.00),
(24, 'Floor Mat', 'WeatherTech', '3', 'All-weather mat', 'floor_mat.jpg', 20, 90.00),
(25, 'Alternator', 'Bosch', 'Camry', 'Power generation', 'alternator.jpg', 8, 150.00);
GO


-- Chèn dữ liệu vào bảng RepairService
INSERT INTO Service (service_id, service_name, service_description, service_price, estimate_time, service_img) VALUES
(1, 'Oil Change', 'Full synthetic oil change', 50.00, '01:30:00', 'oil_change.jpg'),
(2, 'Brake Inspection', 'Complete brake system check', 80.00, '02:00:00', 'brake_inspection.jpg'),
(3, 'Tire Rotation', 'Rotate all four tires', 30.00, '01:00:00', 'tire_rotation.jpg'),
(4, 'Engine Tune-up', 'Complete engine tune-up', 150.00, '03:00:00', 'engine_tune_up.jpg'),
(5, 'Transmission Service', 'Fluid and filter change', 200.00, '02:30:00', 'transmission_service.jpg'),
(6, 'Suspension Check', 'Full suspension inspection', 100.00, '02:00:00', 'suspension_check.jpg'),
(7, 'Battery Replacement', 'New battery installation', 120.00, '01:30:00', 'battery_replacement.jpg'),
(8, 'Exhaust Repair', 'Fix exhaust leaks', 180.00, '02:30:00', 'exhaust_repair.jpg'),
(9, 'Cooling System Flush', 'Full coolant flush', 90.00, '02:00:00', 'cooling_system_flush.jpg'),
(10, 'Brake Pad Replacement', 'New brake pads installation', 120.00, '02:30:00', 'brake_pad_replacement.jpg'),
(11, 'Wheel Alignment', 'Adjust wheel alignment', 70.00, '01:30:00', 'wheel_alignment.jpg'),
(12, 'Air Filter Replacement', 'New air filter install', 40.00, '01:00:00', 'air_filter_replacement.jpg'),
(13, 'Oil Filter Change', 'Replace oil filter', 30.00, '01:00:00', 'oil_filter_change.jpg'),
(14, 'Radiator Repair', 'Fix radiator leaks', 150.00, '02:30:00', 'radiator_repair.jpg'),
(15, 'Clutch Adjustment', 'Adjust clutch system', 100.00, '02:00:00', 'clutch_adjustment.jpg');
GO