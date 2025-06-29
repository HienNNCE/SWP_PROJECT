CREATE TABLE blogs (
    id INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(255) NOT NULL,
    summary NVARCHAR(500),
    content NVARCHAR(MAX),
    image NVARCHAR(255),
    published_at DATETIME
);
INSERT INTO blogs (title, summary, content, image, published_at) VALUES
(N'Electric Cars are the Future',
 N'Explore how EVs are shaping the automotive industry.',
 N'Electric vehicles (EVs) are gaining momentum rapidly as governments push for cleaner energy and reduced emissions.',
 N'ev-future.jpg',
 DATEADD(DAY, -1, GETDATE())
),
(N'Why Regular Maintenance Matters',
 N'Keeping your car in shape prevents costly repairs.',
 N'Regular maintenance helps detect issues early, improves safety, and keeps your car performing efficiently.',
 N'maintenance.jpg',
 DATEADD(DAY, -3, GETDATE())
),
(N'DriverXO Announces 2025 Lineup',
 N'Exciting models are coming your way next year!',
 N'DriverXO is launching new electric, hybrid, and high-performance vehicles in 2025.',
 N'lineup-2025.jpg',
 DATEADD(DAY, -5, GETDATE())
),
(N'DriveXO Expands Into Southeast Asia',
 N'New showrooms opening across Vietnam and Thailand.',
 N'DriveXO is accelerating its global strategy by expanding into Southeast Asia. With state-of-the-art showrooms and service centers in Ho Chi Minh City and Bangkok, the brand aims to bring its cutting-edge electric vehicles to emerging markets.',
 N'expansion-sea.jpg',
 DATEADD(DAY, -7, GETDATE())
),
(N'Inside the DriveXO Design Studio',
 N'A glimpse into how future cars are imagined.',
 N'The DriveXO Design Studio is a fusion of art and technology. With a team of international designers and engineers, every new model is crafted with precision, purpose, and passion.',
 N'design-studio.jpg',
 DATEADD(DAY, -9, GETDATE())
),
(N'Top 6 DriveXO Models of All Time',
 N'From classics to EVs: the cars that defined DriveXO.',
 N'Whether it’s the legacy DX7 or the futuristic EV-Hyper, DriveXO’s models have captured the hearts of drivers worldwide. Here''s a countdown of the five most iconic DriveXO vehicles.',
 N'top-models.jpg',
 DATEADD(DAY, -11, GETDATE())
),
(N'DriveXO and Sustainability',
 N'Eco-friendly materials and processes across the board.',
 N'DriveXO is committed to sustainability not just through EVs, but also in production. From recycled materials to solar-powered factories, green innovation is at the core of the company.',
 N'sustainability.jpg',
 DATEADD(DAY, -13, GETDATE())
);

