-- ##################################################
-- #          SMART HEALTH ALTER TABLE SCRIPT        #
-- ##################################################
-- This script applies structural improvements and additional
-- constraints to the Smart Health database, enhancing data
-- integrity, validation, and performance through indexes and
-- constraints on key entities.

-- ##################################################
-- #                   ALTERATIONS                  #
-- ##################################################

-- STEP 1: Add a UNIQUE constraint to ensure no duplicate email addresses for doctors
ALTER TABLE smart_health.DOCTORS
ADD CONSTRAINT uq_doctors_work_email UNIQUE (work_email);

COMMENT ON CONSTRAINT uq_doctors_work_email ON smart_health.DOCTORS IS 'Garantiza que no existan correos electrónicos repetidos entre los médicos.';

-- STEP 2: Add CHECK constraint for appointment status
ALTER TABLE smart_health.APPOINTMENTS
ADD CONSTRAINT chk_appointment_status CHECK (status IN ('Scheduled', 'Completed', 'Cancelled', 'No-show'));

COMMENT ON CONSTRAINT chk_appointment_status ON smart_health.APPOINTMENTS IS 'Restringe el estado de la cita médica a valores válidos predefinidos.';

-- STEP 3: Add CHECK constraint for patient gender
ALTER TABLE smart_health.PATIENTS
ADD CONSTRAINT chk_patient_sex CHECK (sex IN ('Male', 'Female', 'Other'));

COMMENT ON CONSTRAINT chk_patient_sex ON smart_health.PATIENTS IS 'Define los valores permitidos para el campo sexo del paciente.';

-- STEP 4: Add CHECK constraint for clinical history kind
ALTER TABLE smart_health.CLINICAL_HISTORIES
ADD CONSTRAINT chk_history_kind CHECK (kind IN ('Consultation', 'Emergency', 'Follow-up', 'Surgery'));

COMMENT ON CONSTRAINT chk_history_kind ON smart_health.CLINICAL_HISTORIES IS 'Define los tipos válidos de historia clínica registrados en el sistema.';

-- STEP 5: Add a column to track the last update timestamp for clinical histories
ALTER TABLE smart_health.CLINICAL_HISTORIES
ADD COLUMN last_update_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

COMMENT ON COLUMN smart_health.CLINICAL_HISTORIES.last_update_ts IS 'Marca la fecha y hora de la última actualización en la historia clínica.';

-- STEP 6: Add CHECK constraint to ensure policy validity dates
ALTER TABLE smart_health.POLICIES
ADD CONSTRAINT chk_policy_dates CHECK (start_date <= end_date);

COMMENT ON CONSTRAINT chk_policy_dates ON smart_health.POLICIES IS 'Asegura que la fecha de inicio de la póliza sea anterior o igual a la fecha de finalización.';

-- STEP 7: Create an index for faster appointment lookups by doctor and date
CREATE INDEX idx_appointments_doctor_date 
ON smart_health.APPOINTMENTS (doctor_id, date);

COMMENT ON INDEX idx_appointments_doctor_date IS 'Optimiza las consultas de citas por médico y fecha.';

-- STEP 8: Create an index for patient last names
CREATE INDEX idx_patients_last_name 
ON smart_health.PATIENTS (first_surname, second_surname);

COMMENT ON INDEX idx_patients_last_name IS 'Mejora la búsqueda de pacientes por apellidos.';

-- STEP 9: Add CHECK constraint for positive reference price in procedures
ALTER TABLE smart_health.PROCEDURES
ADD CONSTRAINT chk_procedure_price CHECK (reference_price >= 0);

COMMENT ON CONSTRAINT chk_procedure_price ON smart_health.PROCEDURES IS 'Verifica que el precio de referencia del procedimiento no sea negativo.';

-- STEP 10: Add a column to track appointment confirmation timestamp
ALTER TABLE smart_health.APPOINTMENTS
ADD COLUMN confirmed_at TIMESTAMP;

COMMENT ON COLUMN smart_health.APPOINTMENTS.confirmed_at IS 'Fecha y hora en que la cita fue confirmada.';

-- ##################################################
-- #                 END OF SCRIPT                  #
-- ##################################################
