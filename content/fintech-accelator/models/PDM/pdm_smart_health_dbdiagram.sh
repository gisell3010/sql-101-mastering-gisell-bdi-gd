#!/usr/bin/env bash
# Smart Health - dbdiagram (formato del ejemplo fintech)
# Genera: smart_health.dbdiagram

set -euo pipefail
outfile="smart_health.dbdiagram"

cat > "$outfile" <<'DBD'
// Smart Health - dbdiagram Syntax
// link: https://dbdiagram.io/ (estilo tomado del ejemplo fintech)

// ---------- Core ----------
Table smart_health.PATIENTS {
  patient_id varchar(50) [pk]
  first_name varchar(100)
  middle_name varchar(100)
  first_surname varchar(100)
  second_surname varchar(100)
  birth_date date
  sex varchar(20)
  email varchar(255)
  registration_ts timestamp
  active boolean
}

Table smart_health.DOCUMENT_TYPES {
  document_type_id varchar(50) [pk]
  name varchar(100)
  description varchar(255)
}

Table smart_health.PATIENT_DOCUMENTS {
  document_number varchar(100) [pk]
  issuing_country varchar(50)
  patient_id varchar(50) [ref: > smart_health.PATIENTS.patient_id]
  document_type_id varchar(50) [ref: > smart_health.DOCUMENT_TYPES.document_type_id]
  issue_date date
}

Table smart_health.PATIENT_ADDRESSES {
  address_id varchar(50) [pk]
  patient_id varchar(50) [ref: > smart_health.PATIENTS.patient_id]
  address_type varchar(50)
  department varchar(100)
  municipality varchar(100)
  address_text varchar(255)
  latitude decimal(10,6)
  longitude decimal(10,6)
  postal_code varchar(20)
}

Table smart_health.PATIENT_PHONES {
  phone_id varchar(50) [pk]
  patient_id varchar(50) [ref: > smart_health.PATIENTS.patient_id]
  phone_type varchar(50)
  number varchar(50)
  is_primary boolean
}

Table smart_health.EMERGENCY_CONTACTS {
  contact_id varchar(50) [pk]
  patient_id varchar(50) [ref: > smart_health.PATIENTS.patient_id]
  name varchar(150)
  relationship varchar(100)
  phone varchar(50)
  email varchar(255)
  instructions varchar(255)
}

// ---------- Doctors & Schedules ----------
Table smart_health.DOCTORS {
  doctor_id varchar(50) [pk]
  internal_code varchar(50)
  medical_license varchar(100)
  first_name varchar(100)
  last_name varchar(100)
  professional_email varchar(255)
  hire_date date
  active boolean
}

Table smart_health.DOCTOR_SCHEDULES {
  schedule_id varchar(50) [pk]
  doctor_id varchar(50) [ref: > smart_health.DOCTORS.doctor_id]
  weekday int
  start_time time
  end_time time
  modality varchar(50)
}

Table smart_health.ROOMS {
  room_id varchar(50) [pk]
  name varchar(100)
  location varchar(255)
}

// ---------- Appointments ----------
Table smart_health.APPOINTMENTS {
  appointment_id varchar(50) [pk]
  patient_id varchar(50) [ref: > smart_health.PATIENTS.patient_id]
  doctor_id varchar(50) [ref: > smart_health.DOCTORS.doctor_id]
  room_id varchar(50) [ref: > smart_health.ROOMS.room_id]
  date date
  start_time time
  end_time time
  visit_type varchar(100)
  status varchar(50)
  reason varchar(255)
  created_by varchar(100)
  creation_date timestamp
}

// ---------- Clinical Records ----------
Table smart_health.DIAGNOSES {
  diagnosis_id varchar(50) [pk]
  icd_code varchar(20)
  description varchar(255)
}

Table smart_health.MEDICAL_RECORDS {
  record_id varchar(50) [pk]
  patient_id varchar(50) [ref: > smart_health.PATIENTS.patient_id]
  appointment_id varchar(50) [ref: > smart_health.APPOINTMENTS.appointment_id]
  registration_date timestamp
  record_type varchar(100)
  text_summary text
  structured_data json
  professional_id varchar(50) [ref: > smart_health.DOCTORS.doctor_id]  // autor principal (opcional)
  primary_diagnosis_id varchar(50) [ref: > smart_health.DIAGNOSES.diagnosis_id]
}

Table smart_health.MEDICAL_RECORD_REGISTERS {   // N:M doctors <-> medical_records
  doctor_id varchar(50) [ref: > smart_health.DOCTORS.doctor_id]
  record_id varchar(50) [ref: > smart_health.MEDICAL_RECORDS.record_id]
}

Table smart_health.MEDICAL_RECORD_DIAGNOSES {   // N:M medical_records <-> diagnoses
  record_id varchar(50) [ref: > smart_health.MEDICAL_RECORDS.record_id]
  diagnosis_id varchar(50) [ref: > smart_health.DIAGNOSES.diagnosis_id]
  rank int
  certainty varchar(50)
}

Table smart_health.MEDICATIONS {
  medication_id varchar(50) [pk]
  atc_code varchar(20)
  trade_name varchar(150)
  active_ingredient varchar(150)
  presentation varchar(150)
}

Table smart_health.PRESCRIPTIONS {
  prescription_id varchar(50) [pk]
  record_id varchar(50) [ref: > smart_health.MEDICAL_RECORDS.record_id]
  medication_id varchar(50) [ref: > smart_health.MEDICATIONS.medication_id]
  dosage varchar(100)
  frequency varchar(100)
  route varchar(50)
  duration varchar(100)
  notes varchar(255)
}

Table smart_health.VITAL_SIGNS {
  vital_id varchar(50) [pk]
  record_id varchar(50) [ref: > smart_health.MEDICAL_RECORDS.record_id]
  kind varchar(100)
  value decimal(12,4)
  unit varchar(50)
  measured_at timestamp
}

Table smart_health.PROCEDURES {
  procedure_id varchar(50) [pk]
  code varchar(50)
  description varchar(255)
  reference_price decimal(12,2)
}

Table smart_health.MEDICAL_RECORD_PROCEDURES {  // N:M medical_records <-> procedures
  record_id varchar(50) [ref: > smart_health.MEDICAL_RECORDS.record_id]
  procedure_id varchar(50) [ref: > smart_health.PROCEDURES.procedure_id]
}

// ---------- Insurers & Policies ----------
Table smart_health.INSURERS {
  insurer_id varchar(50) [pk]
  name varchar(150)
  contact_info varchar(255)
}

Table smart_health.POLICIES {
  policy_id varchar(50) [pk]
  patient_id varchar(50) [ref: > smart_health.PATIENTS.patient_id]
  insurer_id varchar(50) [ref: > smart_health.INSURERS.insurer_id]
  policy_number varchar(100)
  coverage_summary varchar(255)
  start_date date
  end_date date
  status varchar(50)
}

// ---------- Auditing ----------
Table smart_health.AUDIT_LOGS {
  audit_id varchar(50) [pk]
  user_id varchar(50)
  role varchar(50)
  entity varchar(100)
  entity_id varchar(50)
  action varchar(50)
  detail text
  timestamp timestamp
  ip varchar(50)
  application varchar(100)
}
DBD