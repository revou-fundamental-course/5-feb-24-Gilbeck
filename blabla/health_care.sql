CREATE DATABASE healthcare;
USE healthcare;

CREATE TABLE patients (
    Patient_ID INT primary key,
    Age INT,
    Gender VARCHAR(10),
    Blood_Type VARCHAR(5)
);

CREATE TABLE body_measurements (
    Measurement_ID VARCHAR(10) PRIMARY KEY,
    Patient_ID INT,
    Height_cm DECIMAL(5,2),
    Weight_kg DECIMAL(5,2),
    FOREIGN KEY (Patient_ID) REFERENCES patients(Patient_ID)
);

CREATE TABLE medical_records (
    Record_ID VARCHAR(10) PRIMARY KEY,
    Patient_ID INT,
    Temperature_C DECIMAL(4,2),
    Heart_Rate_bpm INT,
    Systolic INT,
    Diastolic INT,
    FOREIGN KEY (Patient_ID) REFERENCES patients(Patient_ID)
);


SELECT * FROM patients;
SELECT * FROM body_measurements;
SELECT * FROM medical_records;



--1. Menghitung BMI setiap pasien
SELECT p.patient_id,
       ROUND(b.weight_kg / POWER(b.height_cm / 100, 2), 2) AS BMI
FROM patients p
JOIN body_measurements b ON p.patient_id = b.patient_id;

--2. Menampilkan pasien yang tergolong obesitas (BMI > 30)
SELECT p.patient_id,
       ROUND(b.weight_kg / POWER(b.height_cm / 100, 2), 2) AS BMI
FROM patients p
JOIN body_measurements b ON p.patient_id = b.patient_id
HAVING BMI > 30;

--3. Mencari rata-rata detak jantung dan suhu tubuh untuk setiap gender
SELECT p.gender,
       ROUND(AVG(m.temperature_c), 2) AS avg_temperature,
       ROUND(AVG(m.heart_rate_bpm), 2) AS avg_heart_rate
FROM medical_records m
JOIN patients p ON p.patient_id = m.patient_id
GROUP BY p.gender;

--4. Menampilkan daftar pasien dengan tekanan darah tinggi (Systolic >= 140 or Diastolic >= 90)
SELECT p.patient_id, m.systolic, m.diastolic
FROM medical_records m
JOIN patients p ON m.patient_id = p.patient_id
WHERE m.systolic >= 140 OR m.diastolic >= 90;

--5. Menghitung jumlah pasien berdasarkan blood type
SELECT p.blood_type, COUNT(*) AS total_patients
FROM patients p
GROUP BY p.blood_type
ORDER BY total_patients DESC;

--6. Menampilkan pasien dengan heart rate berbahaya (heart rate > 100 bpm)
SELECT p.patient_id, m.heart_rate_bpm
FROM medical_records m
JOIN patients p ON m.patient_id = p.patient_id
WHERE m.heart_rate_bpm > 100;

--7. Menampilkan data lengkap seluruh pasien
SELECT p.patient_id, p.age, p.gender, p.blood_type,
       b.height_cm, b.weight_kg,
       m.temperature_c, m.heart_rate_bpm, m.systolic, m.diastolic
FROM patients p
JOIN body_measurements b ON p.patient_id = b.patient_id
JOIN medical_records m ON p.patient_id = m.patient_id;

--8. Menghitung rata-rata BMI berdasarkan blood type
SELECT p.blood_type,
       ROUND(AVG(b.weight_kg / POWER(b.height_cm / 100, 2)), 2) AS avg_BMI
FROM patients p
JOIN body_measurements b ON p.patient_id = b.patient_id
GROUP BY p.blood_type
ORDER BY avg_BMI DESC;

--9. Mencari pasien dengan BMI tertinggi
SELECT p.patient_id,
       ROUND(b.weight_kg / POWER(b.height_cm / 100, 2), 2) AS BMI
FROM body_measurements b
JOIN patients p ON p.patient_id = b.patient_id
ORDER BY BMI DESC
LIMIT 1;

--10. Mencari pasien dengan tekanan darah sangat rendah (Systolic < 90 or Diastolic < 60)
SELECT p.patient_id, m.systolic, m.diastolic
FROM medical_records m
JOIN patients p ON m.patient_id = p.patient_id
WHERE m.systolic < 90 OR m.diastolic < 60;