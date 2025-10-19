-- ##################################################
-- #        SMART HEALTH SCHEMA CREATION SCRIPT      #
-- ##################################################

-- 01. Create schema
CREATE SCHEMA IF NOT EXISTS smart_health AUTHORIZATION gisell3010;

-- 02. Grant privileges
GRANT ALL PRIVILEGES ON SCHEMA smart_health TO gisell3010;

-- 03. Comment on schema
COMMENT ON SCHEMA smart_health IS 'Esquema principal del sistema de gestión hospitalaria Smart Health';

-- ##################################################
-- #                 END OF SCRIPT                  #
-- ##################################################
