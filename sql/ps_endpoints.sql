INSERT INTO ps_endpoints
(
    id,
    transport,
    aors,
    auth,
    context,
    disallow,
    allow
)
VALUES
('SOFTPHONE_A','transport-tls','SOFTPHONE_A','SOFTPHONE_A','sets','all','ulaw'),
('SOFTPHONE_B','transport-tls','SOFTPHONE_B','SOFTPHONE_B','sets','all','ulaw');


INSERT INTO ps_endpoints
(
    id, 
    transport, 
    aors, 
    auth, 
    context, 
    disallow, 
    allow, 
    direct_media
)
VALUES
('0000f30A0A01', 'transport-udp', '0000f30A0A01', '0000f30A0A01', 'sets', 'all', 'ulaw', 'no'),
('0000f30B0B02', 'transport-udp', '0000f30B0B02', '0000f30B0B02', 'sets', 'all', 'ulaw', 'no');
