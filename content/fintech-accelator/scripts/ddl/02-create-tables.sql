-- ##################################################
-- #            DDL SCRIPT DOCUMENTATION            #
-- ##################################################
-- This script defines the database structure for the Smart Health hospital management system.
-- Includes tables for PATIENTS, DOCTORS, APPOINTMENTS, CLINICAL_HISTORIES, MEDICATIONS,
-- DIAGNOSES, PROCEDURES, INSURERS, POLICIES, and auxiliary entities such as ADDRESSES,
-- PHONES, EMERGENCY_CONTACTS, and DOCUMENTS.
-- The system is designed to manage patient information, medical records, appointments,
-- and healthcare services with full referential integrity, normalization, and scalability.

-- ##################################################
-- #              TABLE DEFINITIONS                 #
-- ##################################################

-- Independent tables first
-- Table: smart_health.PATIENTS
-- Brief: Stores basic information about patients
CREATE TABLE IF NOT EXISTS smart_health.PATIENTS (
    patient_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    first_surname VARCHAR(100) NOT NULL,
    second_surname VARCHAR(100),
    birth_date DATE NOT NULL,
    sex VARCHAR(10),
    email VARCHAR(150) UNIQUE,
    registration_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN DEFAULT TRUE
);

-- Table: smart_health.DOCUMENT_TYPES
-- Brief: Catalog of patient document types
CREATE TABLE IF NOT EXISTS smart_health.DOCUMENT_TYPES (
    document_type_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Table: smart_health.PATIENT_DOCUMENTS
-- Brief: Links patients to their identification documents
CREATE TABLE IF NOT EXISTS smart_health.PATIENT_DOCUMENTS (
    patient_id VARCHAR(50) NOT NULL,
    document_type_id VARCHAR(20) NOT NULL,
    document_number VARCHAR(50) PRIMARY KEY,
    issuing_country VARCHAR(50) NOT NULL,
    issue_date DATE
);

-- Table: smart_health.PATIENT_ADDRESSES
-- Brief: Stores addresses associated with patients
CREATE TABLE IF NOT EXISTS smart_health.PATIENT_ADDRESSES (
    address_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    address_type VARCHAR(50),
    department VARCHAR(100),
    municipality VARCHAR(100),
    address_text VARCHAR(255),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    postal_code VARCHAR(20)
);

-- Table: smart_health.PATIENT_PHONES
-- Brief: Contact phone numbers for patients
CREATE TABLE IF NOT EXISTS smart_health.PATIENT_PHONES (
    phone_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    phone_type VARCHAR(50),
    number VARCHAR(50) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE
);

-- Table: smart_health.EMERGENCY_CONTACTS
-- Brief: Emergency contacts related to patients
CREATE TABLE IF NOT EXISTS smart_health.EMERGENCY_CONTACTS (
    contact_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    name VARCHAR(150) NOT NULL,
    relationship VARCHAR(50),
    phone VARCHAR(50),
    email VARCHAR(150),
    instructions TEXT
);

-- Table: smart_health.DOCTORS
-- Brief: Stores doctor information
CREATE TABLE IF NOT EXISTS smart_health.DOCTORS (
    doctor_id VARCHAR(50) PRIMARY KEY,
    internal_code VARCHAR(50),
    license_number VARCHAR(50),
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    first_surname VARCHAR(100) NOT NULL,
    second_surname VARCHAR(100),
    work_email VARCHAR(150),
    join_date DATE,
    active BOOLEAN DEFAULT TRUE
);

-- Table: smart_health.SPECIALTIES
-- Brief: Medical specialties catalog
CREATE TABLE IF NOT EXISTS smart_health.SPECIALTIES (
    specialty_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Table: smart_health.DOCTOR_SPECIALTIES
-- Brief: Relationship between doctors and specialties
CREATE TABLE IF NOT EXISTS smart_health.DOCTOR_SPECIALTIES (
    doctor_id VARCHAR(50) NOT NULL,
    specialty_id VARCHAR(50) NOT NULL,
    since_ts TIMESTAMP,
    PRIMARY KEY (doctor_id, specialty_id)
);

-- Table: smart_health.DOCTOR_ADDRESSES
-- Brief: Doctor office or work addresses
CREATE TABLE IF NOT EXISTS smart_health.DOCTOR_ADDRESSES (
    doctor_address_id VARCHAR(50) PRIMARY KEY,
    doctor_id VARCHAR(50) NOT NULL,
    address_type VARCHAR(50),
    department VARCHAR(100),
    municipality VARCHAR(100),
    address_text VARCHAR(255),
    country_code VARCHAR(10),
    postal_code VARCHAR(20),
    office_hours VARCHAR(255)
);

-- Table: smart_health.DOCTOR_PHONES
-- Brief: Contact numbers for doctors
CREATE TABLE IF NOT EXISTS smart_health.DOCTOR_PHONES (
    doctor_phone_id VARCHAR(50) PRIMARY KEY,
    doctor_id VARCHAR(50) NOT NULL,
    phone_type VARCHAR(50),
    number VARCHAR(50) NOT NULL
);

-- Table: smart_health.DOCTOR_SCHEDULES
-- Brief: Weekly schedules for doctors
CREATE TABLE IF NOT EXISTS smart_health.DOCTOR_SCHEDULES (
    schedule_id VARCHAR(50) PRIMARY KEY,
    doctor_id VARCHAR(50) NOT NULL,
    weekday INT NOT NULL CHECK (weekday BETWEEN 1 AND 7),
    start_time TIME,
    end_time TIME,
    modality VARCHAR(50)
);

-- Table: smart_health.ROOMS
-- Brief: Rooms or consulting spaces
CREATE TABLE IF NOT EXISTS smart_health.ROOMS (
    room_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255)
);

-- Table: smart_health.APPOINTMENTS
-- Brief: Medical appointments registry
CREATE TABLE IF NOT EXISTS smart_health.APPOINTMENTS (
    appointment_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    doctor_id VARCHAR(50) NOT NULL,
    room_id VARCHAR(50),
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME,
    type VARCHAR(50),
    status VARCHAR(50),
    reason TEXT,
    created_by VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: smart_health.DIAGNOSES
-- Brief: Catalog of diagnoses
CREATE TABLE IF NOT EXISTS smart_health.DIAGNOSES (
    diagnosis_id VARCHAR(50) PRIMARY KEY,
    icd_code VARCHAR(20),
    description TEXT
);

-- Table: smart_health.MEDICATIONS
-- Brief: Drug catalog
CREATE TABLE IF NOT EXISTS smart_health.MEDICATIONS (
    medication_id VARCHAR(50) PRIMARY KEY,
    atc_code VARCHAR(20),
    brand_name VARCHAR(100),
    active_ingredient VARCHAR(100),
    presentation VARCHAR(100)
);

-- Table: smart_health.PROCEDURES
-- Brief: Clinical procedure catalog
CREATE TABLE IF NOT EXISTS smart_health.PROCEDURES (
    procedure_id VARCHAR(50) PRIMARY KEY,
    code VARCHAR(20),
    description TEXT,
    reference_price DECIMAL(10,2)
);

-- Table: smart_health.CLINICAL_HISTORIES
-- Brief: Patient medical histories
CREATE TABLE IF NOT EXISTS smart_health.CLINICAL_HISTORIES (
    history_id VARCHAR(50) PRIMARY KEY,
    appointment_id VARCHAR(50) NOT NULL,
    patient_id VARCHAR(50) NOT NULL,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    kind VARCHAR(50),
    summary_text TEXT,
    summary_json TEXT,
    author_id VARCHAR(50),
    main_diagnosis_id VARCHAR(50)
);

-- Table: smart_health.HISTORY_DIAGNOSES
-- Brief: Diagnoses linked to each clinical history
CREATE TABLE IF NOT EXISTS smart_health.HISTORY_DIAGNOSES (
    history_id VARCHAR(50) NOT NULL,
    diagnosis_id VARCHAR(50) NOT NULL,
    rank INT,
    certainty VARCHAR(50),
    PRIMARY KEY (history_id, diagnosis_id)
);

-- Table: smart_health.PRESCRIPTIONS
-- Brief: Prescriptions generated in medical care
CREATE TABLE IF NOT EXISTS smart_health.PRESCRIPTIONS (
    prescription_id VARCHAR(50) PRIMARY KEY,
    history_id VARCHAR(50) NOT NULL,
    medication_id VARCHAR(50) NOT NULL,
    dosage VARCHAR(50),
    frequency VARCHAR(50),
    route VARCHAR(50),
    duration VARCHAR(50),
    notes TEXT
);

-- Table: smart_health.VITAL_SIGNS
-- Brief: Vital signs recorded during patient care
CREATE TABLE IF NOT EXISTS smart_health.VITAL_SIGNS (
    vital_id VARCHAR(50) PRIMARY KEY,
    history_id VARCHAR(50) NOT NULL,
    kind VARCHAR(50),
    value DECIMAL(6,2),
    unit VARCHAR(20),
    measured_at TIMESTAMP
);

-- Table: smart_health.HISTORY_PROCEDURES
-- Brief: Procedures performed in clinical histories
CREATE TABLE IF NOT EXISTS smart_health.HISTORY_PROCEDURES (
    history_id VARCHAR(50) NOT NULL,
    procedure_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (history_id, procedure_id)
);

-- Table: smart_health.INSURERS
-- Brief: Insurance companies
CREATE TABLE IF NOT EXISTS smart_health.INSURERS (
    insurer_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    contact VARCHAR(150)
);

-- Table: smart_health.POLICIES
-- Brief: Medical insurance policies
CREATE TABLE IF NOT EXISTS smart_health.POLICIES (
    policy_id VARCHAR(50) PRIMARY KEY,
    patient_id VARCHAR(50) NOT NULL,
    insurer_id VARCHAR(50) NOT NULL,
    policy_number VARCHAR(100),
    coverage_summary TEXT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(50)
);

-- Table: smart_health.AUDIT_LOGS
-- Brief: System audit registry
CREATE TABLE IF NOT EXISTS smart_health.AUDIT_LOGS (
    audit_id VARCHAR(50) PRIMARY KEY,
    user_id VARCHAR(50),
    role VARCHAR(50),
    entity VARCHAR(100),
    entity_id VARCHAR(50),
    action VARCHAR(50),
    detail_json TEXT,
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip VARCHAR(50),
    app VARCHAR(100)
);

-- ##################################################
-- #            RELATIONSHIP DEFINITIONS            #
-- ##################################################

-- Relationships for PATIENT_DOCUMENTS
ALTER TABLE smart_health.PATIENT_DOCUMENTS ADD CONSTRAINT fk_documents_patients 
    FOREIGN KEY (patient_id) REFERENCES smart_health.PATIENTS (patient_id);
ALTER TABLE smart_health.PATIENT_DOCUMENTS ADD CONSTRAINT fk_documents_types 
    FOREIGN KEY (document_type_id) REFERENCES smart_health.DOCUMENT_TYPES (document_type_id);

-- Relationships for ADDRESSES, PHONES, CONTACTS
ALTER TABLE smart_health.PATIENT_ADDRESSES ADD CONSTRAINT fk_addresses_patients 
    FOREIGN KEY (patient_id) REFERENCES smart_health.PATIENTS (patient_id);
ALTER TABLE smart_health.PATIENT_PHONES ADD CONSTRAINT fk_phones_patients 
    FOREIGN KEY (patient_id) REFERENCES smart_health.PATIENTS (patient_id);
ALTER TABLE smart_health.EMERGENCY_CONTACTS ADD CONSTRAINT fk_contacts_patients 
    FOREIGN KEY (patient_id) REFERENCES smart_health.PATIENTS (patient_id);

-- Relationships for DOCTORS
ALTER TABLE smart_health.DOCTOR_SPECIALTIES ADD CONSTRAINT fk_doctor_specialties_doctors 
    FOREIGN KEY (doctor_id) REFERENCES smart_health.DOCTORS (doctor_id);
ALTER TABLE smart_health.DOCTOR_SPECIALTIES ADD CONSTRAINT fk_doctor_specialties_specialties 
    FOREIGN KEY (specialty_id) REFERENCES smart_health.SPECIALTIES (specialty_id);
ALTER TABLE smart_health.DOCTOR_ADDRESSES ADD CONSTRAINT fk_doctor_addresses_doctors 
    FOREIGN KEY (doctor_id) REFERENCES smart_health.DOCTORS (doctor_id);
ALTER TABLE smart_health.DOCTOR_PHONES ADD CONSTRAINT fk_doctor_phones_doctors 
    FOREIGN KEY (doctor_id) REFERENCES smart_health.DOCTORS (doctor_id);
ALTER TABLE smart_health.DOCTOR_SCHEDULES ADD CONSTRAINT fk_doctor_schedules_doctors 
    FOREIGN KEY (doctor_id) REFERENCES smart_health.DOCTORS (doctor_id);

-- Relationships for APPOINTMENTS
ALTER TABLE smart_health.APPOINTMENTS ADD CONSTRAINT fk_appointments_patients 
    FOREIGN KEY (patient_id) REFERENCES smart_health.PATIENTS (patient_id);
ALTER TABLE smart_health.APPOINTMENTS ADD CONSTRAINT fk_appointments_doctors 
    FOREIGN KEY (doctor_id) REFERENCES smart_health.DOCTORS (doctor_id);
ALTER TABLE smart_health.APPOINTMENTS ADD CONSTRAINT fk_appointments_rooms 
    FOREIGN KEY (room_id) REFERENCES smart_health.ROOMS (room_id);

-- Relationships for CLINICAL_HISTORIES
ALTER TABLE smart_health.CLINICAL_HISTORIES ADD CONSTRAINT fk_histories_appointments 
    FOREIGN KEY (appointment_id) REFERENCES smart_health.APPOINTMENTS (appointment_id);
ALTER TABLE smart_health.CLINICAL_HISTORIES ADD CONSTRAINT fk_histories_patients 
    FOREIGN KEY (patient_id) REFERENCES smart_health.PATIENTS (patient_id);
ALTER TABLE smart_health.CLINICAL_HISTORIES ADD CONSTRAINT fk_histories_authors 
    FOREIGN KEY (author_id) REFERENCES smart_health.DOCTORS (doctor_id);
ALTER TABLE smart_health.CLINICAL_HISTORIES ADD CONSTRAINT fk_histories_diagnoses 
    FOREIGN KEY (main_diagnosis_id) REFERENCES smart_health.DIAGNOSES (diagnosis_id);

-- Relationships for secondary entities
ALTER TABLE smart_health.HISTORY_DIAGNOSES ADD CONSTRAINT fk_history_diagnoses_histories 
    FOREIGN KEY (history_id) REFERENCES smart_health.CLINICAL_HISTORIES (history_id);
ALTER TABLE smart_health.HISTORY_DIAGNOSES ADD CONSTRAINT fk_history_diagnoses_diagnoses 
    FOREIGN KEY (diagnosis_id) REFERENCES smart_health.DIAGNOSES (diagnosis_id);
ALTER TABLE smart_health.PRESCRIPTIONS ADD CONSTRAINT fk_prescriptions_histories 
    FOREIGN KEY (history_id) REFERENCES smart_health.CLINICAL_HISTORIES (history_id);
ALTER TABLE smart_health.PRESCRIPTIONS ADD CONSTRAINT fk_prescriptions_medications 
    FOREIGN KEY (medication_id) REFERENCES smart_health.MEDICATIONS (medication_id);
ALTER TABLE smart_health.VITAL_SIGNS ADD CONSTRAINT fk_vitals_histories 
    FOREIGN KEY (history_id) REFERENCES smart_health.CLINICAL_HISTORIES (history_id);
ALTER TABLE smart_health.HISTORY_PROCEDURES ADD CONSTRAINT fk_history_procedures_histories 
    FOREIGN KEY (history_id) REFERENCES smart_health.CLINICAL_HISTORIES (history_id);
ALTER TABLE smart_health.HISTORY_PROCEDURES ADD CONSTRAINT fk_history_procedures_procedures 
    FOREIGN KEY (procedure_id) REFERENCES smart_health.PROCEDURES (procedure_id);
ALTER TABLE smart_health.POLICIES ADD CONSTRAINT fk_policies_patients 
    FOREIGN KEY (patient_id) REFERENCES smart_health.PATIENTS (patient_id);
ALTER TABLE smart_health.POLICIES ADD CONSTRAINT fk_policies_insurers 
    FOREIGN KEY (insurer_id) REFERENCES smart_health.INSURERS (insurer_id);

-- ##################################################
-- #               END DOCUMENTATION                #
-- ##################################################
