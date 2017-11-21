CREATE SMALLFILE TABLESPACE TS_DATA 
    DATAFILE 
        'C:\oraclexe\app\oracle\oradata\XE\TS_DATA.DBF' SIZE 10485760 AUTOEXTEND ON NEXT 1048576 MAXSIZE 104857600 
    DEFAULT NOCOMPRESS 
    ONLINE 
    SEGMENT SPACE MANAGEMENT AUTO 
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE;