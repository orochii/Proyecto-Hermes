/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO 
(
    NOMBRE_USUARIO varchar(30) not null,
    CONTRASENA varchar(32) not null,
    TIPO varchar(10) not null,
    ESTADO varchar(10) not null,
    ULTIMA_CONEXION timestamp,
    ULTIMA_ACTIVIDAD varchar(10),
    FECHA_FIN_SUSPENSION date,
    TIPO_IDENTIFICACION varchar(10) not null,
    NUMERO_IDENTIFICACION varchar(20) not null,
	constraint PK_USUARIO primary key (NOMBRE_USUARIO)
					using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: CUENTA_CORRESPONDE_USUARIO_FK                         */
/*==============================================================*/
create index CUENTA_CORRESPONDE_USUARIO_FK on USUARIO (
   TIPO_IDENTIFICACION ASC,
   NUMERO_IDENTIFICACION ASC
)
/

/*==============================================================*/
/* Table: AUDITORIA                                             */
/*==============================================================*/
create table AUDITORIA 
(
    ID number(10) not null,
    TIEMPO timestamp not null,
    NOMBRE_USUARIO varchar(30) not null,
    TIPO_USUARIO varchar(10) not null,
    TRANSACCION varchar(10) not null,
    DETALLE_TRANSACCION varchar(255) not null,
	constraint PK_AUDITORIA primary key (ID) using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/* Identificador consecutivo */
create sequence auditoria_seq start with 1
/

insert into USUARIO(NOMBRE_USUARIO,CONTRASENA,TIPO,ESTADO,TIPO_IDENTIFICACION,NUMERO_IDENTIFICACION) 
            values('superuser','81dc9bdb52d04dc20036dbd8313ed055','SUPER','OFFLINE','NAC','2123456')
/
