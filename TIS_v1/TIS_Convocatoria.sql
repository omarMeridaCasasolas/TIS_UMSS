/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     23/03/2020 07:47:39 p.m.                     */
/*==============================================================*/


drop index RELATIONSHIP_2_FK;

drop index ADMINISTRATIVO_PK;

drop table ADMINISTRATIVO;

drop index RELATIONSHIP_3_FK;

drop index ARCHIVO_PK;

drop table ARCHIVO;

drop index CONVOCATORIA_PK;

drop table CONVOCATORIA;

drop index POSTULANTE_PK;

drop table POSTULANTE;

drop index RELATIONSHIP_4_FK;

drop index PROTOTIPOS_PK;

drop table PROTOTIPOS;

drop index RELATIONSHIP_1_FK;

drop index RELATIONSHIP_5_FK;

drop index RELATIONSHIP_1_PK;

drop table RELATIONSHIP_1;

/*==============================================================*/
/* Table: ADMINISTRATIVO                                        */
/*==============================================================*/
create table ADMINISTRATIVO (
   CI_ADMINISTRATIVO    VARCHAR(20)          not null,
   ID_CONVOCATORIA      VARCHAR(25)          null,
   NOMBRE_ADMINISTRATIVO VARCHAR(50)          not null,
   CORREO_ADMINISTRATIVO VARCHAR(60)          not null,
   PASSWORD_ADMINISTRATIVO VARCHAR(25)          not null,
   CARGO_ADMINISTRATIVO VARCHAR(20)          not null,
   constraint PK_ADMINISTRATIVO primary key (CI_ADMINISTRATIVO)
);

/*==============================================================*/
/* Index: ADMINISTRATIVO_PK                                     */
/*==============================================================*/
create unique index ADMINISTRATIVO_PK on ADMINISTRATIVO (
CI_ADMINISTRATIVO
);

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_2_FK on ADMINISTRATIVO (
ID_CONVOCATORIA
);

/*==============================================================*/
/* Table: ARCHIVO                                               */
/*==============================================================*/
create table ARCHIVO (
   NOMBRE_ARCHIVO       VARCHAR(30)          not null,
   CARNET_DE_IDENTIDAD  VARCHAR(10)          null,
   DIRECTORIO_ARCHIVO   VARCHAR(50)          not null,
   FORMATO_ARCHIVO      VARCHAR(10)          not null,
   SIZE_ARCHIVO         FLOAT8               not null,
   FECHA_ARCHIVO        DATE                 not null,
   constraint PK_ARCHIVO primary key (NOMBRE_ARCHIVO)
);

/*==============================================================*/
/* Index: ARCHIVO_PK                                            */
/*==============================================================*/
create unique index ARCHIVO_PK on ARCHIVO (
NOMBRE_ARCHIVO
);

/*==============================================================*/
/* Index: RELATIONSHIP_3_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_3_FK on ARCHIVO (
CARNET_DE_IDENTIDAD
);

/*==============================================================*/
/* Table: CONVOCATORIA                                          */
/*==============================================================*/
create table CONVOCATORIA (
   ID_CONVOCATORIA      VARCHAR(25)          not null,
   DEPARTAMENTO         VARCHAR(30)          not null,
   GESTION              VARCHAR(10)          not null,
   TIPO_CONVOCATORIA    VARCHAR(50)          not null,
   DESCRIPCION_CONVOCATORIA TEXT                 null,
   constraint PK_CONVOCATORIA primary key (ID_CONVOCATORIA)
);

/*==============================================================*/
/* Index: CONVOCATORIA_PK                                       */
/*==============================================================*/
create unique index CONVOCATORIA_PK on CONVOCATORIA (
ID_CONVOCATORIA
);

/*==============================================================*/
/* Table: POSTULANTE                                            */
/*==============================================================*/
create table POSTULANTE (
   CARNET_DE_IDENTIDAD  VARCHAR(10)          not null,
   NOMBRE_POSTULANTE    VARCHAR(30)          not null,
   EDAD_DE_NACIMIENTO_POSTULANTE DATE                 not null,
   CORREO_ELECTRONICO_POSTULANTE VARCHAR(20)          not null,
   PASSWORD_POSTULANTE  VARCHAR(25)          not null,
   constraint PK_POSTULANTE primary key (CARNET_DE_IDENTIDAD)
);

/*==============================================================*/
/* Index: POSTULANTE_PK                                         */
/*==============================================================*/
create unique index POSTULANTE_PK on POSTULANTE (
CARNET_DE_IDENTIDAD
);

/*==============================================================*/
/* Table: PROTOTIPOS                                            */
/*==============================================================*/
create table PROTOTIPOS (
   CODIGO_PROTOTIPO     VARCHAR(30)          not null,
   ID_CONVOCATORIA      VARCHAR(25)          not null,
   DIRECCION            VARCHAR(100)         not null,
   TIPO                 VARCHAR(30)          not null,
   constraint PK_PROTOTIPOS primary key (CODIGO_PROTOTIPO)
);

/*==============================================================*/
/* Index: PROTOTIPOS_PK                                         */
/*==============================================================*/
create unique index PROTOTIPOS_PK on PROTOTIPOS (
CODIGO_PROTOTIPO
);

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_4_FK on PROTOTIPOS (
ID_CONVOCATORIA
);

/*==============================================================*/
/* Table: RELATIONSHIP_1                                        */
/*==============================================================*/
create table RELATIONSHIP_1 (
   ID_CONVOCATORIA      VARCHAR(25)          not null,
   CARNET_DE_IDENTIDAD  VARCHAR(10)          not null,
   constraint PK_RELATIONSHIP_1 primary key (ID_CONVOCATORIA, CARNET_DE_IDENTIDAD)
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_PK                                     */
/*==============================================================*/
create unique index RELATIONSHIP_1_PK on RELATIONSHIP_1 (
ID_CONVOCATORIA,
CARNET_DE_IDENTIDAD
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_5_FK on RELATIONSHIP_1 (
CARNET_DE_IDENTIDAD
);

/*==============================================================*/
/* Index: RELATIONSHIP_1_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_1_FK on RELATIONSHIP_1 (
ID_CONVOCATORIA
);

alter table ADMINISTRATIVO
   add constraint FK_ADMINIST_RELATIONS_CONVOCAT foreign key (ID_CONVOCATORIA)
      references CONVOCATORIA (ID_CONVOCATORIA)
      on delete restrict on update restrict;

alter table ARCHIVO
   add constraint FK_ARCHIVO_RELATIONS_POSTULAN foreign key (CARNET_DE_IDENTIDAD)
      references POSTULANTE (CARNET_DE_IDENTIDAD)
      on delete restrict on update restrict;

alter table PROTOTIPOS
   add constraint FK_PROTOTIP_RELATIONS_CONVOCAT foreign key (ID_CONVOCATORIA)
      references CONVOCATORIA (ID_CONVOCATORIA)
      on delete restrict on update restrict;

alter table RELATIONSHIP_1
   add constraint FK_RELATION_RELATIONS_CONVOCAT foreign key (ID_CONVOCATORIA)
      references CONVOCATORIA (ID_CONVOCATORIA)
      on delete restrict on update restrict;

alter table RELATIONSHIP_1
   add constraint FK_RELATION_RELATIONS_POSTULAN foreign key (CARNET_DE_IDENTIDAD)
      references POSTULANTE (CARNET_DE_IDENTIDAD)
      on delete restrict on update restrict;

