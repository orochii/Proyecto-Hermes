/*==============================================================*/
/* Table: CAMPANA                                               */
/*==============================================================*/
create table CAMPANA 
(
   CODIGO_CAMPANA       VARCHAR2(20)         not null,
   DESCRIPCION_CAMPANA  VARCHAR2(150)        not null,
   ESTADO_CAMPANA       VARCHAR2(50)         not null,
   PROPOSITO_CAMPANA    VARCHAR2(50)         not null,
   NOMBRE_CAMPANA       VARCHAR2(50)         not null,
   TIPO_CAMPANA         VARCHAR2(50)         not null,
   constraint PK_CAMPANA primary key (CODIGO_CAMPANA)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Table: CANTON                                                */
/*==============================================================*/
create table CANTON 
(
   CODIGO_CANTON        VARCHAR2(20)         not null,
   NOMBRE_CANTON        VARCHAR2(50)         not null,
   constraint PK_CANTON primary key (CODIGO_CANTON)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Table: CICLO_FACTURABLE                                      */
/*==============================================================*/
create table CICLO_FACTURABLE 
(
   CODIGO_CICLO         VARCHAR2(20)         not null,
   NOMBRE_CICLO         VARCHAR2(20),
   TIEMPO_CICLO         NUMBER(10)          
      constraint CKC_TIEMPO_CICLO check (TIEMPO_CICLO is null or (TIEMPO_CICLO > 0 AND TIEMPO_CICLO < 31)),
   DESCRIPCION_CICLO    VARCHAR2(150)        not null,
   DESCRIPCION_STATUS   VARCHAR2(150)        not null,
   CODIGO_STATUS_CF     VARCHAR2(20),
   constraint PK_CICLO_FACTURABLE primary key (CODIGO_CICLO)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE 
(
   TIPO_IDENTIFICACION  VARCHAR2(10)         not null
      constraint CKC_TIPO_ID check (TIPO_IDENTIFICACION = 'EXT' OR TIPO_IDENTIFICACION = 'NAC' OR TIPO_IDENTIFICACION = 'JUR'),
   NUMERO_IDENTIFICACION NUMBER(20)           not null
      constraint CKC_NUMERO_ID check (NUMERO_IDENTIFICACION > 0),
   CODIGO_POSTAL_CLIENTE NUMBER(10)           not null,
   NOMBRE_CLIENTE       VARCHAR2(50)         not null,
   ESTADO_CIVIL         VARCHAR2(50),
   EMAIL                VARCHAR2(50)         not null,
   FECHANACIMIENTO      DATE                 not null,
   SEXO                 VARCHAR2(20)        
      constraint CKC_SEXO_CLIENTE check (SEXO is null or (SEXO = 'F' OR SEXO = 'M')),
   NACIONALIDAD         VARCHAR2(50),
   TIEMPO_RESIDENCIA_DOMICILIO NUMBER(4)           
      constraint CKC_TIEMPO_RESIDENCIA_CLIENTE check (TIEMPO_RESIDENCIA_DOMICILIO is null or (Tiempo_Residencia_Domicilio >= 0)),
   NUMERO_DEPENDIENTES  NUMBER(2)            not null
      constraint CKC_NUMERO_DEPT_CLIENTE check (Numero_Dependientes >= 0),
   VENCIMIENTO_IDENTIFICACION DATE,                
   constraint PK_CLIENTE primary key (NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: CLIENTE_RESIDE_DIRECCION_FK                           */
/*==============================================================*/
create index CLIENTE_RESIDE_DIRECCION_FK on CLIENTE (
   CODIGO_POSTAL_CLIENTE ASC
)
/

/*==============================================================*/
/* Table: CONTRATO                                              */
/*==============================================================*/
create table CONTRATO 
(
   NUMERO_CONTRATO      NUMBER(20)           not null
      constraint CKC_NUMERO_CONTRATO check (NUMERO_CONTRATO > 0),
   CODIGO_CUENTA        VARCHAR2(20)         not null,
   NUMERO_IDENTIFICACION NUMBER(20)           not null
      constraint CKC_NUMERO_IDENTIFICA_CONTRATO check (NUMERO_IDENTIFICACION > 0),
   TIPO_IDENTIFICACION  VARCHAR2(10)         not null
      constraint CKC_TIPO_IDENTIFICACI_CONTRATO check (TIPO_IDENTIFICACION = 'EXT' OR TIPO_IDENTIFICACION = 'NAC' OR TIPO_IDENTIFICACION = 'JUR'),
   TIPO_CONTRATO        VARCHAR2(20)         not null,
   FECHA_INICIO_CONTRATO DATE                 not null,
   NOMBRE_CONTRATO      VARCHAR2(50)         not null,
   CANAL_COMUNICACION_CLIENTE VARCHAR2(50),
   DOCUMENTO_DIGITALIZADO VARCHAR2(50)         not null,
   INDICADOR_RENOVACION_CONTRATO SMALLINT,
   NUMERO_ORDEN         NUMBER(20)           not null
      constraint CKC_NUMERO_ORDEN check (NUMERO_ORDEN > 0),
   TERMINOS_PAGO        VARCHAR2(50),
   CANAL_VENTA          VARCHAR2(50),
   RAZON_CANCELACION    VARCHAR2(50),
   FECHA_CANCELACION    DATE,
   FECHA_FINAL_CONTRATO DATE,
   CODIGO_STATUS_CONTRATO VARCHAR2(20)         not null,
   COSTO_CONTRATO       NUMBER(10)           not null
      constraint CKC_COSTO_CONTRATO_CONTRATO check (COSTO_CONTRATO > 0),
   FECHA_INICIO_FACTURACION DATE,
   constraint PK_CONTRATO primary key (NUMERO_CONTRATO)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: CUENTA_VINCULA_CONTRATO_FK                            */
/*==============================================================*/
create index CUENTA_VINCULA_CONTRATO_FK on CONTRATO (
   CODIGO_CUENTA ASC,
   NUMERO_IDENTIFICACION ASC,
   TIPO_IDENTIFICACION ASC
)
/

/*==============================================================*/
/* Table: CUENTA                                                */
/*==============================================================*/
create table CUENTA 
(
   CODIGO_CUENTA        VARCHAR2(20)         not null,
   NUMERO_IDENTIFICACION NUMBER(20)           not null
      constraint CKC_NUMERO_ID_CUENTA check (NUMERO_IDENTIFICACION > 0),
   TIPO_IDENTIFICACION  VARCHAR2(10)         not null
      constraint CKC_TIPO_IDENTIFICACI_CUENTA check (TIPO_IDENTIFICACION = 'EXT' OR TIPO_IDENTIFICACION = 'NAC' OR TIPO_IDENTIFICACION = 'JUR'),
   PH_CODIGO_CUENTA     VARCHAR2(20),
   PH_NUMERO_IDENTIFICACION NUMBER(20)          
      constraint CKC_PH_NUMERO_IDENTIF_CUENTA check (PH_NUMERO_IDENTIFICACION is null or (PH_NUMERO_IDENTIFICACION > 0)),
   PH_TIPO_IDENTIFICACION VARCHAR2(10)        
      constraint CKC_PH_TIPO_IDENTIFIC_CUENTA check (PH_TIPO_IDENTIFICACION is null or (PH_TIPO_IDENTIFICACION = 'EXT' OR PH_TIPO_IDENTIFICACION = 'NAC' OR PH_TIPO_IDENTIFICACION = 'JUR')),
   NOMBRE_CUENTA        VARCHAR2(50)         not null,
   TIPO_CODIGO_CUENTA   VARCHAR2(50)         not null,
   ULTIMA_FECHA_REAPERTURA DATE,
   FECHA_CREACION       DATE                 not null,
   CODIGO_SEGMENTO      VARCHAR2(20)         not null,
   NOMBRE_EMPLEADO_CREADOR VARCHAR2(50)         not null,
   ESTADO_CUENTA        VARCHAR2(50)         not null,
   ULTIMA_FECHA_SUSPENCION DATE,
   FECHA_CIERRE_TERMINO DATE,
   CICLO_ASOCIADO_CUENTA VARCHAR2(50)         not null
      constraint CKC_CICLO_ASOCIADO_CU_CUENTA check (CICLO_ASOCIADO_CUENTA < =30 AND CICLO_ASOCIADO_CUENTA >= 1),
   FECHA_EFECTIVA_CIERRE DATE,                
   FECHA_EFECTIVA_INICIO DATE                 not null,
   FECHA_ULTIMA_ACTIVIDAD DATE,
   CATEGORIA_CREDITO    NUMBER(3)            not null
      constraint CKC_CATEGORIA_CREDITO_CUENTA check (CATEGORIA_CREDITO >= 0 AND CATEGORIA_CREDITO <= 100),
   DIAS_DESPUES_PAGO    NUMBER(10),
   constraint PK_CUENTA primary key (CODIGO_CUENTA, NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: CLIENTE_PERTENECE_CUENTA_FK                           */
/*==============================================================*/
create index CLIENTE_PERTENECE_CUENTA_FK on CUENTA (
   NUMERO_IDENTIFICACION ASC,
   TIPO_IDENTIFICACION ASC
)
/

/*==============================================================*/
/* Index: CUENTA_ASOCIA_CUENTA_FK                               */
/*==============================================================*/
create index CUENTA_ASOCIA_CUENTA_FK on CUENTA (
   PH_CODIGO_CUENTA ASC,
   PH_NUMERO_IDENTIFICACION ASC,
   PH_TIPO_IDENTIFICACION ASC
)
/

/*==============================================================*/
/* Table: DIRECCION                                             */
/*==============================================================*/
create table DIRECCION 
(
   CODIGO_POSTAL_CLIENTE NUMBER(10)           not null,
   CODIGO_PROVINCIA     VARCHAR2(20)         not null,
   CODIGO_DISTRITO      VARCHAR2(20)         not null,
   CODIGO_CANTON        VARCHAR2(20)         not null,
   constraint PK_DIRECCION primary key (CODIGO_POSTAL_CLIENTE)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: DIRECCION_TIENE_PROVINCIA_FK                          */
/*==============================================================*/
create index DIRECCION_TIENE_PROVINCIA_FK on DIRECCION (
   CODIGO_PROVINCIA ASC
)
/

/*==============================================================*/
/* Index: DIRECCION_TIENE_CANTON_FK                             */
/*==============================================================*/
create index DIRECCION_TIENE_CANTON_FK on DIRECCION (
   CODIGO_CANTON ASC
)
/

/*==============================================================*/
/* Index: DIRECCION_TIENE_DISTRITO_FK                           */
/*==============================================================*/
create index DIRECCION_TIENE_DISTRITO_FK on DIRECCION (
   CODIGO_DISTRITO ASC
)
/

/*==============================================================*/
/* Table: DISTRITO                                              */
/*==============================================================*/
create table DISTRITO 
(
   CODIGO_DISTRITO      VARCHAR2(20)         not null,
   NOMBRE_DISTRITO      VARCHAR2(50)         not null,
   constraint PK_DISTRITO primary key (CODIGO_DISTRITO)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Table: EMPRESA                                               */
/*==============================================================*/
create table EMPRESA 
(
   CEDULA_JURIDICA      NUMBER(20)           not null
      constraint CKC_CEDULA_JUR_EMPRESA check (CEDULA_JURIDICA > 0),
   CODIGO_POSTAL_CLIENTE NUMBER(10)           not null,
   NOMBRE_EMPRESA       VARCHAR2(50),
   constraint PK_EMPRESA primary key (CEDULA_JURIDICA)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: EMPRESA_UBICA_DIRECCION_FK                            */
/*==============================================================*/
create index EMPRESA_UBICA_DIRECCION_FK on EMPRESA (
   CODIGO_POSTAL_CLIENTE ASC
)
/

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA 
(
   NUMERO_FACTURA       NUMBER(20)           not null
      constraint CKC_NUMERO_FACTURA check (NUMERO_FACTURA > 0),
   CODIGO_CICLO         VARCHAR2(20)         not null,
   NUMERO_CONTRATO      NUMBER(20)           not null
      constraint CKC_NUMERO_CONTRATO_FACTURA check (NUMERO_CONTRATO > 0),
   MONTO_AMORTIZADO     NUMBER(10)           not null
      constraint CKC_MONTO_AMORTIZADO_FACTURA check (MONTO_AMORTIZADO > 0),
   MONTO_REPORTADO      NUMBER(10)           not null
      constraint CKC_MONTO_REPORTADO_FACTURA check (MONTO_REPORTADO > 0),
   CICLO_ASOCIADO_BILLING VARCHAR2(50)         not null
      constraint CKC_CICLO_ASOCIADO_BI_FACTURA check (CICLO_ASOCIADO_BILLING < =30 AND CICLO_ASOCIADO_BILLING > =1),
   FECHA_FACTURA        DATE                 not null,
   SUB_TOTAL            NUMBER(10,2)         not null
      constraint CKC_SUB_TOTAL_FACTURA check (SUB_TOTAL > 0),
   TOTAL                NUMBER(10,2)         not null
      constraint CKC_TOTAL_FACTURA check (TOTAL > 0),
   constraint PK_FACTURA primary key (NUMERO_FACTURA)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: CICLO_ASOCIA_FACTURA_FK                               */
/*==============================================================*/
create index CICLO_ASOCIA_FACTURA_FK on FACTURA (
   CODIGO_CICLO ASC
)
/

/*==============================================================*/
/* Index: CONTRATO_GENERA_FACTURA_FK                            */
/*==============================================================*/
create index CONTRATO_GENERA_FACTURA_FK on FACTURA (
   NUMERO_CONTRATO ASC
)
/

/*==============================================================*/
/* Table: INFORMACION_LABORAL                                   */
/*==============================================================*/
create table INFORMACION_LABORAL 
(
   NUMERO_IDENTIFICACION NUMBER(20)           not null
      constraint CKC_NUMERO_IDENTIFICA_INFORMAC check (NUMERO_IDENTIFICACION > 0),
   TIPO_IDENTIFICACION  VARCHAR2(10)         not null
      constraint CKC_TIPO_IDENTIFICACI_INFORMAC check (TIPO_IDENTIFICACION = 'EXT' OR TIPO_IDENTIFICACION = 'NAC' OR TIPO_IDENTIFICACION = 'JUR'),
   CEDULA_JURIDICA      NUMBER(20)           not null
      constraint CKC_CEDULA_JURIDICA_INFORMAC check (CEDULA_JURIDICA > 0),
   PUESTO               VARCHAR2(50),
   PUESTO_ANTERIOR      VARCHAR2(50),
   EMPRESA_PROPIA       VARCHAR2(3)         
      constraint CKC_EMPRESA_PROPIA_INF_LAB check (EMPRESA_PROPIA is null or (EMPRESA_PROPIA = 'SI' OR EMPRESA_PROPIA = 'NO')),
   PATRONO_ANTERIOR     VARCHAR2(50),
   FECHA_INGRESO        DATE                 not null,
   SALARIO_BRUTO        NUMBER(10)           not null
      constraint CKC_SALARIO_BRUTO_INFORMAC check (SALARIO_BRUTO > = 0),
   SALARIO_NETO         NUMBER(10)           not null
      constraint CKC_SALARIO_NETO_INFORMAC check (SALARIO_NETO >= 0),
   OTROS_INGRESOS       NUMBER(10)           not null
      constraint CKC_OTROS_INGRESOS_INFORMAC check (OTROS_INGRESOS >= 0),
   constraint PK_INFORMACION_LABORAL primary key (NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Table: LINEA_FACTURA                                         */
/*==============================================================*/
create table LINEA_FACTURA 
(
   NUMERO_FACTURA       NUMBER(20)           not null
      constraint CKC_NUMERO_FACTURA_LINEA_FA check (NUMERO_FACTURA > 0),
   CODIGO_PRODUCTO      VARCHAR2(10),
   CODIGO_SERVICIO      VARCHAR2(20),
   CANTIDAD             NUMBER(3)            not null
      constraint CKC_CANTIDAD_LINEA_FA check (CANTIDAD > 0),
   PRECIO_LINEA         NUMBER(10)           not null
      constraint CKC_PRECIO_LINEA_LINEA_FA check (PRECIO_LINEA > 0),
   constraint PK_LINEA_FACTURA primary key (NUMERO_FACTURA)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: PRODUCTO_LINEA_FACTURA_FK                             */
/*==============================================================*/
create index PRODUCTO_LINEA_FACTURA_FK on LINEA_FACTURA (
   CODIGO_PRODUCTO ASC
)
/

/*==============================================================*/
/* Index: SERVICIO_LINEA_FACTURA_FK                             */
/*==============================================================*/
create index SERVICIO_LINEA_FACTURA_FK on LINEA_FACTURA (
   CODIGO_SERVICIO ASC
)
/

/*==============================================================*/
/* Table: PLAN                                                  */
/*==============================================================*/
create table PLAN 
(
   CODIGO_PLAN          VARCHAR2(20)         not null,
   CODIGO_PRODUCTO      VARCHAR2(10)         not null,
   CODIGO_SERVICIO      VARCHAR2(20)         not null,
   FECHA_EFECTIVA_INICIO_PLAN DATE                 not null,
   FECHA_EFECTIVA_FIN_PLAN DATE,                
   TIPO_PLAN            VARCHAR2(50)         not null,
   NOMBRE_PLAN          VARCHAR2(50)         not null,
   FREE_TIME            NUMBER(10),
   TIEMPO_TOTAL_PERMANENCIA NUMBER(10)          
      constraint CKC_TIEMPO_TOTAL_PERM check (TIEMPO_TOTAL_PERMANENCIA is null or (TIEMPO_TOTAL_PERMANENCIA >= 0)),
   TIEMPO_NO_PENALIDAD  NUMBER(10)          
      constraint CKC_TIEMPO_NO_PENALIDAD check (TIEMPO_NO_PENALIDAD is null or (TIEMPO_NO_PENALIDAD >= 0)),
   PROGRAMA_LEALTAD     SMALLINT             not null,
   constraint PK_PLAN primary key (CODIGO_PLAN)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: PRODUCTO_TIENE_PLAN_FK                                */
/*==============================================================*/
create index PRODUCTO_TIENE_PLAN_FK on PLAN (
   CODIGO_PRODUCTO ASC
)
/

/*==============================================================*/
/* Index: SERVICIO_TIENE_PLAN_FK                                */
/*==============================================================*/
create index SERVICIO_TIENE_PLAN_FK on PLAN (
   CODIGO_SERVICIO ASC
)
/

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO 
(
   CODIGO_PRODUCTO      VARCHAR2(10)         not null,
   CODIGO_PROMOCION     VARCHAR2(20),
   DESCUENTO            NUMBER(3)           
      constraint CKC_DESCUENTO_PRODUCTO check (DESCUENTO is null or (DESCUENTO >= 0)),
   TIPO_PRODUCTO        VARCHAR2(50)         not null,
   DECRIPCION           VARCHAR2(150)        not null,
   NOMBRE               VARCHAR2(50)         not null,
   DEPOSITO_INICIAL     NUMBER(10)          
      constraint CKC_DEPOSITO_INICIAL_PRODUCTO check (DEPOSITO_INICIAL is null or (DEPOSITO_INICIAL >= 0)),
   PRECIO_TOTAL         NUMBER(10)           not null
      constraint CKC_PRECIO_TOTAL_PRODUCTO check (PRECIO_TOTAL >0),
   MONTO_CASTIGO        NUMBER(10)          
      constraint CKC_MONTO_CASTIGO_PRODUCTO check (MONTO_CASTIGO is null or (MONTO_CASTIGO >= 0)),
   CODIGO_STATUS        VARCHAR2(20)         not null,
   FECHA_EFECTIVA_INICIO_PRODUCTO DATE                 not null,
   FECHA_EFECTIVA_FIN_PRODUCTO DATE,
   constraint PK_PRODUCTO primary key (CODIGO_PRODUCTO)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: PRODUCTO_POSEE_PROMOCION_FK                           */
/*==============================================================*/
create index PRODUCTO_POSEE_PROMOCION_FK on PRODUCTO (
   CODIGO_PROMOCION ASC
)
/

/*==============================================================*/
/* Table: PROMOCION                                             */
/*==============================================================*/
create table PROMOCION 
(
   CODIGO_PROMOCION     VARCHAR2(20)         not null,
   CODIGO_CAMPANA       VARCHAR2(20)         not null,
   TOTAL_COSTO          NUMBER(10)           not null
      constraint CKC_TOTAL_COSTO_PRM check (TOTAL_COSTO >= 0),
   NUMERO_TOTAL_VENTAS  NUMBER(10)          
      constraint CKC_NUMERO_TOTAL_VENT_PRO check (NUMERO_TOTAL_VENTAS is null or (NUMERO_TOTAL_VENTAS >= 0)),
   DESCRIPCION_PROMOCION VARCHAR2(150)        not null,
   NOMBRE_PROMOCION     VARCHAR2(50)         not null,
   EMPLEADO_RESPONSABLE VARCHAR2(50)         not null,
   NOMBRE_PARTNER       VARCHAR2(50)         not null,
   TEMA                 VARCHAR2(50)         not null,
   TIPO_PROMOCION       VARCHAR2(50)         not null,
   FECHA_INICIO_PROMOCION DATE                 not null,
   FECHA_FIN_PROMOCION  DATE,
   FECHA_EFECTIVA_INICIO_PROMO DATE                 not null,
   FECHA_EFECTIVA_FIN_PROMO DATE,
   constraint PK_PROMOCION primary key (CODIGO_PROMOCION)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: CAMPANA_CUENTA_PROMOCION_FK                           */
/*==============================================================*/
create index CAMPANA_CUENTA_PROMOCION_FK on PROMOCION (
   CODIGO_CAMPANA ASC
)
/

/*==============================================================*/
/* Table: PROVINCIA                                             */
/*==============================================================*/
create table PROVINCIA 
(
   CODIGO_PROVINCIA     VARCHAR2(20)         not null,
   NOMBRE_PROVINCIA     VARCHAR2(20)         not null,
   constraint PK_PROVINCIA primary key (CODIGO_PROVINCIA)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Table: SERVICIO                                              */
/*==============================================================*/
create table SERVICIO 
(
   CODIGO_SERVICIO      VARCHAR2(20)         not null,
   CODIGO_PROMOCION     VARCHAR2(20),
   NOMBRE_SERVICIO      VARCHAR2(50)         not null,
   DESCRIPCION_SERVICIO VARCHAR2(150)        not null,
   TIPO_SERVICIO        VARCHAR2(20)         not null,
   COSTO_SERVICIO       NUMBER(10)           not null,
   CODIGO_STATUS_SERV   VARCHAR2(20)         not null,
   MONTO_CASTIGO_SERV   NUMBER(10)          
      constraint CKC_MONTO_CASTIGO_SER_SERVICIO check (MONTO_CASTIGO_SERV is null or (MONTO_CASTIGO_SERV >= 0)),
   FECHA_EFECTIVA_INICIO_SERV DATE                 not null,
   FECHA_EFECTIVA_FIN_SERV DATE,
   constraint PK_SERVICIO primary key (CODIGO_SERVICIO)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: SERVICIO_POSEE_PROMOCION_FK                           */
/*==============================================================*/
create index SERVICIO_POSEE_PROMOCION_FK on SERVICIO (
   CODIGO_PROMOCION ASC
)
/

/*==============================================================*/
/* Table: TELEFONO_CLIENTE                                      */
/*==============================================================*/
create table TELEFONO_CLIENTE 
(
   NUMERO_TELEFONO      NUMBER(20)           not null,
   NUMERO_IDENTIFICACION NUMBER(20)           not null
      constraint CKC_NUMERO_IDENTIFICA_TELEFONO check (NUMERO_IDENTIFICACION > 0),
   TIPO_IDENTIFICACION  VARCHAR2(10)         not null
      constraint CKC_TIPO_IDENTIFICACI_TELEFONO check (TIPO_IDENTIFICACION = 'EXT' OR TIPO_IDENTIFICACION = 'NAC' OR TIPO_IDENTIFICACION = 'JUR'),
   TIPO_TELEFONO        VARCHAR2(10),
   constraint PK_TELEFONO_CLIENTE primary key (NUMERO_TELEFONO)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: CLIENTE_TIENE_TELEFONO_FK                             */
/*==============================================================*/
create index CLIENTE_TIENE_TELEFONO_FK on TELEFONO_CLIENTE (
   NUMERO_IDENTIFICACION ASC,
   TIPO_IDENTIFICACION ASC
)
/

/*==============================================================*/
/* Table: TELEFONO_EMPRESA                                      */
/*==============================================================*/
create table TELEFONO_EMPRESA 
(
   NUMEROTEL_EMPRESA    NUMBER(20)           not null,
   CEDULA_JURIDICA      NUMBER(20)           not null
      constraint CKC_CEDULA_JURIDICA_TELEFONO check (CEDULA_JURIDICA > 0),
   OTROS_NUMERO_TELEFONICO NUMBER(20),
   FAX                  NUMBER(20),
   constraint PK_TELEFONO_EMPRESA primary key (NUMEROTEL_EMPRESA)
         using index tablespace TS_INDEX
)
tablespace TS_DATA
/

/*==============================================================*/
/* Index: EMPRESA_TIENE_TELEFONO_FK                             */
/*==============================================================*/
create index EMPRESA_TIENE_TELEFONO_FK on TELEFONO_EMPRESA (
   CEDULA_JURIDICA ASC
)
/

alter table CLIENTE
   add constraint FK_CLIENTE_CLIENTE_R_DIRECCIO foreign key (CODIGO_POSTAL_CLIENTE)
      references DIRECCION (CODIGO_POSTAL_CLIENTE)
/

alter table CONTRATO
   add constraint FK_CONTRATO_CUENTA_VI_CUENTA foreign key (CODIGO_CUENTA, NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
      references CUENTA (CODIGO_CUENTA, NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
/

alter table CUENTA
   add constraint FK_CUENTA_CLIENTE_P_CLIENTE foreign key (NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
      references CLIENTE (NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
/

alter table CUENTA
   add constraint FK_CUENTA_CUENTA_AS_CUENTA foreign key (PH_CODIGO_CUENTA, PH_NUMERO_IDENTIFICACION, PH_TIPO_IDENTIFICACION)
      references CUENTA (CODIGO_CUENTA, NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
/

alter table DIRECCION
   add constraint FK_DIRECCIO_DIRECCION_CANTON foreign key (CODIGO_CANTON)
      references CANTON (CODIGO_CANTON)
/

alter table DIRECCION
   add constraint FK_DIRECCIO_DIRECCION_DISTRITO foreign key (CODIGO_DISTRITO)
      references DISTRITO (CODIGO_DISTRITO)
/

alter table DIRECCION
   add constraint FK_DIRECCIO_DIRECCION_PROVINCI foreign key (CODIGO_PROVINCIA)
      references PROVINCIA (CODIGO_PROVINCIA)
/

alter table EMPRESA
   add constraint FK_EMPRESA_EMPRESA_U_DIRECCIO foreign key (CODIGO_POSTAL_CLIENTE)
      references DIRECCION (CODIGO_POSTAL_CLIENTE)
/

alter table FACTURA
   add constraint FK_FACTURA_CICLO_ASO_CICLO_FA foreign key (CODIGO_CICLO)
      references CICLO_FACTURABLE (CODIGO_CICLO)
/

alter table FACTURA
   add constraint FK_FACTURA_CONTRATO__CONTRATO foreign key (NUMERO_CONTRATO)
      references CONTRATO (NUMERO_CONTRATO)
/

alter table INFORMACION_LABORAL
   add constraint FK_INFORMAC_CLIENTE_P_CLIENTE foreign key (NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
      references CLIENTE (NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
/

alter table INFORMACION_LABORAL
   add constraint FK_INFORMAC_INFOLAB_I_EMPRESA foreign key (CEDULA_JURIDICA)
      references EMPRESA (CEDULA_JURIDICA)
/

alter table LINEA_FACTURA
   add constraint FK_LINEA_FA_FACTURA_T_FACTURA foreign key (NUMERO_FACTURA)
      references FACTURA (NUMERO_FACTURA)
/

alter table LINEA_FACTURA
   add constraint FK_LINEA_FA_PRODUCTO__PRODUCTO foreign key (CODIGO_PRODUCTO)
      references PRODUCTO (CODIGO_PRODUCTO)
/

alter table LINEA_FACTURA
   add constraint FK_LINEA_FA_SERVICIO__SERVICIO foreign key (CODIGO_SERVICIO)
      references SERVICIO (CODIGO_SERVICIO)
/

alter table PLAN
   add constraint FK_PLAN_PRODUCTO__PRODUCTO foreign key (CODIGO_PRODUCTO)
      references PRODUCTO (CODIGO_PRODUCTO)
/

alter table PLAN
   add constraint FK_PLAN_SERVICIO__SERVICIO foreign key (CODIGO_SERVICIO)
      references SERVICIO (CODIGO_SERVICIO)
/

alter table PRODUCTO
   add constraint FK_PRODUCTO_PRODUCTO__PROMOCIO foreign key (CODIGO_PROMOCION)
      references PROMOCION (CODIGO_PROMOCION)
/

alter table PROMOCION
   add constraint FK_PROMOCIO_CAMPANA_C_CAMPANA foreign key (CODIGO_CAMPANA)
      references CAMPANA (CODIGO_CAMPANA)
/

alter table SERVICIO
   add constraint FK_SERVICIO_SERVICIO__PROMOCIO foreign key (CODIGO_PROMOCION)
      references PROMOCION (CODIGO_PROMOCION)
/

alter table TELEFONO_CLIENTE
   add constraint FK_TELEFONO_CLIENTE_T_CLIENTE foreign key (NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
      references CLIENTE (NUMERO_IDENTIFICACION, TIPO_IDENTIFICACION)
/

alter table TELEFONO_EMPRESA
   add constraint FK_TELEFONO_EMPRESA_T_EMPRESA foreign key (CEDULA_JURIDICA)
      references EMPRESA (CEDULA_JURIDICA)
/

create procedure DELETE_CAMPANIA  (p_CODIGO_CAMPANA IN VARCHAR2) as
begin
delete from CAMPANA
where CAMPANA.CODIGO_CAMPANA = p_CODIGO_CAMPANA;
end DELETE_CAMPANIA;
/

create procedure DELETE_CANTON  (p_CODIGO_CANTON IN VARCHAR2) as
begin
delete from CANTON
where CANTON.CODIGO_CANTON = p_CODIGO_CANTON;
end DELETE_CANTON;
/

create procedure DELETE_CICLO_FACTURABLE  (p_CODIGO_CICLO IN VARCHAR2) as
begin
delete from CICLO_FACTURABLE
where CICLO_FACTURABLE.CODIGO_CICLO = p_CODIGO_CICLO;
end DELETE_CICLO_FACTURABLE;
/

create procedure DELETE_CLIENTE  (p_TIPO_IDENTIFICACION IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER) as
begin
delete from CLIENTE
where CLIENTE.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION and CLIENTE.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION;
end DELETE_CLIENTE;
/

create procedure DELETE_CONTRATO  (p_NUMERO_CONTRATO IN NUMBER) as
begin
delete from CONTRATO
where CONTRATO.NUMERO_CONTRATO = p_NUMERO_CONTRATO;
end DELETE_CONTRATO;
/

create procedure DELETE_CUENTA  (p_CODIGO_CUENTA IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2) as
begin
delete from CUENTA
where CUENTA.CODIGO_CUENTA = p_CODIGO_CUENTA and CUENTA.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION and CUENTA.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION;
end DELETE_CUENTA;
/

create procedure DELETE_DIRECCION  (p_CODIGO_POSTAL_CLIENTE IN NUMBER) as
begin
delete from DIRECCION
where DIRECCION.CODIGO_POSTAL_CLIENTE = p_CODIGO_POSTAL_CLIENTE;
end DELETE_DIRECCION;
/

create procedure DELETE_DISTRITO  (p_CODIGO_DISTRITO IN VARCHAR2) as
begin
delete from DISTRITO
where DISTRITO.CODIGO_DISTRITO = p_CODIGO_DISTRITO;
end DELETE_DISTRITO;
/

create procedure DELETE_EMPRESA  (p_CEDULA_JURIDICA IN NUMBER) as
begin
delete from EMPRESA
where EMPRESA.CEDULA_JURIDICA = p_CEDULA_JURIDICA;
end DELETE_EMPRESA;
/

create procedure DELETE_FACTURA  (p_NUMERO_FACTURA IN NUMBER) as
begin
delete from FACTURA
where FACTURA.NUMERO_FACTURA = p_NUMERO_FACTURA;
end DELETE_FACTURA;
/

create procedure DELETE_INFORMACION_LABORAL  (p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2) as
begin
delete from INFORMACION_LABORAL
where INFORMACION_LABORAL.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION and INFORMACION_LABORAL.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION;
end DELETE_INFORMACION_LABORAL;
/

create procedure DELETE_LINEA_FACTURA  (p_NUMERO_FACTURA IN NUMBER) as
begin
delete from LINEA_FACTURA
where LINEA_FACTURA.NUMERO_FACTURA = p_NUMERO_FACTURA;
end DELETE_LINEA_FACTURA;
/

create procedure DELETE_PLAN  (p_CODIGO_PLAN IN VARCHAR2) as
begin
delete from PLAN
where PLAN.CODIGO_PLAN = p_CODIGO_PLAN;
end DELETE_PLAN;
/

create procedure DELETE_PRODUCTO  (p_CODIGO_PRODUCTO IN VARCHAR2) as
begin
delete from PRODUCTO
where PRODUCTO.CODIGO_PRODUCTO = p_CODIGO_PRODUCTO;
end DELETE_PRODUCTO;
/

create procedure DELETE_PROMOCION  (p_CODIGO_PROMOCION IN VARCHAR2) as
begin
delete from PROMOCION
where PROMOCION.CODIGO_PROMOCION = p_CODIGO_PROMOCION;
end DELETE_PROMOCION;
/

create procedure DELETE_PROVINCIA  (p_CODIGO_PROVINCIA IN VARCHAR2) as
begin
delete from PROVINCIA
where PROVINCIA.CODIGO_PROVINCIA = p_CODIGO_PROVINCIA;
end DELETE_PROVINCIA;
/

create procedure DELETE_SERVICIO  (p_CODIGO_SERVICIO IN VARCHAR2) as
begin
delete from SERVICIO
where SERVICIO.CODIGO_SERVICIO = p_CODIGO_SERVICIO;
end DELETE_SERVICIO;
/

create procedure DELETE_TELEFONO_CLIENTE  (p_NUMERO_TELEFONO IN NUMBER) as
begin
delete from TELEFONO_CLIENTE
where TELEFONO_CLIENTE.NUMERO_TELEFONO = p_NUMERO_TELEFONO;
end DELETE_TELEFONO_CLIENTE;
/

create procedure DELETE_TELEFONO_EMPRESA  (p_NUMEROTEL_EMPRESA IN NUMBER) as
begin
delete from TELEFONO_EMPRESA
where TELEFONO_EMPRESA.NUMEROTEL_EMPRESA = p_NUMEROTEL_EMPRESA;
end DELETE_TELEFONO_EMPRESA;
/

create procedure INSERT_CAMPANIA  (p_CODIGO_CAMPANA IN VARCHAR2,p_DESCRIPCION_CAMPANA IN VARCHAR2,p_ESTADO_CAMPANA IN VARCHAR2,p_PROPOSITO_CAMPANA IN VARCHAR2,p_NOMBRE_CAMPANA IN VARCHAR2,p_TIPO_CAMPANA IN VARCHAR2) as
begin
insert into CAMPANA (CAMPANA.CODIGO_CAMPANA,CAMPANA.DESCRIPCION_CAMPANA,CAMPANA.ESTADO_CAMPANA,CAMPANA.PROPOSITO_CAMPANA,CAMPANA.NOMBRE_CAMPANA,CAMPANA.TIPO_CAMPANA)
values(p_CODIGO_CAMPANA,p_DESCRIPCION_CAMPANA,p_ESTADO_CAMPANA,p_PROPOSITO_CAMPANA,p_NOMBRE_CAMPANA,p_TIPO_CAMPANA);
end INSERT_CAMPANIA;
/

create procedure INSERT_CANTON  (p_CODIGO_CANTON IN VARCHAR2,p_NOMBRE_CANTON IN VARCHAR2) as
begin
insert into CANTON (CANTON.CODIGO_CANTON,CANTON.NOMBRE_CANTON)
values(p_CODIGO_CANTON,p_NOMBRE_CANTON);
end INSERT_CANTON;
/

create procedure INSERT_CICLO_FACTURABLE  (p_CODIGO_CICLO IN VARCHAR2,p_NOMBRE_CICLO IN VARCHAR2,p_TIEMPO_CICLO IN NUMBER,p_DESCRIPCION_CICLO IN VARCHAR2,p_DESCRIPCION_STATUS IN VARCHAR2,p_CODIGO_STATUS_CF IN VARCHAR2) as
begin
insert into CICLO_FACTURABLE (CICLO_FACTURABLE.CODIGO_CICLO,CICLO_FACTURABLE.NOMBRE_CICLO,CICLO_FACTURABLE.TIEMPO_CICLO,CICLO_FACTURABLE.DESCRIPCION_CICLO,CICLO_FACTURABLE.DESCRIPCION_STATUS,CICLO_FACTURABLE.CODIGO_STATUS_CF)
values(p_CODIGO_CICLO,p_NOMBRE_CICLO,p_TIEMPO_CICLO,p_DESCRIPCION_CICLO,p_DESCRIPCION_STATUS,p_CODIGO_STATUS_CF);
end INSERT_CICLO_FACTURABLE;
/

create procedure INSERT_CLIENTE  (p_TIPO_IDENTIFICACION IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER,p_CODIGO_POSTAL_CLIENTE IN NUMBER,p_NOMBRE_CLIENTE IN VARCHAR2,p_ESTADO_CIVIL IN VARCHAR2,p_EMAIL IN VARCHAR2,p_FECHANACIMIENTO IN DATE,p_SEXO IN VARCHAR2,p_NACIONALIDAD IN VARCHAR2,p_TIEMPO_RESIDENCIA_DOMICILIO IN NUMBER,p_NUMERO_DEPENDIENTES IN NUMBER,p_VENCIMIENTO_IDENTIFICACION IN DATE) as
begin
insert into CLIENTE (CLIENTE.TIPO_IDENTIFICACION,CLIENTE.NUMERO_IDENTIFICACION,CLIENTE.CODIGO_POSTAL_CLIENTE,CLIENTE.NOMBRE_CLIENTE,CLIENTE.ESTADO_CIVIL,CLIENTE.EMAIL,CLIENTE.FECHANACIMIENTO,CLIENTE.SEXO,CLIENTE.NACIONALIDAD,CLIENTE.TIEMPO_RESIDENCIA_DOMICILIO,CLIENTE.NUMERO_DEPENDIENTES,CLIENTE.VENCIMIENTO_IDENTIFICACION)
values(p_TIPO_IDENTIFICACION,p_NUMERO_IDENTIFICACION,p_CODIGO_POSTAL_CLIENTE,p_NOMBRE_CLIENTE,p_ESTADO_CIVIL,p_EMAIL,p_FECHANACIMIENTO,p_SEXO,p_NACIONALIDAD,p_TIEMPO_RESIDENCIA_DOMICILIO,p_NUMERO_DEPENDIENTES,p_VENCIMIENTO_IDENTIFICACION);
end INSERT_CLIENTE;
/

create procedure INSERT_CONTRATO  (p_NUMERO_CONTRATO IN NUMBER,p_CODIGO_CUENTA IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2,p_TIPO_CONTRATO IN VARCHAR2,p_FECHA_INICIO_CONTRATO IN DATE,p_NOMBRE_CONTRATO IN VARCHAR2,p_CANAL_COMUNICACION_CLIENTE IN VARCHAR2,p_DOCUMENTO_DIGITALIZADO IN VARCHAR2,p_INDICADOR_RENOV_CONT IN SMALLINT,p_NUMERO_ORDEN IN NUMBER,p_TERMINOS_PAGO IN VARCHAR2,p_CANAL_VENTA IN VARCHAR2,p_RAZON_CANCELACION IN VARCHAR2,p_FECHA_CANCELACION IN DATE,p_FECHA_FINAL_CONTRATO IN DATE,p_CODIGO_STATUS_CONTRATO IN VARCHAR2,p_COSTO_CONTRATO IN NUMBER,p_FECHA_INICIO_FACTURACION IN DATE) as
begin
insert into CONTRATO (CONTRATO.NUMERO_CONTRATO,CONTRATO.CODIGO_CUENTA,CONTRATO.NUMERO_IDENTIFICACION,CONTRATO.TIPO_IDENTIFICACION,CONTRATO.TIPO_CONTRATO,CONTRATO.FECHA_INICIO_CONTRATO,CONTRATO.NOMBRE_CONTRATO,CONTRATO.CANAL_COMUNICACION_CLIENTE,CONTRATO.DOCUMENTO_DIGITALIZADO,CONTRATO.INDICADOR_RENOVACION_CONTRATO,CONTRATO.NUMERO_ORDEN,CONTRATO.TERMINOS_PAGO,CONTRATO.CANAL_VENTA,CONTRATO.RAZON_CANCELACION,CONTRATO.FECHA_CANCELACION,CONTRATO.FECHA_FINAL_CONTRATO,CONTRATO.CODIGO_STATUS_CONTRATO,CONTRATO.COSTO_CONTRATO,CONTRATO.FECHA_INICIO_FACTURACION)
values(p_NUMERO_CONTRATO,p_CODIGO_CUENTA,p_NUMERO_IDENTIFICACION,p_TIPO_IDENTIFICACION,p_TIPO_CONTRATO,p_FECHA_INICIO_CONTRATO,p_NOMBRE_CONTRATO,p_CANAL_COMUNICACION_CLIENTE,p_DOCUMENTO_DIGITALIZADO,p_INDICADOR_RENOV_CONT,p_NUMERO_ORDEN,p_TERMINOS_PAGO,p_CANAL_VENTA,p_RAZON_CANCELACION,p_FECHA_CANCELACION,p_FECHA_FINAL_CONTRATO,p_CODIGO_STATUS_CONTRATO,p_COSTO_CONTRATO,p_FECHA_INICIO_FACTURACION);
end INSERT_CONTRATO;
/

create procedure INSERT_CUENTA  (p_CODIGO_CUENTA IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2,p_PH_CODIGO_CUENTA IN VARCHAR2,p_PH_NUMERO_IDENTIFICACION IN NUMBER,p_PH_TIPO_IDENTIFICACION IN VARCHAR2,p_NOMBRE_CUENTA IN VARCHAR2,p_TIPO_CODIGO_CUENTA IN VARCHAR2,p_ULTIMA_FECHA_REAPERTURA IN DATE,p_FECHA_CREACION IN DATE,p_CODIGO_SEGMENTO IN VARCHAR2,p_NOMBRE_EMPLEADO_CREADOR IN VARCHAR2,p_ESTADO_CUENTA IN VARCHAR2,p_ULTIMA_FECHA_SUSPENCION IN DATE,p_FECHA_CIERRE_TERMINO IN DATE,p_CICLO_ASOCIADO_CUENTA IN VARCHAR2,p_FECHA_EFECTIVA_CIERRE IN DATE,p_FECHA_EFECTIVA_INICIO IN DATE,p_FECHA_ULTIMA_ACTIVIDAD IN DATE,p_CATEGORIA_CREDITO IN NUMBER,p_DIAS_DESPUES_PAGO IN NUMBER) as
begin
insert into CUENTA (CUENTA.CODIGO_CUENTA,CUENTA.NUMERO_IDENTIFICACION,CUENTA.TIPO_IDENTIFICACION,CUENTA.PH_CODIGO_CUENTA,CUENTA.PH_NUMERO_IDENTIFICACION,CUENTA.PH_TIPO_IDENTIFICACION,CUENTA.NOMBRE_CUENTA,CUENTA.TIPO_CODIGO_CUENTA,CUENTA.ULTIMA_FECHA_REAPERTURA,CUENTA.FECHA_CREACION,CUENTA.CODIGO_SEGMENTO,CUENTA.NOMBRE_EMPLEADO_CREADOR,CUENTA.ESTADO_CUENTA,CUENTA.ULTIMA_FECHA_SUSPENCION,CUENTA.FECHA_CIERRE_TERMINO,CUENTA.CICLO_ASOCIADO_CUENTA,CUENTA.FECHA_EFECTIVA_CIERRE,CUENTA.FECHA_EFECTIVA_INICIO,CUENTA.FECHA_ULTIMA_ACTIVIDAD,CUENTA.CATEGORIA_CREDITO,CUENTA.DIAS_DESPUES_PAGO)
values(p_CODIGO_CUENTA,p_NUMERO_IDENTIFICACION,p_TIPO_IDENTIFICACION,p_PH_CODIGO_CUENTA,p_PH_NUMERO_IDENTIFICACION,p_PH_TIPO_IDENTIFICACION,p_NOMBRE_CUENTA,p_TIPO_CODIGO_CUENTA,p_ULTIMA_FECHA_REAPERTURA,p_FECHA_CREACION,p_CODIGO_SEGMENTO,p_NOMBRE_EMPLEADO_CREADOR,p_ESTADO_CUENTA,p_ULTIMA_FECHA_SUSPENCION,p_FECHA_CIERRE_TERMINO,p_CICLO_ASOCIADO_CUENTA,p_FECHA_EFECTIVA_CIERRE,p_FECHA_EFECTIVA_INICIO,p_FECHA_ULTIMA_ACTIVIDAD,p_CATEGORIA_CREDITO,p_DIAS_DESPUES_PAGO);
end INSERT_CUENTA;
/

create procedure INSERT_DIRECCION  (p_CODIGO_POSTAL_CLIENTE IN NUMBER,p_CODIGO_PROVINCIA IN VARCHAR2,p_CODIGO_DISTRITO IN VARCHAR2,p_CODIGO_CANTON IN VARCHAR2) as
begin
insert into DIRECCION (DIRECCION.CODIGO_POSTAL_CLIENTE,DIRECCION.CODIGO_PROVINCIA,DIRECCION.CODIGO_DISTRITO,DIRECCION.CODIGO_CANTON)
values(p_CODIGO_POSTAL_CLIENTE,p_CODIGO_PROVINCIA,p_CODIGO_DISTRITO,p_CODIGO_CANTON);
end INSERT_DIRECCION;
/

create procedure INSERT_DISTRITO  (p_CODIGO_DISTRITO IN VARCHAR2,p_NOMBRE_DISTRITO IN VARCHAR2) as
begin
insert into DISTRITO (DISTRITO.CODIGO_DISTRITO,DISTRITO.NOMBRE_DISTRITO)
values(p_CODIGO_DISTRITO,p_NOMBRE_DISTRITO);
end INSERT_DISTRITO;
/

create procedure INSERT_EMPRESA  (p_CEDULA_JURIDICA IN NUMBER,p_CODIGO_POSTAL_CLIENTE IN NUMBER,p_NOMBRE_EMPRESA IN VARCHAR2) as
begin
insert into EMPRESA (EMPRESA.CEDULA_JURIDICA,EMPRESA.CODIGO_POSTAL_CLIENTE,EMPRESA.NOMBRE_EMPRESA)
values(p_CEDULA_JURIDICA,p_CODIGO_POSTAL_CLIENTE,p_NOMBRE_EMPRESA);
end INSERT_EMPRESA;
/

create procedure INSERT_FACTURA  (p_NUMERO_FACTURA IN NUMBER,p_CODIGO_CICLO IN VARCHAR2,p_NUMERO_CONTRATO IN NUMBER,p_MONTO_AMORTIZADO IN NUMBER,p_MONTO_REPORTADO IN NUMBER,p_CICLO_ASOCIADO_BILLING IN VARCHAR2,p_FECHA_FACTURA IN DATE,p_SUB_TOTAL IN NUMBER,p_TOTAL IN NUMBER) as
begin
insert into FACTURA (FACTURA.NUMERO_FACTURA,FACTURA.CODIGO_CICLO,FACTURA.NUMERO_CONTRATO,FACTURA.MONTO_AMORTIZADO,FACTURA.MONTO_REPORTADO,FACTURA.CICLO_ASOCIADO_BILLING,FACTURA.FECHA_FACTURA,FACTURA.SUB_TOTAL,FACTURA.TOTAL)
values(p_NUMERO_FACTURA,p_CODIGO_CICLO,p_NUMERO_CONTRATO,p_MONTO_AMORTIZADO,p_MONTO_REPORTADO,p_CICLO_ASOCIADO_BILLING,p_FECHA_FACTURA,p_SUB_TOTAL,p_TOTAL);
end INSERT_FACTURA;
/

create procedure INSERT_INFORMACION_LABORAL  (p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2,p_CEDULA_JURIDICA IN NUMBER,p_PUESTO IN VARCHAR2,p_PUESTO_ANTERIOR IN VARCHAR2,p_EMPRESA_PROPIA IN VARCHAR2,p_PATRONO_ANTERIOR IN VARCHAR2,p_FECHA_INGRESO IN DATE,p_SALARIO_BRUTO IN NUMBER,p_SALARIO_NETO IN NUMBER,p_OTROS_INGRESOS IN NUMBER) as
begin
insert into INFORMACION_LABORAL (INFORMACION_LABORAL.NUMERO_IDENTIFICACION,INFORMACION_LABORAL.TIPO_IDENTIFICACION,INFORMACION_LABORAL.CEDULA_JURIDICA,INFORMACION_LABORAL.PUESTO,INFORMACION_LABORAL.PUESTO_ANTERIOR,INFORMACION_LABORAL.EMPRESA_PROPIA,INFORMACION_LABORAL.PATRONO_ANTERIOR,INFORMACION_LABORAL.FECHA_INGRESO,INFORMACION_LABORAL.SALARIO_BRUTO,INFORMACION_LABORAL.SALARIO_NETO,INFORMACION_LABORAL.OTROS_INGRESOS)
values(p_NUMERO_IDENTIFICACION,p_TIPO_IDENTIFICACION,p_CEDULA_JURIDICA,p_PUESTO,p_PUESTO_ANTERIOR,p_EMPRESA_PROPIA,p_PATRONO_ANTERIOR,p_FECHA_INGRESO,p_SALARIO_BRUTO,p_SALARIO_NETO,p_OTROS_INGRESOS);
end INSERT_INFORMACION_LABORAL;
/

create procedure INSERT_LINEA_FACTURA  (p_NUMERO_FACTURA IN NUMBER,p_CODIGO_PRODUCTO IN VARCHAR2,p_CODIGO_SERVICIO IN VARCHAR2,p_CANTIDAD IN NUMBER,p_PRECIO_LINEA IN NUMBER) as
begin
insert into LINEA_FACTURA (LINEA_FACTURA.NUMERO_FACTURA,LINEA_FACTURA.CODIGO_PRODUCTO,LINEA_FACTURA.CODIGO_SERVICIO,LINEA_FACTURA.CANTIDAD,LINEA_FACTURA.PRECIO_LINEA)
values(p_NUMERO_FACTURA,p_CODIGO_PRODUCTO,p_CODIGO_SERVICIO,p_CANTIDAD,p_PRECIO_LINEA);
end INSERT_LINEA_FACTURA;
/

create procedure INSERT_PLAN  (p_CODIGO_PLAN IN VARCHAR2,p_CODIGO_PRODUCTO IN VARCHAR2,p_CODIGO_SERVICIO IN VARCHAR2,p_FECHA_EFECTIVA_INICIO_PLAN IN DATE,p_FECHA_EFECTIVA_FIN_PLAN IN DATE,p_TIPO_PLAN IN VARCHAR2,p_NOMBRE_PLAN IN VARCHAR2,p_FREE_TIME IN NUMBER,p_TIEMPO_TOTAL_PERMANENCIA IN NUMBER,p_TIEMPO_NO_PENALIDAD IN NUMBER,p_PROGRAMA_LEALTAD IN SMALLINT) as
begin
insert into PLAN (PLAN.CODIGO_PLAN,PLAN.CODIGO_PRODUCTO,PLAN.CODIGO_SERVICIO,PLAN.FECHA_EFECTIVA_INICIO_PLAN,PLAN.FECHA_EFECTIVA_FIN_PLAN,PLAN.TIPO_PLAN,PLAN.NOMBRE_PLAN,PLAN.FREE_TIME,PLAN.TIEMPO_TOTAL_PERMANENCIA,PLAN.TIEMPO_NO_PENALIDAD,PLAN.PROGRAMA_LEALTAD)
values(p_CODIGO_PLAN,p_CODIGO_PRODUCTO,p_CODIGO_SERVICIO,p_FECHA_EFECTIVA_INICIO_PLAN,p_FECHA_EFECTIVA_FIN_PLAN,p_TIPO_PLAN,p_NOMBRE_PLAN,p_FREE_TIME,p_TIEMPO_TOTAL_PERMANENCIA,p_TIEMPO_NO_PENALIDAD,p_PROGRAMA_LEALTAD);
end INSERT_PLAN;
/

create procedure INSERT_PRODUCTO  (p_CODIGO_PRODUCTO IN VARCHAR2,p_CODIGO_PROMOCION IN VARCHAR2,p_DESCUENTO IN NUMBER,p_TIPO_PRODUCTO IN VARCHAR2,p_DECRIPCION IN VARCHAR2,p_NOMBRE IN VARCHAR2,p_DEPOSITO_INICIAL IN NUMBER,p_PRECIO_TOTAL IN NUMBER,p_MONTO_CASTIGO IN NUMBER,p_CODIGO_STATUS IN VARCHAR2,p_FECHA_EFEC_INI_PROD IN DATE,p_FECHA_EFECTIVA_FIN_PRODUCTO IN DATE) as
begin
insert into PRODUCTO (PRODUCTO.CODIGO_PRODUCTO,PRODUCTO.CODIGO_PROMOCION,PRODUCTO.DESCUENTO,PRODUCTO.TIPO_PRODUCTO,PRODUCTO.DECRIPCION,PRODUCTO.NOMBRE,PRODUCTO.DEPOSITO_INICIAL,PRODUCTO.PRECIO_TOTAL,PRODUCTO.MONTO_CASTIGO,PRODUCTO.CODIGO_STATUS,PRODUCTO.FECHA_EFECTIVA_INICIO_PRODUCTO,PRODUCTO.FECHA_EFECTIVA_FIN_PRODUCTO)
values(p_CODIGO_PRODUCTO,p_CODIGO_PROMOCION,p_DESCUENTO,p_TIPO_PRODUCTO,p_DECRIPCION,p_NOMBRE,p_DEPOSITO_INICIAL,p_PRECIO_TOTAL,p_MONTO_CASTIGO,p_CODIGO_STATUS,p_FECHA_EFEC_INI_PROD,p_FECHA_EFECTIVA_FIN_PRODUCTO);
end INSERT_PRODUCTO;
/

create procedure INSERT_PROMOCION  (p_CODIGO_PROMOCION IN VARCHAR2,p_CODIGO_CAMPANA IN VARCHAR2,p_TOTAL_COSTO IN NUMBER,p_NUMERO_TOTAL_VENTAS IN NUMBER,p_DESCRIPCION_PROMOCION IN VARCHAR2,p_NOMBRE_PROMOCION IN VARCHAR2,p_EMPLEADO_RESPONSABLE IN VARCHAR2,p_NOMBRE_PARTNER IN VARCHAR2,p_TEMA IN VARCHAR2,p_TIPO_PROMOCION IN VARCHAR2,p_FECHA_INICIO_PROMOCION IN DATE,p_FECHA_FIN_PROMOCION IN DATE,p_FECHA_EFECTIVA_INICIO_PROMO IN DATE,p_FECHA_EFECTIVA_FIN_PROMO IN DATE) as
begin
insert into PROMOCION (PROMOCION.CODIGO_PROMOCION,PROMOCION.CODIGO_CAMPANA,PROMOCION.TOTAL_COSTO,PROMOCION.NUMERO_TOTAL_VENTAS,PROMOCION.DESCRIPCION_PROMOCION,PROMOCION.NOMBRE_PROMOCION,PROMOCION.EMPLEADO_RESPONSABLE,PROMOCION.NOMBRE_PARTNER,PROMOCION.TEMA,PROMOCION.TIPO_PROMOCION,PROMOCION.FECHA_INICIO_PROMOCION,PROMOCION.FECHA_FIN_PROMOCION,PROMOCION.FECHA_EFECTIVA_INICIO_PROMO,PROMOCION.FECHA_EFECTIVA_FIN_PROMO)
values(p_CODIGO_PROMOCION,p_CODIGO_CAMPANA,p_TOTAL_COSTO,p_NUMERO_TOTAL_VENTAS,p_DESCRIPCION_PROMOCION,p_NOMBRE_PROMOCION,p_EMPLEADO_RESPONSABLE,p_NOMBRE_PARTNER,p_TEMA,p_TIPO_PROMOCION,p_FECHA_INICIO_PROMOCION,p_FECHA_FIN_PROMOCION,p_FECHA_EFECTIVA_INICIO_PROMO,p_FECHA_EFECTIVA_FIN_PROMO);
end INSERT_PROMOCION;
/

create procedure INSERT_PROVINCIA  (p_CODIGO_PROVINCIA IN VARCHAR2,p_NOMBRE_PROVINCIA IN VARCHAR2) as
begin
insert into PROVINCIA (PROVINCIA.CODIGO_PROVINCIA,PROVINCIA.NOMBRE_PROVINCIA)
values(p_CODIGO_PROVINCIA,p_NOMBRE_PROVINCIA);
end INSERT_PROVINCIA;
/

create procedure INSERT_SERVICIO  (p_CODIGO_SERVICIO IN VARCHAR2,p_CODIGO_PROMOCION IN VARCHAR2,p_NOMBRE_SERVICIO IN VARCHAR2,p_DESCRIPCION_SERVICIO IN VARCHAR2,p_TIPO_SERVICIO IN VARCHAR2,p_COSTO_SERVICIO IN NUMBER,p_CODIGO_STATUS_SERV IN VARCHAR2,p_MONTO_CASTIGO_SERV IN NUMBER,p_FECHA_EFECTIVA_INICIO_SERV IN DATE,p_FECHA_EFECTIVA_FIN_SERV IN DATE) as
begin
insert into SERVICIO (SERVICIO.CODIGO_SERVICIO,SERVICIO.CODIGO_PROMOCION,SERVICIO.NOMBRE_SERVICIO,SERVICIO.DESCRIPCION_SERVICIO,SERVICIO.TIPO_SERVICIO,SERVICIO.COSTO_SERVICIO,SERVICIO.CODIGO_STATUS_SERV,SERVICIO.MONTO_CASTIGO_SERV,SERVICIO.FECHA_EFECTIVA_INICIO_SERV,SERVICIO.FECHA_EFECTIVA_FIN_SERV)
values(p_CODIGO_SERVICIO,p_CODIGO_PROMOCION,p_NOMBRE_SERVICIO,p_DESCRIPCION_SERVICIO,p_TIPO_SERVICIO,p_COSTO_SERVICIO,p_CODIGO_STATUS_SERV,p_MONTO_CASTIGO_SERV,p_FECHA_EFECTIVA_INICIO_SERV,p_FECHA_EFECTIVA_FIN_SERV);
end INSERT_SERVICIO;
/

create procedure INSERT_TELEFONO_CLIENTE  (p_NUMERO_TELEFONO IN NUMBER,p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2,p_TIPO_TELEFONO IN VARCHAR2) as
begin
insert into TELEFONO_CLIENTE (TELEFONO_CLIENTE.NUMERO_TELEFONO,TELEFONO_CLIENTE.NUMERO_IDENTIFICACION,TELEFONO_CLIENTE.TIPO_IDENTIFICACION,TELEFONO_CLIENTE.TIPO_TELEFONO)
values(p_NUMERO_TELEFONO,p_NUMERO_IDENTIFICACION,p_TIPO_IDENTIFICACION,p_TIPO_TELEFONO);
end INSERT_TELEFONO_CLIENTE;
/

create procedure INSERT_TELEFONO_EMPRESA  (p_NUMEROTEL_EMPRESA IN NUMBER,p_CEDULA_JURIDICA IN NUMBER,p_OTROS_NUMERO_TELEFONICO IN NUMBER,p_FAX IN NUMBER) as
begin
insert into TELEFONO_EMPRESA (TELEFONO_EMPRESA.NUMEROTEL_EMPRESA,TELEFONO_EMPRESA.CEDULA_JURIDICA,TELEFONO_EMPRESA.OTROS_NUMERO_TELEFONICO,TELEFONO_EMPRESA.FAX)
values(p_NUMEROTEL_EMPRESA,p_CEDULA_JURIDICA,p_OTROS_NUMERO_TELEFONICO,p_FAX);
end INSERT_TELEFONO_EMPRESA;
/

create or replace function SELECT_CAMPANIA  (p_CODIGO_CAMPANA IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from CAMPANA
where CAMPANA.CODIGO_CAMPANA = p_CODIGO_CAMPANA;
return my_cursor;
end SELECT_CAMPANIA;
/

create or replace function SELECT_CANTON  (p_CODIGO_CANTON IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from CANTON
where CANTON.CODIGO_CANTON = p_CODIGO_CANTON;
return my_cursor;
end SELECT_CANTON;
/

create or replace function SELECT_CICLO_FACTURABLE  (p_CODIGO_CICLO IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from CICLO_FACTURABLE
where CICLO_FACTURABLE.CODIGO_CICLO = p_CODIGO_CICLO;
return my_cursor;
end SELECT_CICLO_FACTURABLE;
/

create or replace function SELECT_CLIENTE  (p_TIPO_IDENTIFICACION IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from CLIENTE
where CLIENTE.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION and CLIENTE.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION;
return my_cursor;
end SELECT_CLIENTE;
/

create or replace function SELECT_CONTRATO  (p_NUMERO_CONTRATO IN NUMBER) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from CONTRATO
where CONTRATO.NUMERO_CONTRATO = p_NUMERO_CONTRATO;
return my_cursor;
end SELECT_CONTRATO;
/

create or replace function SELECT_CUENTA  (p_CODIGO_CUENTA IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from CUENTA
where CUENTA.CODIGO_CUENTA = p_CODIGO_CUENTA and CUENTA.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION and CUENTA.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION;
return my_cursor;
end SELECT_CUENTA;
/

create or replace function SELECT_DIRECCION  (p_CODIGO_POSTAL_CLIENTE IN NUMBER) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from DIRECCION
where DIRECCION.CODIGO_POSTAL_CLIENTE = p_CODIGO_POSTAL_CLIENTE;
return my_cursor;
end SELECT_DIRECCION;
/

create or replace function SELECT_DISTRITO  (p_CODIGO_DISTRITO IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from DISTRITO
where DISTRITO.CODIGO_DISTRITO = p_CODIGO_DISTRITO;
return my_cursor;
end SELECT_DISTRITO;
/

create or replace function SELECT_EMPRESA  (p_CEDULA_JURIDICA IN NUMBER) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from EMPRESA
where EMPRESA.CEDULA_JURIDICA = p_CEDULA_JURIDICA;
return my_cursor;
end SELECT_EMPRESA;
/

create or replace function SELECT_FACTURA  (p_NUMERO_FACTURA IN NUMBER) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from FACTURA
where FACTURA.NUMERO_FACTURA = p_NUMERO_FACTURA;
return my_cursor;
end SELECT_FACTURA;
/

create or replace function SELECT_INFORMACION_LABORAL  (p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from INFORMACION_LABORAL
where INFORMACION_LABORAL.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION and INFORMACION_LABORAL.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION;
return my_cursor;
end SELECT_INFORMACION_LABORAL;
/

create or replace function SELECT_LINEA_FACTURA  (p_NUMERO_FACTURA IN NUMBER) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from LINEA_FACTURA
where LINEA_FACTURA.NUMERO_FACTURA = p_NUMERO_FACTURA;
return my_cursor;
end SELECT_LINEA_FACTURA;
/

create or replace function SELECT_PLAN  (p_CODIGO_PLAN IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from PLAN
where PLAN.CODIGO_PLAN = p_CODIGO_PLAN;
return my_cursor;
end SELECT_PLAN;
/

create or replace function SELECT_PRODUCTO  (p_CODIGO_PRODUCTO IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from PRODUCTO
where PRODUCTO.CODIGO_PRODUCTO = p_CODIGO_PRODUCTO;
return my_cursor;
end SELECT_PRODUCTO;
/

create or replace function SELECT_PROMOCION  (p_CODIGO_PROMOCION IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from PROMOCION
where PROMOCION.CODIGO_PROMOCION = p_CODIGO_PROMOCION;
return my_cursor;
end SELECT_PROMOCION;
/

create or replace function SELECT_PROVINCIA  (p_CODIGO_PROVINCIA IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from PROVINCIA
where PROVINCIA.CODIGO_PROVINCIA = p_CODIGO_PROVINCIA;
return my_cursor;
end SELECT_PROVINCIA;
/

create or replace function SELECT_SERVICIO  (p_CODIGO_SERVICIO IN VARCHAR2) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from SERVICIO
where SERVICIO.CODIGO_SERVICIO = p_CODIGO_SERVICIO;
return my_cursor;
end SELECT_SERVICIO;
/

create or replace function SELECT_TELEFONO_CLIENTE  (p_NUMERO_TELEFONO IN NUMBER) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from TELEFONO_CLIENTE
where TELEFONO_CLIENTE.NUMERO_TELEFONO = p_NUMERO_TELEFONO;
return my_cursor;
end SELECT_TELEFONO_CLIENTE;
/

create or replace function SELECT_TELEFONO_EMPRESA  (p_NUMEROTEL_EMPRESA IN NUMBER) 
RETURN SYS_REFCURSOR is
my_cursor SYS_REFCURSOR;
begin
open my_cursor for
select * from TELEFONO_EMPRESA
where TELEFONO_EMPRESA.NUMEROTEL_EMPRESA = p_NUMEROTEL_EMPRESA;
return my_cursor;
end SELECT_TELEFONO_EMPRESA;
/

create procedure UPDATE_CAMPANIA  (p_CODIGO_CAMPANA IN VARCHAR2,p_DESCRIPCION_CAMPANA IN VARCHAR2,p_ESTADO_CAMPANA IN VARCHAR2,p_PROPOSITO_CAMPANA IN VARCHAR2,p_NOMBRE_CAMPANA IN VARCHAR2,p_TIPO_CAMPANA IN VARCHAR2) as
begin
update CAMPANA
set CAMPANA.DESCRIPCION_CAMPANA = p_DESCRIPCION_CAMPANA, CAMPANA.ESTADO_CAMPANA = p_ESTADO_CAMPANA, CAMPANA.PROPOSITO_CAMPANA = p_PROPOSITO_CAMPANA, CAMPANA.NOMBRE_CAMPANA = p_NOMBRE_CAMPANA, CAMPANA.TIPO_CAMPANA = p_TIPO_CAMPANA
where (CAMPANA.CODIGO_CAMPANA = p_CODIGO_CAMPANA);
end UPDATE_CAMPANIA;
/

create procedure UPDATE_CANTON  (p_CODIGO_CANTON IN VARCHAR2,p_NOMBRE_CANTON IN VARCHAR2) as
begin
update CANTON
set CANTON.NOMBRE_CANTON = p_NOMBRE_CANTON
where (CANTON.CODIGO_CANTON = p_CODIGO_CANTON);
end UPDATE_CANTON;
/

create procedure UPDATE_CICLO_FACTURABLE  (p_CODIGO_CICLO IN VARCHAR2,p_NOMBRE_CICLO IN VARCHAR2,p_TIEMPO_CICLO IN NUMBER,p_DESCRIPCION_CICLO IN VARCHAR2,p_DESCRIPCION_STATUS IN VARCHAR2,p_CODIGO_STATUS_CF IN VARCHAR2) as
begin
update CICLO_FACTURABLE
set CICLO_FACTURABLE.NOMBRE_CICLO = p_NOMBRE_CICLO, CICLO_FACTURABLE.TIEMPO_CICLO = p_TIEMPO_CICLO, CICLO_FACTURABLE.DESCRIPCION_CICLO = p_DESCRIPCION_CICLO, CICLO_FACTURABLE.DESCRIPCION_STATUS = p_DESCRIPCION_STATUS, CICLO_FACTURABLE.CODIGO_STATUS_CF = p_CODIGO_STATUS_CF
where (CICLO_FACTURABLE.CODIGO_CICLO = p_CODIGO_CICLO);
end UPDATE_CICLO_FACTURABLE;
/

create procedure UPDATE_CLIENTE  (p_TIPO_IDENTIFICACION IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER,p_CODIGO_POSTAL_CLIENTE IN NUMBER,p_NOMBRE_CLIENTE IN VARCHAR2,p_ESTADO_CIVIL IN VARCHAR2,p_EMAIL IN VARCHAR2,p_FECHANACIMIENTO IN DATE,p_SEXO IN VARCHAR2,p_NACIONALIDAD IN VARCHAR2,p_TIEMPO_RESIDENCIA_DOMICILIO IN NUMBER,p_NUMERO_DEPENDIENTES IN NUMBER,p_VENCIMIENTO_IDENTIFICACION IN DATE) as
begin
update CLIENTE
set CLIENTE.CODIGO_POSTAL_CLIENTE = p_CODIGO_POSTAL_CLIENTE, CLIENTE.NOMBRE_CLIENTE = p_NOMBRE_CLIENTE, CLIENTE.ESTADO_CIVIL = p_ESTADO_CIVIL, CLIENTE.EMAIL = p_EMAIL, CLIENTE.FECHANACIMIENTO = p_FECHANACIMIENTO, CLIENTE.SEXO = p_SEXO, CLIENTE.NACIONALIDAD = p_NACIONALIDAD, CLIENTE.TIEMPO_RESIDENCIA_DOMICILIO = p_TIEMPO_RESIDENCIA_DOMICILIO, CLIENTE.NUMERO_DEPENDIENTES = p_NUMERO_DEPENDIENTES, CLIENTE.VENCIMIENTO_IDENTIFICACION = p_VENCIMIENTO_IDENTIFICACION
where (CLIENTE.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION and CLIENTE.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION);
end UPDATE_CLIENTE;
/

create procedure UPDATE_CONTRATO  (p_NUMERO_CONTRATO IN NUMBER,p_CODIGO_CUENTA IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2,p_TIPO_CONTRATO IN VARCHAR2,p_FECHA_INICIO_CONTRATO IN DATE,p_NOMBRE_CONTRATO IN VARCHAR2,p_CANAL_COMUNICACION_CLIENTE IN VARCHAR2,p_DOCUMENTO_DIGITALIZADO IN VARCHAR2,p_INDICADOR_RENOV_CONT IN SMALLINT,p_NUMERO_ORDEN IN NUMBER,p_TERMINOS_PAGO IN VARCHAR2,p_CANAL_VENTA IN VARCHAR2,p_RAZON_CANCELACION IN VARCHAR2,p_FECHA_CANCELACION IN DATE,p_FECHA_FINAL_CONTRATO IN DATE,p_CODIGO_STATUS_CONTRATO IN VARCHAR2,p_COSTO_CONTRATO IN NUMBER,p_FECHA_INICIO_FACTURACION IN DATE) as
begin
update CONTRATO
set CONTRATO.CODIGO_CUENTA = p_CODIGO_CUENTA, CONTRATO.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION, CONTRATO.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION, CONTRATO.TIPO_CONTRATO = p_TIPO_CONTRATO, CONTRATO.FECHA_INICIO_CONTRATO = p_FECHA_INICIO_CONTRATO, CONTRATO.NOMBRE_CONTRATO = p_NOMBRE_CONTRATO, CONTRATO.CANAL_COMUNICACION_CLIENTE = p_CANAL_COMUNICACION_CLIENTE, CONTRATO.DOCUMENTO_DIGITALIZADO = p_DOCUMENTO_DIGITALIZADO, CONTRATO.INDICADOR_RENOVACION_CONTRATO = p_INDICADOR_RENOV_CONT, CONTRATO.NUMERO_ORDEN = p_NUMERO_ORDEN, CONTRATO.TERMINOS_PAGO = p_TERMINOS_PAGO, CONTRATO.CANAL_VENTA = p_CANAL_VENTA, CONTRATO.RAZON_CANCELACION = p_RAZON_CANCELACION, CONTRATO.FECHA_CANCELACION = p_FECHA_CANCELACION, CONTRATO.FECHA_FINAL_CONTRATO = p_FECHA_FINAL_CONTRATO, CONTRATO.CODIGO_STATUS_CONTRATO = p_CODIGO_STATUS_CONTRATO, CONTRATO.COSTO_CONTRATO = p_COSTO_CONTRATO, CONTRATO.FECHA_INICIO_FACTURACION = p_FECHA_INICIO_FACTURACION
where (CONTRATO.NUMERO_CONTRATO = p_NUMERO_CONTRATO);
end UPDATE_CONTRATO;
/

create procedure UPDATE_CUENTA  (p_CODIGO_CUENTA IN VARCHAR2,p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2,p_PH_CODIGO_CUENTA IN VARCHAR2,p_PH_NUMERO_IDENTIFICACION IN NUMBER,p_PH_TIPO_IDENTIFICACION IN VARCHAR2,p_NOMBRE_CUENTA IN VARCHAR2,p_TIPO_CODIGO_CUENTA IN VARCHAR2,p_ULTIMA_FECHA_REAPERTURA IN DATE,p_FECHA_CREACION IN DATE,p_CODIGO_SEGMENTO IN VARCHAR2,p_NOMBRE_EMPLEADO_CREADOR IN VARCHAR2,p_ESTADO_CUENTA IN VARCHAR2,p_ULTIMA_FECHA_SUSPENCION IN DATE,p_FECHA_CIERRE_TERMINO IN DATE,p_CICLO_ASOCIADO_CUENTA IN VARCHAR2,p_FECHA_EFECTIVA_CIERRE IN DATE,p_FECHA_EFECTIVA_INICIO IN DATE,p_FECHA_ULTIMA_ACTIVIDAD IN DATE,p_CATEGORIA_CREDITO IN NUMBER,p_DIAS_DESPUES_PAGO IN NUMBER) as
begin
update CUENTA
set CUENTA.PH_CODIGO_CUENTA = p_PH_CODIGO_CUENTA, CUENTA.PH_NUMERO_IDENTIFICACION = p_PH_NUMERO_IDENTIFICACION, CUENTA.PH_TIPO_IDENTIFICACION = p_PH_TIPO_IDENTIFICACION, CUENTA.NOMBRE_CUENTA = p_NOMBRE_CUENTA, CUENTA.TIPO_CODIGO_CUENTA = p_TIPO_CODIGO_CUENTA, CUENTA.ULTIMA_FECHA_REAPERTURA = p_ULTIMA_FECHA_REAPERTURA, CUENTA.FECHA_CREACION = p_FECHA_CREACION, CUENTA.CODIGO_SEGMENTO = p_CODIGO_SEGMENTO, CUENTA.NOMBRE_EMPLEADO_CREADOR = p_NOMBRE_EMPLEADO_CREADOR, CUENTA.ESTADO_CUENTA = p_ESTADO_CUENTA, CUENTA.ULTIMA_FECHA_SUSPENCION = p_ULTIMA_FECHA_SUSPENCION, CUENTA.FECHA_CIERRE_TERMINO = p_FECHA_CIERRE_TERMINO, CUENTA.CICLO_ASOCIADO_CUENTA = p_CICLO_ASOCIADO_CUENTA, CUENTA.FECHA_EFECTIVA_CIERRE = p_FECHA_EFECTIVA_CIERRE, CUENTA.FECHA_EFECTIVA_INICIO = p_FECHA_EFECTIVA_INICIO, CUENTA.FECHA_ULTIMA_ACTIVIDAD = p_FECHA_ULTIMA_ACTIVIDAD, CUENTA.CATEGORIA_CREDITO = p_CATEGORIA_CREDITO, CUENTA.DIAS_DESPUES_PAGO = p_DIAS_DESPUES_PAGO
where (CUENTA.CODIGO_CUENTA = p_CODIGO_CUENTA and CUENTA.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION and CUENTA.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION);
end UPDATE_CUENTA;
/

create procedure UPDATE_DIRECCION  (p_CODIGO_POSTAL_CLIENTE IN NUMBER,p_CODIGO_PROVINCIA IN VARCHAR2,p_CODIGO_DISTRITO IN VARCHAR2,p_CODIGO_CANTON IN VARCHAR2) as
begin
update DIRECCION
set DIRECCION.CODIGO_PROVINCIA = p_CODIGO_PROVINCIA, DIRECCION.CODIGO_DISTRITO = p_CODIGO_DISTRITO, DIRECCION.CODIGO_CANTON = p_CODIGO_CANTON
where (DIRECCION.CODIGO_POSTAL_CLIENTE = p_CODIGO_POSTAL_CLIENTE);
end UPDATE_DIRECCION;
/

create procedure UPDATE_DISTRITO  (p_CODIGO_DISTRITO IN VARCHAR2,p_NOMBRE_DISTRITO IN VARCHAR2) as
begin
update DISTRITO
set DISTRITO.NOMBRE_DISTRITO = p_NOMBRE_DISTRITO
where (DISTRITO.CODIGO_DISTRITO = p_CODIGO_DISTRITO);
end UPDATE_DISTRITO;
/

create procedure UPDATE_EMPRESA  (p_CEDULA_JURIDICA IN NUMBER,p_CODIGO_POSTAL_CLIENTE IN NUMBER,p_NOMBRE_EMPRESA IN VARCHAR2) as
begin
update EMPRESA
set EMPRESA.CODIGO_POSTAL_CLIENTE = p_CODIGO_POSTAL_CLIENTE, EMPRESA.NOMBRE_EMPRESA = p_NOMBRE_EMPRESA
where (EMPRESA.CEDULA_JURIDICA = p_CEDULA_JURIDICA);
end UPDATE_EMPRESA;
/

create procedure UPDATE_FACTURA  (p_NUMERO_FACTURA IN NUMBER,p_CODIGO_CICLO IN VARCHAR2,p_NUMERO_CONTRATO IN NUMBER,p_MONTO_AMORTIZADO IN NUMBER,p_MONTO_REPORTADO IN NUMBER,p_CICLO_ASOCIADO_BILLING IN VARCHAR2,p_FECHA_FACTURA IN DATE,p_SUB_TOTAL IN NUMBER,p_TOTAL IN NUMBER) as
begin
update FACTURA
set FACTURA.CODIGO_CICLO = p_CODIGO_CICLO, FACTURA.NUMERO_CONTRATO = p_NUMERO_CONTRATO, FACTURA.MONTO_AMORTIZADO = p_MONTO_AMORTIZADO, FACTURA.MONTO_REPORTADO = p_MONTO_REPORTADO, FACTURA.CICLO_ASOCIADO_BILLING = p_CICLO_ASOCIADO_BILLING, FACTURA.FECHA_FACTURA = p_FECHA_FACTURA, FACTURA.SUB_TOTAL = p_SUB_TOTAL, FACTURA.TOTAL = p_TOTAL
where (FACTURA.NUMERO_FACTURA = p_NUMERO_FACTURA);
end UPDATE_FACTURA;
/

create procedure UPDATE_INFORMACION_LABORAL  (p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2,p_CEDULA_JURIDICA IN NUMBER,p_PUESTO IN VARCHAR2,p_PUESTO_ANTERIOR IN VARCHAR2,p_EMPRESA_PROPIA IN VARCHAR2,p_PATRONO_ANTERIOR IN VARCHAR2,p_FECHA_INGRESO IN DATE,p_SALARIO_BRUTO IN NUMBER,p_SALARIO_NETO IN NUMBER,p_OTROS_INGRESOS IN NUMBER) as
begin
update INFORMACION_LABORAL
set INFORMACION_LABORAL.CEDULA_JURIDICA = p_CEDULA_JURIDICA, INFORMACION_LABORAL.PUESTO = p_PUESTO, INFORMACION_LABORAL.PUESTO_ANTERIOR = p_PUESTO_ANTERIOR, INFORMACION_LABORAL.EMPRESA_PROPIA = p_EMPRESA_PROPIA, INFORMACION_LABORAL.PATRONO_ANTERIOR = p_PATRONO_ANTERIOR, INFORMACION_LABORAL.FECHA_INGRESO = p_FECHA_INGRESO, INFORMACION_LABORAL.SALARIO_BRUTO = p_SALARIO_BRUTO, INFORMACION_LABORAL.SALARIO_NETO = p_SALARIO_NETO, INFORMACION_LABORAL.OTROS_INGRESOS = p_OTROS_INGRESOS
where (INFORMACION_LABORAL.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION and INFORMACION_LABORAL.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION);
end UPDATE_INFORMACION_LABORAL;
/

create procedure UPDATE_LINEA_FACTURA  (p_NUMERO_FACTURA IN NUMBER,p_CODIGO_PRODUCTO IN VARCHAR2,p_CODIGO_SERVICIO IN VARCHAR2,p_CANTIDAD IN NUMBER,p_PRECIO_LINEA IN NUMBER) as
begin
update LINEA_FACTURA
set LINEA_FACTURA.CODIGO_PRODUCTO = p_CODIGO_PRODUCTO, LINEA_FACTURA.CODIGO_SERVICIO = p_CODIGO_SERVICIO, LINEA_FACTURA.CANTIDAD = p_CANTIDAD, LINEA_FACTURA.PRECIO_LINEA = p_PRECIO_LINEA
where (LINEA_FACTURA.NUMERO_FACTURA = p_NUMERO_FACTURA);
end UPDATE_LINEA_FACTURA;
/

create procedure UPDATE_PLAN  (p_CODIGO_PLAN IN VARCHAR2,p_CODIGO_PRODUCTO IN VARCHAR2,p_CODIGO_SERVICIO IN VARCHAR2,p_FECHA_EFECTIVA_INICIO_PLAN IN DATE,p_FECHA_EFECTIVA_FIN_PLAN IN DATE,p_TIPO_PLAN IN VARCHAR2,p_NOMBRE_PLAN IN VARCHAR2,p_FREE_TIME IN NUMBER,p_TIEMPO_TOTAL_PERMANENCIA IN NUMBER,p_TIEMPO_NO_PENALIDAD IN NUMBER,p_PROGRAMA_LEALTAD IN SMALLINT) as
begin
update PLAN
set PLAN.CODIGO_PRODUCTO = p_CODIGO_PRODUCTO, PLAN.CODIGO_SERVICIO = p_CODIGO_SERVICIO, PLAN.FECHA_EFECTIVA_INICIO_PLAN = p_FECHA_EFECTIVA_INICIO_PLAN, PLAN.FECHA_EFECTIVA_FIN_PLAN = p_FECHA_EFECTIVA_FIN_PLAN, PLAN.TIPO_PLAN = p_TIPO_PLAN, PLAN.NOMBRE_PLAN = p_NOMBRE_PLAN, PLAN.FREE_TIME = p_FREE_TIME, PLAN.TIEMPO_TOTAL_PERMANENCIA = p_TIEMPO_TOTAL_PERMANENCIA, PLAN.TIEMPO_NO_PENALIDAD = p_TIEMPO_NO_PENALIDAD, PLAN.PROGRAMA_LEALTAD = p_PROGRAMA_LEALTAD
where (PLAN.CODIGO_PLAN = p_CODIGO_PLAN);
end UPDATE_PLAN;
/

create procedure UPDATE_PRODUCTO  (p_CODIGO_PRODUCTO IN VARCHAR2,p_CODIGO_PROMOCION IN VARCHAR2,p_DESCUENTO IN NUMBER,p_TIPO_PRODUCTO IN VARCHAR2,p_DECRIPCION IN VARCHAR2,p_NOMBRE IN VARCHAR2,p_DEPOSITO_INICIAL IN NUMBER,p_PRECIO_TOTAL IN NUMBER,p_MONTO_CASTIGO IN NUMBER,p_CODIGO_STATUS IN VARCHAR2,p_FECHA_EFEC_INI_PROD IN DATE,p_FECHA_EFECTIVA_FIN_PRODUCTO IN DATE) as
begin
update PRODUCTO
set PRODUCTO.CODIGO_PROMOCION = p_CODIGO_PROMOCION, PRODUCTO.DESCUENTO = p_DESCUENTO, PRODUCTO.TIPO_PRODUCTO = p_TIPO_PRODUCTO, PRODUCTO.DECRIPCION = p_DECRIPCION, PRODUCTO.NOMBRE = p_NOMBRE, PRODUCTO.DEPOSITO_INICIAL = p_DEPOSITO_INICIAL, PRODUCTO.PRECIO_TOTAL = p_PRECIO_TOTAL, PRODUCTO.MONTO_CASTIGO = p_MONTO_CASTIGO, PRODUCTO.CODIGO_STATUS = p_CODIGO_STATUS, PRODUCTO.FECHA_EFECTIVA_INICIO_PRODUCTO = p_FECHA_EFEC_INI_PROD, PRODUCTO.FECHA_EFECTIVA_FIN_PRODUCTO = p_FECHA_EFEC_INI_PROD
where (PRODUCTO.CODIGO_PRODUCTO = p_CODIGO_PRODUCTO);
end UPDATE_PRODUCTO;
/

create procedure UPDATE_PROMOCION  (p_CODIGO_PROMOCION IN VARCHAR2,p_CODIGO_CAMPANA IN VARCHAR2,p_TOTAL_COSTO IN NUMBER,p_NUMERO_TOTAL_VENTAS IN NUMBER,p_DESCRIPCION_PROMOCION IN VARCHAR2,p_NOMBRE_PROMOCION IN VARCHAR2,p_EMPLEADO_RESPONSABLE IN VARCHAR2,p_NOMBRE_PARTNER IN VARCHAR2,p_TEMA IN VARCHAR2,p_TIPO_PROMOCION IN VARCHAR2,p_FECHA_INICIO_PROMOCION IN DATE,p_FECHA_FIN_PROMOCION IN DATE,p_FECHA_EFECTIVA_INICIO_PROMO IN DATE,p_FECHA_EFECTIVA_FIN_PROMO IN DATE) as
begin
update PROMOCION
set PROMOCION.CODIGO_CAMPANA = p_CODIGO_CAMPANA, PROMOCION.TOTAL_COSTO = p_TOTAL_COSTO, PROMOCION.NUMERO_TOTAL_VENTAS = p_NUMERO_TOTAL_VENTAS, PROMOCION.DESCRIPCION_PROMOCION = p_DESCRIPCION_PROMOCION, PROMOCION.NOMBRE_PROMOCION = p_NOMBRE_PROMOCION, PROMOCION.EMPLEADO_RESPONSABLE = p_EMPLEADO_RESPONSABLE, PROMOCION.NOMBRE_PARTNER = p_NOMBRE_PARTNER, PROMOCION.TEMA = p_TEMA, PROMOCION.TIPO_PROMOCION = p_TIPO_PROMOCION, PROMOCION.FECHA_INICIO_PROMOCION = p_FECHA_INICIO_PROMOCION, PROMOCION.FECHA_FIN_PROMOCION = p_FECHA_FIN_PROMOCION, PROMOCION.FECHA_EFECTIVA_INICIO_PROMO = p_FECHA_EFECTIVA_INICIO_PROMO, PROMOCION.FECHA_EFECTIVA_FIN_PROMO = p_FECHA_EFECTIVA_FIN_PROMO
where (PROMOCION.CODIGO_PROMOCION = p_CODIGO_PROMOCION);
end UPDATE_PROMOCION;
/

create procedure UPDATE_PROVINCIA  (p_CODIGO_PROVINCIA IN VARCHAR2,p_NOMBRE_PROVINCIA IN VARCHAR2) as
begin
update PROVINCIA
set PROVINCIA.NOMBRE_PROVINCIA = p_NOMBRE_PROVINCIA
where (PROVINCIA.CODIGO_PROVINCIA = p_CODIGO_PROVINCIA);
end UPDATE_PROVINCIA;
/

create procedure UPDATE_SERVICIO  (p_CODIGO_SERVICIO IN VARCHAR2,p_CODIGO_PROMOCION IN VARCHAR2,p_NOMBRE_SERVICIO IN VARCHAR2,p_DESCRIPCION_SERVICIO IN VARCHAR2,p_TIPO_SERVICIO IN VARCHAR2,p_COSTO_SERVICIO IN NUMBER,p_CODIGO_STATUS_SERV IN VARCHAR2,p_MONTO_CASTIGO_SERV IN NUMBER,p_FECHA_EFECTIVA_INICIO_SERV IN DATE,p_FECHA_EFECTIVA_FIN_SERV IN DATE) as
begin
update SERVICIO
set SERVICIO.CODIGO_PROMOCION = p_CODIGO_PROMOCION, SERVICIO.NOMBRE_SERVICIO = p_NOMBRE_SERVICIO, SERVICIO.DESCRIPCION_SERVICIO = p_DESCRIPCION_SERVICIO, SERVICIO.TIPO_SERVICIO = p_TIPO_SERVICIO, SERVICIO.COSTO_SERVICIO = p_COSTO_SERVICIO, SERVICIO.CODIGO_STATUS_SERV = p_CODIGO_STATUS_SERV, SERVICIO.MONTO_CASTIGO_SERV = p_MONTO_CASTIGO_SERV, SERVICIO.FECHA_EFECTIVA_INICIO_SERV = p_FECHA_EFECTIVA_INICIO_SERV, SERVICIO.FECHA_EFECTIVA_FIN_SERV = p_FECHA_EFECTIVA_FIN_SERV
where (SERVICIO.CODIGO_SERVICIO = p_CODIGO_SERVICIO);
end UPDATE_SERVICIO;
/

create procedure UPDATE_TELEFONO_CLIENTE  (p_NUMERO_TELEFONO IN NUMBER,p_NUMERO_IDENTIFICACION IN NUMBER,p_TIPO_IDENTIFICACION IN VARCHAR2,p_TIPO_TELEFONO IN VARCHAR2) as
begin
update TELEFONO_CLIENTE
set TELEFONO_CLIENTE.NUMERO_IDENTIFICACION = p_NUMERO_IDENTIFICACION, TELEFONO_CLIENTE.TIPO_IDENTIFICACION = p_TIPO_IDENTIFICACION, TELEFONO_CLIENTE.TIPO_TELEFONO = p_TIPO_TELEFONO
where (TELEFONO_CLIENTE.NUMERO_TELEFONO = p_NUMERO_TELEFONO);
end UPDATE_TELEFONO_CLIENTE;
/

create procedure UPDATE_TELEFONO_EMPRESA  (p_NUMEROTEL_EMPRESA IN NUMBER,p_CEDULA_JURIDICA IN NUMBER,p_OTROS_NUMERO_TELEFONICO IN NUMBER,p_FAX IN NUMBER) as
begin
update TELEFONO_EMPRESA
set TELEFONO_EMPRESA.CEDULA_JURIDICA = p_CEDULA_JURIDICA, TELEFONO_EMPRESA.OTROS_NUMERO_TELEFONICO = p_OTROS_NUMERO_TELEFONICO, TELEFONO_EMPRESA.FAX = p_FAX
where (TELEFONO_EMPRESA.NUMEROTEL_EMPRESA = p_NUMEROTEL_EMPRESA);
end UPDATE_TELEFONO_EMPRESA;
/

