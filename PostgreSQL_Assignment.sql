
CREATE TABLE rangers (
ranger_id SERIAL PRIMARY KEY  ,
name VARCHAR(100) NOT NULL,
region VARCHAR(100) NOT NULL
);


CREATE TABLE species (
species_id SERIAL PRIMARY KEY,
common_name VARCHAR(100) NOT NULL,
scientific_name VARCHAR(150) NOT NULL,
discovery_date DATE NOT NULL,
conservation_status VARCHAR(50) NOT NULL
);


CREATE TABLE sightings (
sighting_id SERIAL PRIMARY KEY,
species_id INT REFERENCES species(species_id),
ranger_id INT REFERENCES rangers(ranger_id),
location VARCHAR(150) NOT NULL,
sighting_time TIMESTAMP NOT NULL,
notes TEXT
);





INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');


INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);



SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;




--Problem:1
INSERT INTO rangers (ranger_id,name, region)
VALUES (4,'Derek Fox', 'Coastal Plains');




--Problem:2
SELECT COUNT(DISTINCT species_id) AS unique_species_count
FROM sightings;



--Problem:3
SELECT * FROM sightings
WHERE location ILIKE '%Pass%';



--Problem:4
SELECT r.name, COUNT(*) as total_sightings  FROM rangers r
INNER JOIN sightings s ON r.ranger_id =s.ranger_id 
GROUP BY r.name
order by r.name;



--Problem:5 
SELECT common_name FROM species WHERE species_id NOT IN 
(SELECT ranger_id  FROM sightings );



--Problem:6 
SELECT sp.common_name,s.sighting_time,r.name
FROM sightings s INNER JOIN species sp ON 
s.species_id = sp.species_id INNER JOIN
rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;



--Problem:7 
UPDATE species SET conservation_status = 'Historic'
WHERE EXTRACT(YEAR FROM discovery_date) < 1800;



--Problem:8 
SELECT sighting_id, 
CASE
WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) <= 17  THEN 'Afternoon'
ELSE 'Evening'
END AS time_of_day 
FROM sightings;



--Problem:9
DELETE FROM rangers
WHERE NOT EXISTS (SELECT FROM sightings WHERE 
sightings.ranger_id = rangers.ranger_id
);









