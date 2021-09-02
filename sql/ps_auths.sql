INSERT INTO ps_auths 
(
    id, 
    auth_type, 
    password, 
    username
)
VALUES 
('0000f30A0A01'  , 'userpass', 'not very secure'     , '0000f30A0A01'),
('0000f30B0B02'  , 'userpass', 'hardly to be trusted', '0000f30B0B02'),
('SOFTPHONE_A'   , 'userpass', 'iwouldnotifiwereyou' , 'SOFTPHONE_A' ),
('SOFTPHONE_B'   , 'userpass', 'areyoueventrying'    , 'SOFTPHONE_B' ),
('SAMSUNG_S20'   , 'userpass', 'samsung'             , 'SAMSUNG_S20' ),
('SAMSUNG_S5_TAB', 'userpass', 'samsung'             , 'SAMSUNG_S5_TAB');

-- Select the data for view
-- SELECT id, auth_type, password, username FROM ps_auths;

-- Update the data
-- UPDATE ps_auths SET password='samsung' WHERE id='SAMSUNG_S5_TAB'