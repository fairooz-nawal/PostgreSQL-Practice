# 🧱 Practice Questions and Answers

## 📊 Main Tables Overview

| Table Name  | Description                                                                 |
|-------------|-----------------------------------------------------------------------------|
| rangers   | Information about rangers like Meera (name, contact, zone)                 |
| species   | Information about animals (name, scientific name, conservation status)     |
| sightings | Records of animal sightings (when, where, by whom)                         |

---

### ⿡ rangers Table

| Field Name  | Description               |
|-------------|---------------------------|
| ranger_id | Unique ID for each ranger |
| name      | Full name of the ranger   |
| region    | Area they patrol          |

---

### ⿢ species Table

| Field Name            | Description                            |
|-----------------------|----------------------------------------|
| species_id          | Unique ID for each species             |
| common_name         | Common name (e.g., "Shadow Leopard")   |
| scientific_name     | Scientific name                        |
| discovery_date      | When the species was first recorded    |
| conservation_status | Status like "Endangered", "Vulnerable" |

---

### ⿣ sightings Table

| Field Name      | Description                                |
|------------------|--------------------------------------------|
| sighting_id   | Unique ID for each sighting                |
| ranger_id     | Who made the sighting (FK to rangers)    |
| species_id    | Which animal was seen (FK to species)    |
| sighting_time | Date and time of the sighting              |
| location      | Where it was seen                          |
| notes         | Additional observations (optional)         |

---

## 🔗 Relationships Between Tables

| Relationship           | Description                                       |
|------------------------|---------------------------------------------------|
| sightings → rangers | Each sighting is linked to the ranger who made it |
| sightings → species | Each sighting is linked to a specific species     |

---

## 📂 Sample Data

### ⿡ rangers Table

| ranger_id | name        | region         |
|-----------|-------------|----------------|
| 1         | Alice Green | Northern Hills |
| 2         | Bob White   | River Delta    |
| 3         | Carol King  | Mountain Range |

---

### ⿢ species Table

| species_id | common_name      | scientific_name          | discovery_date | conservation_status |
|------------|------------------|--------------------------|----------------|---------------------|
| 1          | Snow Leopard     | Panthera uncia           | 1775-01-01     | Endangered          |
| 2          | Bengal Tiger     | Panthera tigris tigris   | 1758-01-01     | Endangered          |
| 3          | Red Panda        | Ailurus fulgens          | 1825-01-01     | Vulnerable          |
| 4          | Asiatic Elephant | Elephas maximus indicus  | 1758-01-01     | Endangered          |

---

### ⿣ sightings Table

| sighting_id | species_id | ranger_id | location          | sighting_time        | notes                      |
|-------------|------------|-----------|-------------------|----------------------|----------------------------|
| 1           | 1          | 1         | Peak Ridge        | 2024-05-10 07:45:00  | Camera trap image captured |
| 2           | 2          | 2         | Bankwood Area     | 2024-05-12 16:20:00  | Juvenile seen              |
| 3           | 3          | 3         | Bamboo Grove East | 2024-05-15 09:10:00  | Feeding observed           |
| 4           | 1          | 2         | Snowfall Pass     | 2024-05-18 18:30:00  | (NULL)                     |

---



### Problem-1: Register a new ranger  
Insert Operation

sql
-- Query
INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Sample Output
AffectedRows : 1


---

### Problem-2: Count unique species ever sighted

sql
-- Query
SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;

-- Sample Output
| unique_species_count |
|----------------------|
| 3                    |


---

### Problem-3: Find all sightings where the location includes "Pass"

sql
-- Query
SELECT * FROM sightings WHERE location ILIKE '%Pass%';

-- Sample Output
| sighting_id | species_id | ranger_id | location      | sighting_time        | notes  |
|-------------|------------|-----------|---------------|----------------------|--------|
| 4           | 1          | 2         | Snowfall Pass | 2024-05-18 18:30:00  | (NULL) |


---

### Problem-4: List each ranger's name and their total number of sightings

sql
-- Query
SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;

-- Sample Output
| name        | total_sightings |
|-------------|-----------------|
| Alice Green | 1               |
| Bob White   | 2               |
| Carol King  | 1               |


---

### Problem-5: List species that have never been sighted

sql
-- Query
SELECT common_name
FROM species
WHERE species_id NOT IN (SELECT DISTINCT species_id FROM sightings);

-- Sample Output
| common_name      |
|------------------|
| Asiatic Elephant |


---

### Problem-6: Show the most recent 2 sightings

sql
-- Query
SELECT sp.common_name, s.sighting_time, r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Sample Output
| common_name   | sighting_time        | name        |
|---------------|----------------------|-------------|
| Snow Leopard  | 2024-05-18 18:30:00  | Bob White   |
| Red Panda     | 2024-05-15 09:10:00  | Carol King  |


---

### Problem-7: Update species discovered before year 1800 to status 'Historic'

sql
-- Query
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- Sample Output
AffectedRows : 3


---

### Problem-8: Label each sighting's time of day

sql
-- Query
SELECT sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;

-- Sample Output
| sighting_id | time_of_day |
|-------------|-------------|
| 1           | Morning     |
| 2           | Afternoon   |
| 3           | Morning     |
| 4           | Evening     |


---

### Problem-9: Delete rangers who have never sighted any species

sql
-- Query
DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);

-- Sample Output
AffectedRows : 1


---


#
#







# 📘 PostgreSQL এবং তার প্রধান কনসেপ্টসমূহ

## 1. PostgreSQL কী?

PostgreSQL হলো একটি ওপেন সোর্স রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম যা ACID properties মেনে চলে। এটি SQL এবং JSON উভয় ফরম্যাটে ডেটা ম্যানেজ করতে পারে। এটি বড় অ্যাপ্লিকেশন, ওয়েব সার্ভিস এবং বিশ্লেষণধর্মী ডেটা হ্যান্ডল করার জন্য খুবই উপযুক্ত।

### 🎯 উদাহরণ:
আপনি যদি একটি ই-কমার্স অ্যাপ বানান যেখানে হাজার হাজার প্রোডাক্ট আছে, PostgreSQL ব্যবহার করে আপনি সেই প্রোডাক্টগুলোর ইনভেন্টরি, অর্ডার এবং ইউজার তথ্য সঠিকভাবে সংরক্ষণ করতে পারবেন।

---

## 2. PostgreSQL-এ Schema এর উদ্দেশ্য কী?

Schema হচ্ছে ডেটাবেসের মধ্যে একটি লজিক্যাল কাঠামো বা নেমস্পেস যা ডেটা অবজেক্টগুলো (যেমন টেবিল, ভিউ, ফাংশন ইত্যাদি) সংগঠিত করে।

### ✅ উদ্দেশ্য:
- ডেটা আলাদা করে রাখার ব্যবস্থা
- মাল্টি-ইউজার এনভায়রনমেন্টে নিরাপত্তা নিশ্চিত করা
- বড় সিস্টেমে মডিউলার স্ট্রাকচার তৈরি করা

### 🎯 উদাহরণ:
sql
CREATE SCHEMA sales;

CREATE TABLE sales.orders (
  id SERIAL PRIMARY KEY,
  customer_id INT,
  total_amount NUMERIC
);


---

## 3. Primary Key ও Foreign Key কী?

### ✅ Primary Key:
একটি ইউনিক কলাম যা প্রতিটি রেকর্ডকে আলাদা করে শনাক্ত করে।

### ✅ Foreign Key:
অন্য টেবিলের Primary Key এর সাথে সম্পর্ক স্থাপন করে, যা রেফারেন্স ইনটিগ্রিটি নিশ্চিত করে।

### 🎯 উদাহরণ:
sql
CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id)
);


এখানে orders.customer_id হলো customers.id এর Foreign Key।

---

## 4. VARCHAR ও CHAR এর পার্থক্য কী?

- VARCHAR(n) হচ্ছে ভ্যারিয়েবল দৈর্ঘ্যের টেক্সট। এটা শুধু প্রয়োজন অনুযায়ী স্পেস নেয়।
- CHAR(n) হচ্ছে ফিক্সড দৈর্ঘ্যের টেক্সট। এটা সবসময় n চরেক্টার স্পেস নেয়।

### 🎯 উদাহরণ:
sql
CREATE TABLE products (
  code VARCHAR(10),
  category CHAR(10)
);


যদি code = 'P001' হয় এবং category = 'Toy', তাহলে code হবে 'P001' আর category হবে 'Toy       ' (7 টি স্পেস সহ)।

---

## 5. WHERE clause এর কাজ কী?

WHERE ক্লজ দিয়ে ডেটা ফিল্টার করা যায় যাতে নির্দিষ্ট শর্ত অনুযায়ী ডেটা রিটার্ন হয়।

### 🎯 উদাহরণ:
sql
SELECT * FROM employees
WHERE department = 'HR' AND salary > 50000;


এখানে শুধুমাত্র HR ডিপার্টমেন্টের এবং যাদের স্যালারি ৫০,০০০ টাকার বেশি তাদের তথ্য রিটার্ন হবে।

---

## 6. LIMIT ও OFFSET এর ব্যবহার কী?

- LIMIT: কতগুলো রেকর্ড রিটার্ন করতে চান তা নির্ধারণ করে।
- OFFSET: কতগুলো রেকর্ড স্কিপ করবে তা নির্ধারণ করে।

### 🎯 উদাহরণ (pagination):
sql
SELECT * FROM products
LIMIT 10 OFFSET 20;


এটি ২১তম রেকর্ড থেকে শুরু করে ১০টি রেকর্ড রিটার্ন করবে। সাধারণত pagination-এ ব্যবহৃত হয়।

---

## 7. UPDATE স্টেটমেন্ট দিয়ে ডেটা কিভাবে পরিবর্তন করা যায়?

UPDATE দিয়ে একটি টেবিলের এক বা একাধিক রেকর্ড পরিবর্তন করা যায়। SET দিয়ে নতুন মান সেট করা হয় এবং WHERE ক্লজ দিয়ে নির্দিষ্ট রেকর্ড টার্গেট করা হয়।

### 🎯 উদাহরণ:
sql
UPDATE employees
SET salary = salary + 5000
WHERE department = 'IT';


এটি IT ডিপার্টমেন্টের সবার স্যালারিতে ৫০০০ টাকা যোগ করবে।

---

## 8. JOIN অপারেশনের গুরুত্ব ও কাজ কী?

JOIN দিয়ে একাধিক টেবিলের ডেটা যুক্ত করে একটি ইউনিফাইড ভিউ তৈরি করা যায়।

### 🎯 উদাহরণ (INNER JOIN):
sql
SELECT e.name, d.name AS department
FROM employees e
JOIN departments d ON e.dept_id = d.id;


এটি employees এবং departments টেবিলকে dept_id এর মাধ্যমে যুক্ত করে।

---

## 9. GROUP BY ক্লজ ও এটি কীভাবে Aggregation-এ সাহায্য করে?

GROUP BY একই ধরনের মানকে একত্রিত করে এবং সেটির উপর Aggregate ফাংশন (যেমন COUNT, SUM) প্রয়োগ করতে সাহায্য করে।

### 🎯 উদাহরণ:
sql
SELECT department, COUNT(*) AS total
FROM employees
GROUP BY department;


এখানে প্রতিটি ডিপার্টমেন্টে কতজন কর্মচারী আছে তা গণনা করা হয়।

---

## 10. Aggregate Functions (COUNT, SUM, AVG) কীভাবে কাজ করে?

Aggregate functions অনেকগুলো রেকর্ডের উপর ভিত্তি করে একটি একক রেজাল্ট রিটার্ন করে।

### 🎯 উদাহরণ:
sql
SELECT COUNT(*) FROM orders; -- মোট অর্ডার সংখ্যা

SELECT SUM(total_amount) FROM orders; -- মোট বিক্রির পরিমাণ

SELECT AVG(salary) FROM employees; -- গড় স্যালারি


এই ফাংশনগুলো রিপোর্টিং এবং বিশ্লেষণে ব্যাপকভাবে ব্যবহৃত হয়।

---
