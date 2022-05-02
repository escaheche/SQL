/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     06-04-2022 12:07:59                          */
/*==============================================================*/


drop index DIRECCION_PK;

alter table DIRECCION
   drop constraint PK_DIRECCION;

drop table DIRECCION;

drop index ATENDIDO_FK;

drop index EMPLEADO_PK;

alter table EMPLEADO
   drop constraint PK_EMPLEADO;

drop table EMPLEADO;

drop index LLAMADO_PK;

alter table LLAMADO
   drop constraint PK_LLAMADO;

drop table LLAMADO;

drop index RELATIONSHIP_8_FK;

drop index RELATIONSHIP_7_FK;

drop index REALIZA_PK;

alter table REALIZA
   drop constraint PK_REALIZA;

drop table REALIZA;

drop index CREA_FK;

drop index REPORTE_PK;

alter table REPORTE
   drop constraint PK_REPORTE;

drop table REPORTE;

drop index RELATIONSHIP_6_FK;

drop index RELATIONSHIP_5_FK;

drop index TIENE_PK;

alter table TIENE
   drop constraint PK_TIENE;

drop table TIENE;

drop index USUARIO_PK;

alter table USUARIO
   drop constraint PK_USUARIO;

drop table USUARIO;

/*==============================================================*/
/* Table: DIRECCION                                             */
/*==============================================================*/
create table DIRECCION (
   ID_DIRECCION         INT4                 not null,
   CALLE                CHAR(256)            null,
   NUMERO               NUMERIC              null,
   COMUNA               CHAR(256)            null,
   REGION_              CHAR(50)             null,
   PAIS                 CHAR(50)             null
);

alter table DIRECCION
   add constraint PK_DIRECCION primary key (ID_DIRECCION);

/*==============================================================*/
/* Index: DIRECCION_PK                                          */
/*==============================================================*/
create unique index DIRECCION_PK on DIRECCION (
ID_DIRECCION
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   ID_EMPLEADO          INT4                 not null,
   ID_LLAMADO           NUMERIC              null
);

alter table EMPLEADO
   add constraint PK_EMPLEADO primary key (ID_EMPLEADO);

/*==============================================================*/
/* Index: EMPLEADO_PK                                           */
/*==============================================================*/
create unique index EMPLEADO_PK on EMPLEADO (
ID_EMPLEADO
);

/*==============================================================*/
/* Index: ATENDIDO_FK                                           */
/*==============================================================*/
create  index ATENDIDO_FK on EMPLEADO (
ID_LLAMADO
);

/*==============================================================*/
/* Table: LLAMADO                                               */
/*==============================================================*/
create table LLAMADO (
   ID_LLAMADO           NUMERIC              not null
);

alter table LLAMADO
   add constraint PK_LLAMADO primary key (ID_LLAMADO);

/*==============================================================*/
/* Index: LLAMADO_PK                                            */
/*==============================================================*/
create unique index LLAMADO_PK on LLAMADO (
ID_LLAMADO
);

/*==============================================================*/
/* Table: REALIZA                                               */
/*==============================================================*/
create table REALIZA (
   ID_LLAMADO           NUMERIC              not null,
   ID_CLIENTE           INT4                 not null,
   ID_REALIZA           INT4                 not null
);

alter table REALIZA
   add constraint PK_REALIZA primary key (ID_LLAMADO, ID_CLIENTE, ID_REALIZA);

/*==============================================================*/
/* Index: REALIZA_PK                                            */
/*==============================================================*/
create unique index REALIZA_PK on REALIZA (
ID_LLAMADO,
ID_CLIENTE,
ID_REALIZA
);

/*==============================================================*/
/* Index: RELATIONSHIP_7_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_7_FK on REALIZA (
ID_CLIENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_8_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_8_FK on REALIZA (
ID_LLAMADO
);

/*==============================================================*/
/* Table: REPORTE                                               */
/*==============================================================*/
create table REPORTE (
   ID_REPORTE           INT4                 not null,
   ID_EMPLEADO          INT4                 null,
   HORA                 TIME                 null,
   DIA                  TIME                 null,
   REGISTRO             INT4                 null
);

alter table REPORTE
   add constraint PK_REPORTE primary key (ID_REPORTE);

/*==============================================================*/
/* Index: REPORTE_PK                                            */
/*==============================================================*/
create unique index REPORTE_PK on REPORTE (
ID_REPORTE
);

/*==============================================================*/
/* Index: CREA_FK                                               */
/*==============================================================*/
create  index CREA_FK on REPORTE (
ID_EMPLEADO
);

/*==============================================================*/
/* Table: TIENE                                                 */
/*==============================================================*/
create table TIENE (
   ID_DIRECCION         INT4                 not null,
   ID_CLIENTE           INT4                 not null,
   ID_TIENE             INT4                 null
);

alter table TIENE
   add constraint PK_TIENE primary key (ID_DIRECCION, ID_CLIENTE);

/*==============================================================*/
/* Index: TIENE_PK                                              */
/*==============================================================*/
create unique index TIENE_PK on TIENE (
ID_DIRECCION,
ID_CLIENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_5_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_5_FK on TIENE (
ID_CLIENTE
);

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create  index RELATIONSHIP_6_FK on TIENE (
ID_DIRECCION
);

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   TELEFONO             INT4                 null,
   EMAIL                CHAR(50)             null,
   NOMBRE               CHAR(50)             null,
   ID_CLIENTE           INT4                 not null
);

alter table USUARIO
   add constraint PK_USUARIO primary key (ID_CLIENTE);

/*==============================================================*/
/* Index: USUARIO_PK                                            */
/*==============================================================*/
create unique index USUARIO_PK on USUARIO (
ID_CLIENTE
);

alter table EMPLEADO
   add constraint FK_EMPLEADO_ATENDIDO_LLAMADO foreign key (ID_LLAMADO)
      references LLAMADO (ID_LLAMADO)
      on delete restrict on update restrict;

alter table REALIZA
   add constraint FK_REALIZA_RELATIONS_USUARIO foreign key (ID_CLIENTE)
      references USUARIO (ID_CLIENTE)
      on delete restrict on update restrict;

alter table REALIZA
   add constraint FK_REALIZA_RELATIONS_LLAMADO foreign key (ID_LLAMADO)
      references LLAMADO (ID_LLAMADO)
      on delete restrict on update restrict;

alter table REPORTE
   add constraint FK_REPORTE_CREA_EMPLEADO foreign key (ID_EMPLEADO)
      references EMPLEADO (ID_EMPLEADO)
      on delete restrict on update restrict;

alter table TIENE
   add constraint FK_TIENE_RELATIONS_USUARIO foreign key (ID_CLIENTE)
      references USUARIO (ID_CLIENTE)
      on delete restrict on update restrict;

alter table TIENE
   add constraint FK_TIENE_RELATIONS_DIRECCIO foreign key (ID_DIRECCION)
      references DIRECCION (ID_DIRECCION)
      on delete restrict on update restrict;

