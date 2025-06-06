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



## 4. WHERE clause এর কাজ কী?

WHERE ক্লজ দিয়ে ডেটা ফিল্টার করা যায় যাতে নির্দিষ্ট শর্ত অনুযায়ী ডেটা রিটার্ন হয়।

### 🎯 উদাহরণ:
sql
SELECT * FROM employees
WHERE department = 'HR' AND salary > 50000;


এখানে শুধুমাত্র HR ডিপার্টমেন্টের এবং যাদের স্যালারি ৫০,০০০ টাকার বেশি তাদের তথ্য রিটার্ন হবে।

---

## 5. LIMIT ও OFFSET এর ব্যবহার কী?

- LIMIT: কতগুলো রেকর্ড রিটার্ন করতে চান তা নির্ধারণ করে।
- OFFSET: কতগুলো রেকর্ড স্কিপ করবে তা নির্ধারণ করে।

### 🎯 উদাহরণ (pagination):
sql
SELECT * FROM products
LIMIT 10 OFFSET 20;


এটি ২১তম রেকর্ড থেকে শুরু করে ১০টি রেকর্ড রিটার্ন করবে। সাধারণত pagination-এ ব্যবহৃত হয়।

---
