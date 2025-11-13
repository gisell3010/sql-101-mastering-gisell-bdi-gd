-- 1. Listar todos los pacientes de género femenino registrados en el sistema,
-- mostrando su nombre completo, correo electrónico y fecha de nacimiento,
-- ordenados por apellido de forma ascendente.

SELECT
    first_name||' '||COALESCE(middle_name, '')||' '||first_surname||' '||COALESCE(second_surname, '') AS paciente,
    email AS correo_electronico,
    birth_date AS fecha_nacimiento
FROM smart_health.patients
WHERE gender = 'F'
ORDER BY first_surname
LIMIT 5;

SELECT
    CONCAT(first_name, ' ', middle_name, ' ', first_surname, ' ', second_surname) AS paciente,
    email,
    birth_date
FROM smart_health.patients
WHERE gender = 'F'
ORDER BY first_surname
LIMIT 5;
--              paciente             |             email              | birth_date
-- ----------------------------------+--------------------------------+------------
--  Camila  Aguirre Gómez            | camila.aguirre@unipamplona.com | 1965-04-24
--  Valeria  Aguirre Mora            | valeria.aguirre@protonmail.com | 1979-04-12
--  Adriana Alejandra Aguirre León   | adriana.aguirre@protonmail.com | 1983-12-02
--  Mariana Alejandra Aguirre Rivera | mariana.aguirre@gmail.com      | 1969-04-12
--  Lorena  Aguirre López            | lorena.aguirre@outlook.com     | 1969-02-15
-- (5 filas)



-- 2. Consultar todos los médicos que ingresaron al hospital después del año 2020,
-- mostrando su código interno, nombre completo y fecha de admisión,
-- ordenados por fecha de ingreso de más reciente a más antiguo.
SELECT
    internal_code,
    first_name||' '||last_name AS doctor,
    hospital_admission_date
FROM smart_health.doctors 
WHERE hospital_admission_date > '2020-12-31'
ORDER BY hospital_admission_date DESC
LIMIT 5;
--  internal_code |       doctor       | hospital_admission_date
-- ---------------+--------------------+-------------------------
--  DOC-2RU1E3    | Santiago Hernández | 2025-12-31
--  DOC-CNI9UC    | Adriana Reyes      | 2025-12-30
--  DOC-KRA74R    | Julián Pérez       | 2025-12-27
--  DOC-2WBYI5    | Carolina Rincón    | 2025-12-25
--  DOC-W2ZHB2    | Valentina Aguirre  | 2025-12-24
-- (5 filas)



-- 3. Obtener todas las citas médicas con estado 'Scheduled' (Programada),
-- mostrando la fecha, hora de inicio y motivo de la consulta,
-- ordenadas por fecha y hora de manera ascendente.
SELECT
    appointment_date,
    start_time,
    reason
FROM smart_health.appointments
WHERE status = 'Scheduled'
ORDER BY appointment_date, start_time
LIMIT 5;
--  appointment_date | start_time |                reason
-- ------------------+------------+--------------------------------------
--  2020-01-01       | 07:00:00   | Control de presión arterial.
--  2020-01-01       | 08:00:00   | Asesoría nutricional.
--  2020-01-01       | 09:15:00   | Asesoría nutricional.
--  2020-01-01       | 09:30:00   | Consulta por síntomas respiratorios.
--  2020-01-01       | 10:00:00   | Consulta por síntomas respiratorios.
-- (5 filas)



-- 4. Listar todos los medicamentos cuyo nombre comercial comience con la letra 'A',
-- mostrando el código ATC, nombre comercial y principio activo,
-- ordenados alfabéticamente por nombre comercial.
SELECT
    atc_code,
    commercial_name,
    active_ingredient
FROM smart_health.medications
WHERE commercial_name LIKE 'A%'
ORDER BY commercial_name;
--LIMIT 5;
--  atc_code |      commercial_name      | active_ingredient
-- ----------+---------------------------+-------------------
--  C07AA05  | ACEBUTALOL MK             | ACEBUTALOL
--  B01AA07  | ACENOCUMAROL MK           | ACENOCUMAROL
--  S01AX03  | ACETATO DE HIDROCORTISONA | HIDROCORTISONA
--  R05CB06  | ACETILCISTEÍNA GENÉRICO   | ACETILCISTEÍNA
--  R05CB01  | ACETILCISTEÍNA MK         | ACETILCISTEÍNA
-- (5 filas)



-- 5. Consultar todos los diagnósticos que contengan la palabra 'diabetes' en su descripción,
-- mostrando el código CIE-10 y la descripción completa,
-- ordenados por código de diagnóstico.
SELECT
    icd_code,
    description
FROM smart_health.diagnoses
WHERE description LIKE '%DIABETES%'
ORDER BY icd_code;
--LIMIT 5;
--  icd_code |                                                         description                                                       
-- ----------+------------------------------------------------------------------------------------------------------------------------------
--  E0800    | DIABETES MELLITUS DEBIDA A AFECCIÓN SUBYACENTE CON HIPEROSMOLARIDAD SIN COMA HIPERGLUCÉMICO HIPEROSMOLAR NO CETÓSICO (CHHNC)
--  E0801    | DIABETES MELLITUS DEBIDA A AFECCIÓN SUBYACENTE CON HIPEROSMOLARIDAD CON COMA
--  E0810    | DIABETES MELLITUS DEBIDA A AFECCIÓN SUBYACENTE CON CETOACIDOSIS SIN COMA
--  E0811    | DIABETES MELLITUS DEBIDA A AFECCIÓN SUBYACENTE CON CETOACIDOSIS CON COMA
--  E0821    | DIABETES MELLITUS DEBIDA A AFECCIÓN SUBYACENTE CON NEFROPATÍA DIABÉTICA
-- (5 filas)



-- 6. Listar todas las salas de atención activas del hospital con capacidad mayor a 5 personas,
-- mostrando el nombre, tipo y ubicación de cada sala,
-- ordenadas por capacidad de mayor a menor.
SELECT
    room_name,
    room_type,
    location
FROM smart_health.rooms
WHERE active = TRUE
AND capacity > 5
ORDER BY capacity DESC
LIMIT 5;
--  room_name |    room_type    |     location
-- -----------+-----------------+-------------------
--  Sala-0001 | Hospitalización | Torre Norte - 379
--  Sala-0214 | Hospitalización | Edificio B - 486
--  Sala-0175 | Hospitalización | Torre Sur - 167
--  Sala-0038 | Emergencia      | Torre Norte - 114
--  Sala-0060 | Hospitalización | Piso 3 - 446
-- (5 filas)



-- 7. Obtener todos los pacientes que tienen tipo de sangre O+ o O-,
-- mostrando su nombre completo, tipo de sangre y fecha de nacimiento,
-- ordenados por tipo de sangre y luego por apellido.
SELECT
    first_name||' '||COALESCE(middle_name, '')||' '||first_surname||' '||COALESCE(second_surname, '') AS nombre_completo,
    blood_type,
    birth_date
FROM smart_health.patients
WHERE blood_type IN ('O+', 'O-')
ORDER BY blood_type, first_surname
LIMIT 5;
--           nombre_completo           | blood_type | birth_date
-- ------------------------------------+------------+------------
--  Camila  Aguirre Mora               | O-         | 1963-09-27
--  Rodrigo Armando Aguirre            | O-         | 1973-01-18
--  Valentina Estefanía Aguirre Molina | O-         | 2000-12-16
--  Isabel Cristina Aguirre Peña       | O-         | 1991-12-14
--  Sara  Aguirre Hernández            | O-         | 1970-05-30
-- (5 filas)



-- 8. Consultar todas las direcciones activas ubicadas en un municipio específico,
-- mostrando la línea de dirección, código postal y código del municipio,
-- ordenadas por código postal.
SELECT
    T1.address_line,
    T1.postal_code,
    T1.municipality_code
FROM smart_health.addresses T1
INNER JOIN smart_health.municipalities T2
    ON T1.municipality_code = T2.municipality_code
WHERE T1.active = TRUE
AND T2.municipality_name = 'PAMPLONA'
ORDER BY T1.postal_code;

smarthdb=> SELECT
smarthdb->     T1.address_line,
smarthdb->     T1.postal_code,
smarthdb->     T1.municipality_code
smarthdb-> FROM smart_health.addresses T1
smarthdb-> INNER JOIN smart_health.municipalities T2
smarthdb->     ON T1.municipality_code = T2.municipality_code
smarthdb-> WHERE T1.active = TRUE
smarthdb-> AND T2.municipality_name = 'PAMPLONA'
smarthdb-> ORDER BY T1.postal_code;
--                                address_line                                | postal_code | municipality_code
-- ---------------------------------------------------------------------------+-------------+-------------------
--  Limite Urbano - Urbano - Cl 59                                            | 052020      | 54518
--  Dg 5 - Cl 4 - Urbano                                                      | 055421      | 54518
--  Limite Urbano - Limite Urbano                                             | 055438      | 54518
--  Limite Urbano - Urbano                                                    | 056017      | 54518
--  Urbano - Limite Urbano - Limite Urbano                                    | 080001      | 54518
--  Rural - Vía San A. Sotavento-Chinu                                        | 083010      | 54518
--  Municipio Cienaga - Mar Caribe                                            | 110561      | 54518
--  Cl 1 - Cl 28 - Urbano                                                     | 133517      | 54518
--  Municipio Puerto Boyaca - Mpio. Paime Y Topaipí                           | 151001      | 54518
--  Municipio Teorama - Municipio Abrego                                      | 153827      | 54518
--  Municipio Leguizamo - M. La Montañita, Milán Y Valparaiso                 | 154401      | 54518
--  Rural - Vía Zapatoca-Los Santos                                           | 154848      | 54518
--  Limite Urbano - Limite Urbano - Urbano                                    | 191001      | 54518
--  Rural - Municipio Soacha                                                  | 191520      | 54518
--  Río (Permanente) - Rural - Municipio Otanche                              | 192570      | 54518
--  Río Sayán Boky Y Mpio. El Carmen - Rural - Quebrada Trinidad              | 201030      | 54518
--  Urbano - Limite Urbano - Limite Urbano                                    | 202001      | 54518
--  Municipio Puerto Colombia - Rural - Río Inírida                           | 234001      | 54518
--  Vía S/Der. De Quilichao-Natala - M. S. De Quilichao Y Jambaló - Rural     | 250208      | 54518
--  Limite Urbano - Urbano                                                    | 251238      | 54518
--  Urbano - Limite Urbano                                                    | 251401      | 54518
--  Río (Permanente) - Rural                                                  | 252010      | 54518
--  Rural - Vía Caldas - Chiquinquira - Saboya                                | 270008      | 54518
--  Limite Urbano - Urbano - Limite Urbano                                    | 272020      | 54518
--  Municipio Aguazul - Rural - Municipio Aquitania                           | 411027      | 54518
--  Municipio Choachí - M. Chipaque Y Cáqueza - Rural                         | 412067      | 54518
--  Rural - Municipio Jericó - Río Pauto Y (Permanente)                       | 414047      | 54518
--  Rural - Vía San Luis De Gaceno-Monterrey - Municipio Páez                 | 415060      | 54518
--  C/Tera Cord. Y Ac Caldas - Kr 1                                           | 477007      | 54518
--  Limite Urbano - Urbano - Limite Urbano                                    | 501017      | 54518
--  Limite Urbano - Urbano - Limite Urbano                                    | 501021      | 54518
--  Municipio Aracataca - Mpio. Algarrobo Y El Copey - Rural                  | 507019      | 54518
--  Rural - Río Piescuestano                                                  | 507047      | 54518
--  Limite Urbano - Cl 3                                                      | 526529      | 54518
--  Rural - M. San V. Del Caguán Y Puerto Rico - M. Rivera Y Campoalegre      | 527039      | 54518
--  Rural - M. Fómeque Y San Juanito - Municipio Villavicencio                | 540004      | 54518
--  Municipio Pamplonita - Rural                                              | 681031      | 54518
--  Río (Permanente) - Rural - Mpio. Aquitania Y Recetor                      | 682048      | 54518
-- -- Más  --



-- [NO REALIZAR]
-- 9. Listar todas las prescripciones médicas realizadas en los últimos 30 días,
-- mostrando la dosis, frecuencia y duración del tratamiento,
-- ordenadas por fecha de prescripción de más reciente a más antigua.
SELECT
    dosage,
    frequency,
    duration,
    prescription_date
FROM smart_health.prescriptions
WHERE prescription_date >= NOW() - INTERVAL '30 days'
ORDER BY prescription_date DESC;
--    dosage   |    frequency     |  duration
-- ------------+------------------+------------
--  5 mg       | Cada 6 horas     | 10 días
--  10 mg      | Antes de dormir  | 7 días
--  1 ampolla  | Dos veces al día | 1 mes
--  2 cápsulas | Antes de dormir  | 5 días
--  250 mg     | Cada 8 horas     | 10 días
--  100 mg     | Antes de dormir  | Indefinido
--  5 mg       | Dos veces al día | 3 meses
--  100 mg     | Cada 6 horas     | Indefinido
--  200 mg     | Cada 6 horas     | 15 días
--  1 ampolla  | Cada 8 horas     | 15 días
--  20 mg      | Según necesidad  | 5 días
--  200 mg     | Según necesidad  | 1 mes
--  200 mg     | Una vez al día   | 15 días
--  10 mg      | Una vez al día   | 5 días
--  100 mg     | Según necesidad  | 5 días
--  1 tableta  | Cada 24 horas    | 10 días
--  1 tableta  | Cada 12 horas    | 1 mes
--  200 mg     | Cada 12 horas    | 3 meses
--  1 tableta  | Una vez al día   | 3 meses
--  1 ampolla  | Una vez al día   | 5 días
--  250 mg     | Antes de dormir  | Indefinido
--  2 cápsulas | Dos veces al día | 1 mes
--  1 tableta  | Cada 8 horas     | 10 días
--  10 mg      | Una vez al día   | 5 días
--  2 cápsulas | Cada 8 horas     | 1 mes
--  20 mg      | Cada 6 horas     | 10 días
--  1 tableta  | Antes de dormir  | 7 días
--  200 mg     | Cada 8 horas     | 10 días
--  20 mg      | Cada 6 horas     | 5 días
--  5 mg       | Cada 6 horas     | 1 mes
--  200 mg     | Según necesidad  | 5 días
--  100 mg     | Cada 24 horas    | 3 meses
--  250 mg     | Antes de dormir  | Indefinido
--  5 mg       | Cada 6 horas     | 7 días
--  500 mg     | Cada 12 horas    | 1 mes
--  1 tableta  | Cada 24 horas    | 10 días
--  2 cápsulas | Cada 12 horas    | 5 días
--  20 mg      | Una vez al día   | 1 mes
-- -- Más  --



-- [NO REALIZAR]
-- 10. Obtener todos los registros médicos de tipo 'historia inicial',
-- mostrando el resumen del registro, signos vitales y fecha de registro,
-- ordenados por fecha de registro descendente para visualizar los más recientes primero.
SELECT
    summary_text,
    vital_signs,
    registration_datetime
FROM smart_health.medical_records 
WHERE record_type = 'Historia Inicial'
ORDER BY registration_datetime DESC;



-- ##################################################
-- ##################################################
-- ##################################################



-- 1. Listar todos los pacientes con su tipo de documento correspondiente,
-- mostrando el nombre completo del paciente, número de documento y nombre del tipo de documento,
-- ordenados por apellido del paciente.
SELECT
    T1.first_name||' '||COALESCE(T1.middle_name, '')||' '||T1.first_surname||' '||COALESCE(T1.second_surname, '') AS paciente,
    T1.document_number AS numero_documento,
    T2.type_name AS tipo_documento

FROM smart_health.patients T1
INNER JOIN smart_health.document_types T2
    ON T1.document_type_id = T2.document_type_id
ORDER BY T1.first_surname
LIMIT 10; 


-- 2. Consultar todas las citas médicas con la información del paciente y del doctor asignado,
-- mostrando nombres completos, fecha y hora de la cita,
-- ordenadas por fecha de cita de forma descendente.

SELECT
    T2.first_name||' '||COALESCE(T2.middle_name, '')||' '||T2.first_surname||' '||COALESCE(T2.second_surname, '') AS paciente,
    T1.appointment_date AS fecha_cita,
    T1.start_time AS hora_inicio_cita,
    T1.end_time AS hora_fin_cita,
    'Dr. '||' '||T3.first_name||' '||COALESCE(T3.last_name, '') AS doctor_asignado,
    T3.internal_code AS codigo_medico

FROM smart_health.appointments T1
INNER JOIN smart_health.patients T2
    ON T1.patient_id = T2.patient_id
INNER JOIN smart_health.doctors T3
    ON T1.doctor_id = T3.doctor_id
ORDER BY T1.appointment_date DESC
LIMIT 10;


-- 3. Obtener todas las direcciones de pacientes con información completa del municipio y departamento,
-- mostrando el nombre del paciente, dirección completa y ubicación geográfica,
-- ordenadas por departamento y municipio.
SELECT
    T1.first_name||' '||COALESCE(T1.middle_name, '')||' '||T1.first_surname||' '||COALESCE(T1.second_surname, '') AS paciente,
    T3.address_line||', '||COALESCE(T3.postal_code, '') AS direccion_completa,
    T4.municipality_name||', '||T5.department_name AS ubicacion_geografica
FROM smart_health.patients T1
INNER JOIN smart_health.patient_addresses T2
    ON T1.patient_id = T2.patient_id
INNER JOIN smart_health.addresses T3
    ON T2.address_id = T3.address_id
INNER JOIN smart_health.municipalities T4
    ON T3.municipality_code = T4.municipality_code
INNER JOIN smart_health.departments T5
    ON T4.department_code = T5.department_code
ORDER BY T5.department_name, T4.municipality_name;
--LIMIT 5;
--           paciente          |                       direccion_completa                       | ubicacion_geografica
-- ----------------------------+----------------------------------------------------------------+----------------------
--  Manuel  Ramírez Pardo      | M. Girardot Y Ricaurte - Rural, 052828                         | LETICIA, AMAZONAS
--  Pedro Ángel Montoya Torres | M. Jamundí Y Villa Rica - Vía S. De Quilichao-Palomera, 524008 | LETICIA, AMAZONAS
--  Ricardo  Peña Rojas        | Rural - Río Cañas G. Y Relieve M. - Municipio Uramita, 201058  | LETICIA, AMAZONAS
--  Tatiana Isabel Reyes Díaz  | Urbano - Kr 28D, 055078                                        | LETICIA, AMAZONAS
--  Gabriela  Morales Rivera   | Urbano - Kr 28D, 055078                                        | LETICIA, AMAZONAS
-- (5 filas)



-- 4. Listar todos los médicos con sus especialidades asignadas,
-- mostrando el nombre del doctor, especialidad y fecha de certificación,
-- filtrando solo especialidades activas y ordenadas por apellido del médico.
SELECT
    T1.first_name||' '||T1.last_name AS doctor,
    T3.specialty_name,
    T2.certification_date
FROM smart_health.doctors T1
INNER JOIN smart_health.doctor_specialties T2
    ON T1.doctor_id = T2.doctor_id
INNER JOIN smart_health.specialties T3
    ON T2.specialty_id = T3.specialty_id
WHERE T2.is_active = TRUE
ORDER BY T1.last_name;
--        doctor        |           specialty_name            | certification_date
-- ---------------------+-------------------------------------+--------------------
--  Carlos Aguirre      | Medicina familiar y comunitaria     | 2014-01-01
--  Carlos Aguirre      | Psiquiatría                         | 2020-08-30
--  Manuel Aguirre      | Reumatología                        | 2006-04-14
--  Luis Aguirre        | Bioquímica clínica                  | 2018-09-15
--  Sebastián Aguirre   | Hepatología                         | 2009-11-12
--  Cristian Aguirre    | Alergología                         | 2005-12-15
--  Lorena Aguirre      | Odontología                         | 2020-10-25
--  Daniela Aguirre     | Endocrinología                      | 2004-09-30
--  Isabel Aguirre      | Hepatología                         | 2008-06-18
--  Natalia Aguirre     | Análisis clínico                    | 2020-05-19
--  Valentina Aguirre   | Hepatología                         | 2020-08-11
--  Hernán Aguirre      | Gastroenterología                   | 2010-04-17
--  Alejandro Aguirre   | Reumatología                        | 2021-09-05
--  María Aguirre       | Pediatría                           | 2015-05-23
--  Felipe Aguirre      | Alergología                         | 2022-08-23
--  Rafael Aguirre      | Toxicología                         | 2002-07-28
--  Juan Aguirre        | Angiología                          | 2007-07-21
--  Valentina Aguirre   | Genética                            | 2006-05-20
--  Valentina Aguirre   | Infectología                        | 2002-08-27
--  Adriana Aguirre     | Oncología médica                    | 2000-01-04
--  Alejandro Aguirre   | Infectología                        | 2016-04-27
--  Paola Aguirre       | Medicina de emergencia              | 2019-08-19
--  María Aguirre       | Medicina familiar y comunitaria     | 2010-08-25
--  Lorena Aguirre      | Oncología radioterápica             | 2025-05-07
--  Mónica Aguirre      | Auditoría médica                    | 2017-08-08
--  María Aguirre       | Medicina preventiva y salud pública | 2023-12-13
--  Julián Aguirre      | Medicina del trabajo                | 2002-02-09
-- -- Más  --



-- [NO REALIZAR]
-- 5. Consultar todas las alergias de pacientes con información del medicamento asociado,
-- mostrando el nombre del paciente, medicamento, severidad y descripción de la reacción,
-- filtrando solo alergias graves o críticas, ordenadas por severidad.
SELECT
    T1.first_name||' '||COALESCE(T1.middle_name, '')||' '||T1.first_surname||' '||COALESCE(T1.second_surname, '') AS paciente,
    T3.commercial_name,
    T2.severity,
    T2.reaction_description
FROM smart_health.patients T1
INNER JOIN smart_health.patient_allergies T2
    ON T1.patient_id = T2.patient_id
INNER JOIN smart_health.medications T3
    ON T2.medication_id = T3.medication_id
WHERE T2.severity IN('Grave', 'Crítica')
ORDER BY T2.severity;



-- [NO REALIZAR]
-- 6. Obtener todos los registros médicos con el diagnóstico principal asociado,
-- mostrando el paciente, doctor que registró, diagnóstico y fecha del registro,
-- filtrando registros del último año, ordenados por fecha de registro descendente.
SELECT
    T2.first_name||' '||COALESCE(T2.middle_name, '')||' '||T2.first_surname||' '||COALESCE(T2.second_surname, '') AS paciente,
    T3.first_name||' '||T3.last_name AS doctor,
    T5.description,
    T1.registration_datetime
FROM smart_health.medical_records T1
INNER JOIN smart_health.patients T2
    ON T1.patient_id = T2.patient_id
INNER JOIN smart_health.doctors T3
    ON T1.doctor_id = T3.doctor_id
INNER JOIN smart_health.record_diagnoses T4
    ON T1.medical_record_id = T4.medical_record_id
INNER JOIN smart_health.diagnoses T5
    ON T4.diagnosis_id = T5.diagnosis_id
WHERE T1.registration_datetime >= NOW() - INTERVAL '1 year'
    AND T4.diagnosis_type = 'Principal'
ORDER BY T1.registration_datetime DESC;
--                paciente               |       doctor        |                                                                                              description                                                                                               | registration_datetime
-- --------------------------------------+---------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------
--  Santiago  Ramírez Pardo              | Javier Mora         | DESGARRO LEVE DE ARTERIA CARÓTIDA DERECHA, SECUELA                                                                                                                                                     | 2025-12-30 17:36:53
--  Alejandro  Torres Pineda             | Andrés Suárez       | ROTURA TRAUMÁTICA DE LIGAMENTO RADIOCARPIANO IZQUIERDO, CONTACTO SUCESIVO                                                                                                                              | 2025-12-29 22:14:00
--  Alejandro  Torres Pineda             | Andrés Suárez       | FRACTURA FISARIA TIPO III DE SALTER HARRIS DE EXTREMO INFERIOR DE HÚMERO, EXTREMIDAD SUPERIOR IZQUIERDA, CONTACTO SUCESIVO POR FRACTURA CON FRACASO DE CONSOLIDACIÓN                                   | 2025-12-29 22:14:00
--  Ricardo Iván Martínez Medina         | Adriana Ortiz       | EXOTROPÍA MONOCULAR CON PATRÓN V, OJO DERECHO                                                                                                                                                          | 2025-12-29 22:04:35
--  Ricardo Iván Martínez Medina         | Adriana Ortiz       | OTRO TIPO DE ESGUINCE DEL PIE DERECHO, CONTACTO INICIAL                                                                                                                                                | 2025-12-29 22:04:35
--  Valentina  Morales Andrade           | Paola Vega          | OTROS RUIDOS INTESTINALES ANÓMALOS                                                                                                                                                                     | 2025-12-29 18:44:53
--  Lorena Cristina Jiménez Ramírez      | Adriana Vargas      | ENVENENAMIENTO POR OTROS ANALGÉSICOS NO OPIÁCEOS Y ANTIPIRÉTICOS, NO CLASIFICADOS BAJO OTRO CONCEPTO, AGRESIÓN, SECUELA                                                                                | 2025-12-29 17:20:38
--  Pedro  Vargas López                  | Mónica Reyes        | FRACTURA DESPLAZADA DE CUERPO DE CALCÁNEO IZQUIERDO, CONTACTO SUCESIVO POR FRACTURA CON UNIÓN DEFECTUOSA                                                                                               | 2025-12-29 06:21:15
--  Alejandro David León Morales         | Adriana Peña        | FRACTURA POR ESTALLIDO ESTABLE DE TERCERA VÉRTEBRA LUMBAR, CONTACTO SUCESIVO POR FRACTURA CON FRACASO DE CONSOLIDACIÓN                                                                                 | 2025-12-27 15:37:59
--  Alejandro David León Morales         | Adriana Peña        | CUERPO LIBRE INTRAARTICULAR, MUÑECA DERECHA                                                                                                                                                            | 2025-12-27 15:37:59
--  Alejandro David León Morales         | Adriana Peña        | NISTAGMO DISOCIADO                                                                                                                                                                                     | 2025-12-27 15:37:59
--  Julián Ricardo Ríos Rodríguez        | Alejandro Torres    | TRAUMATISMO DE NERVIO SENSITIVO CUTÁNEO A NIVEL DE TOBILLO Y PIE, PIERNA NO ESPECIFICADA, CONTACTO INICIAL                                                                                             | 2025-12-27 11:23:04
--  Julián Ricardo Ríos Rodríguez        | Alejandro Torres    | OTROS TRASTORNOS DE DESARROLLO Y CRECIMIENTO DE HUESO, HOMBRO IZQUIERDO                                                                                                                                | 2025-12-27 11:23:04
--  Alejandro  Pardo Pineda              | Miguel Pineda       | OTRO TRAUMATISMO DE OTROS MÚSCULOS Y TENDONES ESPECIFICADOS A NIVEL DE TOBILLO Y PIE, PIE NO ESPECIFICADO, CONTACTO SUCESIVO                                                                           | 2025-12-27 07:48:59
--  Andrés  Cabrera Ramírez              | Esteban Martínez    | INFECCIÓN DIRECTA DE ARTICULACIÓN EN ENFERMEDADES INFECCIOSAS Y PARASITARIAS CLASIFICADAS BAJO OTRO CONCEPTO, MANO DERECHA                                                                             | 2025-12-27 04:18:50
--  Rodrigo Antonio Medina Vargas        | Carolina Díaz       | HERIDA PUNZANTE SIN CUERPO EXTRAÑO DE MAMA NO ESPECIFICADA, CONTACTO SUCESIVO                                                                                                                          | 2025-12-26 05:44:21
--  Karen  Mejía Ramírez                 | Sara Peña           | ARTRITIS NEUMOCÓCICA, HOMBRO DERECHO                                                                                                                                                                   | 2025-12-25 14:01:45
--  Sara Sofía Mendoza Pérez             | Valentina Peña      | EMBARAZO TRIPLE CON DOS O MÁS FETOS MONOCORIÓNICOS, TRIMESTRE NO ESPECIFICADO                                                                                                                          | 2025-12-25 07:06:03
--  Sara Sofía Mendoza Pérez             | Valentina Peña      | ASFIXIA POR (DEBIDA A) AHORCAMIENTO, AUTOLESIÓN INTENCIONADA, SECUELA                                                                                                                                  | 2025-12-25 07:06:03
--  Andrés  Silva Gómez                  | Isabel Jiménez      | GLAUCOMA SECUNDARIO A OTROS TRASTORNOS DEL OJO, OJO DERECHO, ESTADIO MODERADO                                                                                                                          | 2025-12-25 04:41:11
--  Natalia Del Pilar Navarro Rivera     | Pedro Mejía         | NEOPLASIA MALIGNA DE TEJIDOS LINFÁTICO, HEMOPOYÉTICO Y RELACIONADOS, NO ESPECIFICADA                                                                                                                   | 2025-12-24 15:56:03
--  Natalia Del Pilar Navarro Rivera     | Pedro Mejía         | ENVENENAMIENTO POR OTROS OPIÁCEOS, AGRESIÓN, CONTACTO SUCESIVO                                                                                                                                         | 2025-12-24 15:56:03
--  Mauricio  Lozano Herrera             | Jorge Suárez        | FRACTURA SIN DESPLAZAMIENTO DE ESPINA TIBIAL IZQUIERDA, CONTACTO SUCESIVO POR FRACTURA CERRADA CON UNIÓN DEFECTUOSA           -- Más  --



-- 7. Listar todas las prescripciones médicas con información del medicamento y registro médico asociado,
-- mostrando el paciente, medicamento prescrito, dosis y si se generó alguna alerta,
-- filtrando prescripciones con alertas generadas, ordenadas por fecha de prescripción.
SELECT
    T3.first_name||' '||COALESCE(T3.middle_name, '')||' '||T3.first_surname||' '||COALESCE(T3.second_surname, '') AS paciente,
    T4.commercial_name,
    T1.dosage,
    T1.alert_generated
FROM smart_health.prescriptions T1
INNER JOIN smart_health.medical_records T2
    ON  T1.medical_record_id = T2.medical_record_id
INNER JOIN smart_health.patients T3
    ON T2.patient_id = T3.patient_id
INNER JOIN smart_health.medications T4
    ON T1.medication_id = T4.medication_id
WHERE T1.alert_generated = TRUE
ORDER BY T1.prescription_date;


-- 8. Consultar todas las citas con información de la sala asignada (si tiene),
-- mostrando paciente, doctor, sala y horario,
-- usando LEFT JOIN para incluir citas sin sala asignada, ordenadas por fecha y hora.
SELECT
    T3.first_name||' '||COALESCE(T3.middle_name, '')||' '||T3.first_surname||' '||COALESCE(T3.second_surname, '') AS paciente,
    T4.first_name||' '||T4.last_name AS doctor,
    T2.room_name,
    T1.start_time||' - '||T1.end_time AS horario
FROM smart_health.appointments T1
LEFT JOIN smart_health.rooms T2
    ON T1.room_id = T2.room_id
INNER JOIN smart_health.patients T3
    ON T1.patient_id = T3.patient_id
INNER JOIN smart_health.doctors T4
    ON T1.doctor_id = T4.doctor_id
ORDER BY T1.appointment_date, T1.start_time;
--                 paciente                 |       doctor        | room_name |       horario
-- -----------------------------------------+---------------------+-----------+---------------------
--  Javier Ángel Peña Serrano               | Miguel Ramírez      | Sala-0009 | 07:00:00 - 07:15:00
--  Laura Alejandra Cifuentes Rubio         | Diego Pérez         | Sala-0024 | 07:00:00 - 07:30:00
--  Gabriela Teresa Díaz Salinas            | Daniela Montoya     | Sala-0115 | 07:30:00 - 08:00:00
--  Natalia Ángel Cifuentes Torres          | Lorena Cifuentes    | Sala-0022 | 08:00:00 - 08:45:00
--  Santiago Enrique Mejía Peña             | Pedro Medina        | Sala-0032 | 08:15:00 - 08:45:00
--  José  Vargas                            | Gabriela Castaño    | Sala-0235 | 08:15:00 - 09:00:00
--  José Javier Martínez Pineda             | Andrea Lozano       | Sala-0132 | 08:45:00 - 09:45:00
--  Laura Sofía Ríos Gil                    | Daniela Rincón      | Sala-0008 | 08:45:00 - 09:45:00
--  Sebastián Javier Ramírez Navarro        | Luis Montoya        | Sala-0139 | 09:15:00 - 09:45:00
--  Karen Alberto Mendoza Molina            | Lorena González     | Sala-0194 | 09:30:00 - 10:30:00
--  Esteban  Suárez Cabrera                 | Gabriela Cabrera    | Sala-0117 | 09:45:00 - 10:15:00
--  Mariana  Mejía Andrade                  | Sara Cabrera        | Sala-0004 | 09:45:00 - 10:45:00
--  Óscar  Mora                             | Valentina Ortiz     | Sala-0202 | 10:00:00 - 11:00:00
--  Juliana Lucía Morales                   | Carlos Jiménez      | Sala-0103 | 10:30:00 - 11:00:00
--  Sara  Peña Ramírez                      | Jorge Rojas         | Sala-0199 | 10:30:00 - 11:30:00
--  Óscar  Cifuentes                        | Rodrigo Peña        | Sala-0077 | 10:45:00 - 11:45:00
--  Alejandro Ricardo Peña                  | Alejandro Castaño   | Sala-0224 | 10:45:00 - 11:00:00
--  Natalia  Mendoza Cárdenas               | Sebastián Mejía     | Sala-0031 | 11:15:00 - 11:45:00
--  Jorge Armando Suárez Herrera            | Daniela Cifuentes   | Sala-0098 | 11:15:00 - 12:00:00
--  Jorge  Cárdenas Díaz                    | Jorge Rincón        | Sala-0044 | 11:30:00 - 12:00:00
--  Angela Tatiana López Ramírez            | Valeria Cárdenas    | Sala-0049 | 11:45:00 - 12:00:00
--  Javier Ángel Cárdenas López             | Ricardo Álvarez     | Sala-0159 | 11:45:00 - 12:00:00
--  Angela Carolina Soto Salazar            | Carolina Aguirre    | Sala-0180 | 12:00:00 - 13:00:00
--  Santiago  Reyes                         | Isabel Gutiérrez    | Sala-0248 | 12:15:00 - 12:30:00
--  Angela  Salazar Lozano                  | Laura Lozano        | Sala-0208 | 12:30:00 - 12:45:00
--  Andrea Carolina Ruiz Molina             | Gabriela Salazar    | Sala-0177 | 12:45:00 - 13:00:00
--  Manuel  Martínez Soto                   | Daniela Soto        | Sala-0127 | 13:15:00 - 13:45:00
--  Natalia Patricia Vega Peña              | Julián Jiménez      | Sala-0211 | 13:45:00 - 14:45:00
--  Rafael Mauricio Cifuentes Montoya       | Lorena López        | Sala-0072 | 14:00:00 - 14:30:00
--  Andrés Javier Cifuentes Pardo           | Paola Mora          | Sala-0158 | 14:15:00 - 14:45:00
--  Javier Felipe Hernández                 | Sebastián Pineda    | Sala-0003 | 14:30:00 - 14:45:00
--  Ricardo  Hernández Ramírez              | Rafael Cabrera      | Sala-0016 | 15:15:00 - 16:15:00
--  Vanessa  Cifuentes Pérez                | Laura Morales       | Sala-0050 | 16:00:00 - 17:00:00
--  Andrea Lucía Vega Castillo              | Karen Díaz          | Sala-0131 | 16:00:00 - 16:30:00
--  Manuel  Castro Morales                  | Valeria Mora        | Sala-0185 | 16:45:00 - 17:30:00
--  Rafael David Gómez                      | Angela Álvarez      | Sala-0029 | 16:45:00 - 17:30:00
--  Lorena  Salazar Méndez                  | Julián Reyes        | Sala-0043 | 16:45:00 - 17:30:00
--  Javier  León                            | Andrea López        | Sala-0035 | 17:30:00 - 18:30:00
--  Adriana Rocío Cárdenas Cárdenas         | Sara Herrera        | Sala-0130 | 17:30:00 - 17:45:00
--  María Carolina Aguirre Rojas            | Mónica Gil          | Sala-0035 | 17:45:00 - 18:15:00
--  Paola Milena Ramírez Salazar            | Andrea Ramírez      | Sala-0109 | 17:45:00 - 18:45:00
--  Juliana Lucía Álvarez                   | Daniela Gutiérrez   | Sala-0114 | 17:45:00 - 18:00:00
--  Carlos David Pardo Molina               | Manuel Montoya      | Sala-0132 | 07:00:00 - 07:45:00
--  Sara Estefanía Castro Peña              | José Lozano         | Sala-0131 | 07:30:00 - 08:30:00
--  Juan  Vargas Castillo                   | Natalia Aguirre     | Sala-0033 | 08:00:00 - 08:15:00
--  Vanessa  Álvarez Cifuentes              | Camila Castro       | Sala-0138 | 08:00:00 - 08:30:00
--  Hernán  Pardo Soto                      | Luis Vega           | Sala-0058 | 08:45:00 - 09:45:00
-- -- Más  --

-- 9. Listar todos los teléfonos de pacientes con información completa del paciente,
-- mostrando nombre, tipo de teléfono, número y si es el teléfono principal,
-- filtrando solo teléfonos móviles, ordenados por nombre del paciente.
SELECT
    T1.first_name||' '||COALESCE(T1.middle_name, '')||' '||T1.first_surname||' '||COALESCE(T1.second_surname, '') AS paciente,
    T2.phone_type,
    T2.phone_number,
    T2.is_primary
FROM smart_health.patients T1
INNER JOIN smart_health.patient_phones T2 
    ON T1.patient_id = T2.patient_id
WHERE phone_type = 'Móvil'
ORDER BY T1.first_name;

-- 10. Obtener todos los doctores que NO tienen especialidades asignadas (ANTI JOIN),
-- mostrando su información básica y fecha de ingreso,
-- útil para identificar médicos que requieren actualización de información,
-- ordenados por fecha de ingreso al hospital.
SELECT
    T1.first_name||' '||T1.last_name AS doctor,
    T1.internal_code,
    T1.medical_license_number,
    T1.hospital_admission_date
FROM smart_health.doctors T1
LEFT JOIN smart_health.doctor_specialties T2
    ON T1.doctor_id = T2.doctor_id
WHERE T2.doctor_id IS NULL
ORDER BY T1.hospital_admission_date;



-- ##################################################
-- ##################################################
-- ##################################################



-- 1. Contar cuántos pacientes nacieron en cada mes del año,
-- mostrando el número del mes y el nombre del mes en mayúsculas,
-- junto con la cantidad total de pacientes nacidos en ese mes.
-- Dificultad: BAJA
SELECT
    EXTRACT(MONTH FROM birth_date) AS mes,
    UPPER(TO_CHAR(birth_date, 'TMMonth')) AS nombre_mes,
    COUNT(*) AS total_pacientes
FROM smart_health.patients
GROUP BY mes, nombre_mes
ORDER BY mes;
--  mes | nombre_mes | total_pacientes
-- -----+------------+-----------------
--    1 | ENERO      |            5205
--    2 | FEBRERO    |            4611
--    3 | MARZO      |            5171
--    4 | ABRIL      |            4864
--    5 | MAYO       |            4991
--    6 | JUNIO      |            4999
--    7 | JULIO      |            5230
--    8 | AGOSTO     |            4998
--    9 | SEPTIEMBRE |            4861
--   10 | OCTUBRE    |            5107
--   11 | NOVIEMBRE  |            4838
--   12 | DICIEMBRE  |            5125
-- (12 filas)



-- 2. Mostrar el número de citas programadas agrupadas por día de la semana,
-- incluyendo el nombre del día en español y la cantidad de citas,
-- ordenadas por la cantidad de citas de mayor a menor.
-- Dificultad: BAJA
SELECT
    UPPER(TO_CHAR(appointment_date, 'TMDay')) AS nombre_dia,
    COUNT(*) AS total_citas
FROM smart_health.appointments
GROUP BY nombre_dia
ORDER BY total_citas DESC;



-- 3. Calcular la cantidad de años promedio que los médicos han trabajado en el hospital,
-- agrupados por especialidad, mostrando el nombre de la especialidad en mayúsculas
-- y el promedio de años de experiencia redondeado a un decimal.
-- Dificultad: BAJA-INTERMEDIA
SELECT
    ROUND(AVG(EXTRACT(YEAR FROM AGE(T1.hospital_admission_date))),1) AS avg_years,
    UPPER(T3.specialty_name)
FROM smart_health.doctors T1
INNER JOIN smart_health.doctor_specialties T2
    ON T1.doctor_id = T2.doctor_id
INNER JOIN smart_health.specialties T3
    ON T2.specialty_id = T3.specialty_id
GROUP BY T3.specialty_name;
--  avg_years |                upper
-- -----------+-------------------------------------
--       15.3 | OFTALMOLOGÍA
--       15.4 | MEDICINA FÍSICA Y REHABILITACIÓN
--       15.4 | OTORRINOLARINGOLOGÍA
--       16.3 | HEPATOLOGÍA
--       15.1 | ESTOMATOLOGÍA
--       15.3 | MEDICINA DEL DEPORTE
--       14.0 | NEFROLOGÍA
--       13.4 | NEUROFISIOLOGÍA CLÍNICA
--       15.1 | GENÉTICA MÉDICA
--       15.1 | ANATOMÍA PATOLÓGICA
--       15.8 | ONCOLOGÍA MÉDICA
--       15.1 | GINECOLOGÍA Y OBSTETRICIA
--       16.7 | EMBRIOLOGÍA
--       15.2 | GASTROENTEROLOGÍA
--       13.7 | RADIOLOGÍA
--       14.9 | GENÉTICA
--       15.7 | ANGIOLOGÍA
--       15.9 | NUTRIOLOGÍA
--       15.9 | ONCOLOGÍA RADIOTERÁPICA
--       13.5 | MEDICINA FAMILIAR Y COMUNITARIA
--       15.6 | UROLOGÍA
--       15.0 | ENDOCRINOLOGÍA
--       15.1 | MEDICINA INTERNA
--       15.3 | MEDICINA PALIATIVA
--       13.2 | MICROBIOLOGÍA Y PARASITOLOGÍA
--       14.3 | ALERGOLOGÍA
--       16.1 | EPIDEMIOLOGÍA
--       14.7 | BIOQUÍMICA CLÍNICA
--       13.4 | CARDIOLOGÍA
--       16.1 | FARMACOLOGÍA CLÍNICA
--       15.1 | MEDICINA INTENSIVA
--       15.0 | AUDITORÍA MÉDICA
--       14.8 | PEDIATRÍA
--       14.1 | ADMINISTRACIÓN EN SALUD
--       14.0 | MEDICINA DE EMERGENCIA
--       15.6 | SALUD PÚBLICA
--       15.4 | INFECTOLOGÍA
--       14.0 | MEDICINA PREVENTIVA Y SALUD PÚBLICA
-- -- Más  --



-- 4. Obtener el número de pacientes registrados por año,
-- mostrando el año de registro, el trimestre, y el total de pacientes,
-- solo para aquellos trimestres que tengan más de 2 pacientes registrados.
-- Dificultad: INTERMEDIA
SELECT
    EXTRACT(YEAR FROM registration_date) AS año_registro,
    EXTRACT(QUARTER FROM registration_date) AS trimestre,
    COUNT(*) AS total_pacientes
FROM smart_health.patients
GROUP BY año_registro, trimestre
HAVING COUNT(*) > 2
ORDER BY año_registro, trimestre;
--  año_registro | trimestre | total_pacientes
-- --------------+-----------+-----------------
--          2025 |         4 |           60000
-- (1 fila)



-- 5. Listar el número de prescripciones emitidas por mes y año,
-- mostrando el mes en formato texto con la primera letra en mayúscula,
-- el año, y el total de prescripciones, junto con el nombre del medicamento más prescrito.
-- Dificultad: INTERMEDIA


-- 6. Calcular la edad promedio de los pacientes agrupados por tipo de sangre,
-- mostrando el tipo de sangre, la edad mínima, la edad máxima y la edad promedio,
-- solo para grupos que tengan al menos 3 pacientes.
-- Dificultad: INTERMEDIA


-- 7. Mostrar el número de citas por médico y por mes,
-- incluyendo el nombre completo del doctor en mayúsculas, el mes y año de la cita,
-- la duración promedio de las citas en minutos, y el total de citas realizadas,
-- solo para aquellos médicos que tengan más de 5 citas en el mes.
-- Dificultad: INTERMEDIA-ALTA

-- 8. Obtener estadísticas de alergias por severidad y mes de diagnóstico,
-- mostrando la severidad en minúsculas, el nombre del mes abreviado,
-- el total de alergias registradas, y el número de pacientes únicos afectados,
-- junto con el nombre comercial del medicamento más común en cada grupo.
-- Dificultad: INTERMEDIA-ALTA

-- ##################################################
-- #                 END OF QUERIES                 #
-- ##################################################
