--------------------------------------------------------
--  DDL for Table DATABASECHANGELOG
--------------------------------------------------------

  CREATE TABLE "DATABASECHANGELOG" 
   (	"ID" VARCHAR2(255 BYTE), 
	"AUTHOR" VARCHAR2(255 BYTE), 
	"FILENAME" VARCHAR2(255 BYTE), 
	"DATEEXECUTED" TIMESTAMP (6), 
	"ORDEREXECUTED" NUMBER(*,0), 
	"EXECTYPE" VARCHAR2(10 BYTE), 
	"MD5SUM" VARCHAR2(35 BYTE), 
	"DESCRIPTION" VARCHAR2(255 BYTE), 
	"COMMENTS" VARCHAR2(255 BYTE), 
	"TAG" VARCHAR2(255 BYTE), 
	"LIQUIBASE" VARCHAR2(20 BYTE), 
	"CONTEXTS" VARCHAR2(255 BYTE), 
	"LABELS" VARCHAR2(255 BYTE), 
	"DEPLOYMENT_ID" VARCHAR2(10 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table DATABASECHANGELOGLOCK
--------------------------------------------------------

  CREATE TABLE "DATABASECHANGELOGLOCK" 
   (	"ID" NUMBER(*,0), 
	"LOCKED" NUMBER(1,0), 
	"LOCKGRANTED" TIMESTAMP (6), 
	"LOCKEDBY" VARCHAR2(255 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table FEEDBACK
--------------------------------------------------------

  CREATE TABLE "FEEDBACK" 
   (	"ID" NUMBER(38,0), 
	"FEEDBACK_1" NUMBER(*,0), 
	"FEEDBACK_2" NUMBER(*,0), 
	"FEEDBACK_3" NUMBER(*,0), 
	"EMPLOYEE" VARCHAR2(100 CHAR), 
	"FEEDBACK_COMMENT_1" VARCHAR2(2000 CHAR), 
	"FEEDBACK_COMMENT_2" VARCHAR2(2000 CHAR), 
	"FEEDBACK_COMMENT_3" VARCHAR2(2000 CHAR), 
	"PRESENTATION_ID" NUMBER(38,0)
   ) ;
--------------------------------------------------------
--  DDL for Table JHI_PERSISTENT_AUDIT_EVENT
--------------------------------------------------------

  CREATE TABLE "JHI_PERSISTENT_AUDIT_EVENT" 
   (	"EVENT_ID" NUMBER(38,0), 
	"PRINCIPAL" VARCHAR2(50 BYTE), 
	"EVENT_DATE" TIMESTAMP (6), 
	"EVENT_TYPE" VARCHAR2(255 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table JHI_PERSISTENT_AUDIT_EVT_DATA
--------------------------------------------------------

  CREATE TABLE "JHI_PERSISTENT_AUDIT_EVT_DATA" 
   (	"EVENT_ID" NUMBER(38,0), 
	"NAME" VARCHAR2(150 BYTE), 
	"VALUE" VARCHAR2(255 BYTE)
   ) ;
--------------------------------------------------------
--  DDL for Table PARTICIPATION
--------------------------------------------------------

  CREATE TABLE "PARTICIPATION" 
   (	"ID" NUMBER(38,0), 
	"EMPLOYEE" VARCHAR2(100 CHAR), 
	"PRESENTATION_ID" NUMBER(38,0)
   ) ;
--------------------------------------------------------
--  DDL for Table PRESENTATION
--------------------------------------------------------

  CREATE TABLE "PRESENTATION" 
   (	"ID" NUMBER(38,0), 
	"NAME" VARCHAR2(500 CHAR), 
	"DESCRIPTION" CLOB, 
	"START_TIME" VARCHAR2(20 CHAR), 
	"END_TIME" VARCHAR2(20 CHAR), 
	"DAY" NUMBER(*,0), 
	"PRESENTER" VARCHAR2(500 CHAR), 
	"STREAM_ID" NUMBER(38,0)
   ) ;
--------------------------------------------------------
--  DDL for Table STREAM
--------------------------------------------------------

  CREATE TABLE "STREAM" 
   (	"ID" NUMBER(38,0), 
	"NAME" VARCHAR2(255 CHAR), 
	"SHORT_NAME" VARCHAR2(255 CHAR), 
	"PARTICIPANT_LIMIT" NUMBER(*,0)
   ) ;
--------------------------------------------------------
--  DDL for Index PK_DATABASECHANGELOGLOCK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_DATABASECHANGELOGLOCK" ON "DATABASECHANGELOGLOCK" ("ID") ;
--------------------------------------------------------
--  DDL for Index PK_FEEDBACK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_FEEDBACK" ON "FEEDBACK" ("ID") ;
--------------------------------------------------------
--  DDL for Index PK_JHI_PERSISTENT_AUDIT_EVENT
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_JHI_PERSISTENT_AUDIT_EVENT" ON "JHI_PERSISTENT_AUDIT_EVENT" ("EVENT_ID") ;
--------------------------------------------------------
--  DDL for Index IDX_PERSISTENT_AUDIT_EVENT
--------------------------------------------------------

  CREATE INDEX "IDX_PERSISTENT_AUDIT_EVENT" ON "JHI_PERSISTENT_AUDIT_EVENT" ("PRINCIPAL", "EVENT_DATE") ;
--------------------------------------------------------
--  DDL for Index SYS_C0017686
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C0017686" ON "JHI_PERSISTENT_AUDIT_EVT_DATA" ("EVENT_ID", "NAME") ;
--------------------------------------------------------
--  DDL for Index IDX_PERSISTENT_AUDIT_EVT_DATA
--------------------------------------------------------

  CREATE INDEX "IDX_PERSISTENT_AUDIT_EVT_DATA" ON "JHI_PERSISTENT_AUDIT_EVT_DATA" ("EVENT_ID");
--------------------------------------------------------
--  DDL for Index PK_PARTICIPATION
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_PARTICIPATION" ON "PARTICIPATION" ("ID") ;
--------------------------------------------------------
--  DDL for Index PK_PRESENTATION
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_PRESENTATION" ON "PRESENTATION" ("ID") ;
--------------------------------------------------------
--  DDL for Index PK_STREAM
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_STREAM" ON "STREAM" ("ID") ;
--------------------------------------------------------
--  Constraints for Table DATABASECHANGELOG
--------------------------------------------------------

  ALTER TABLE "DATABASECHANGELOG" MODIFY ("EXECTYPE" NOT NULL ENABLE);
  ALTER TABLE "DATABASECHANGELOG" MODIFY ("ORDEREXECUTED" NOT NULL ENABLE);
  ALTER TABLE "DATABASECHANGELOG" MODIFY ("DATEEXECUTED" NOT NULL ENABLE);
  ALTER TABLE "DATABASECHANGELOG" MODIFY ("FILENAME" NOT NULL ENABLE);
  ALTER TABLE "DATABASECHANGELOG" MODIFY ("AUTHOR" NOT NULL ENABLE);
  ALTER TABLE "DATABASECHANGELOG" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DATABASECHANGELOGLOCK
--------------------------------------------------------

  ALTER TABLE "DATABASECHANGELOGLOCK" ADD CONSTRAINT "PK_DATABASECHANGELOGLOCK" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "DATABASECHANGELOGLOCK" MODIFY ("LOCKED" NOT NULL ENABLE);
  ALTER TABLE "DATABASECHANGELOGLOCK" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table FEEDBACK
--------------------------------------------------------

  ALTER TABLE "FEEDBACK" ADD CONSTRAINT "PK_FEEDBACK" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "FEEDBACK" MODIFY ("PRESENTATION_ID" NOT NULL ENABLE);
  ALTER TABLE "FEEDBACK" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table JHI_PERSISTENT_AUDIT_EVENT
--------------------------------------------------------

  ALTER TABLE "JHI_PERSISTENT_AUDIT_EVENT" ADD CONSTRAINT "PK_JHI_PERSISTENT_AUDIT_EVENT" PRIMARY KEY ("EVENT_ID") ENABLE;
  ALTER TABLE "JHI_PERSISTENT_AUDIT_EVENT" MODIFY ("PRINCIPAL" NOT NULL ENABLE);
  ALTER TABLE "JHI_PERSISTENT_AUDIT_EVENT" MODIFY ("EVENT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table JHI_PERSISTENT_AUDIT_EVT_DATA
--------------------------------------------------------

  ALTER TABLE "JHI_PERSISTENT_AUDIT_EVT_DATA" ADD PRIMARY KEY ("EVENT_ID", "NAME") ENABLE;
  ALTER TABLE "JHI_PERSISTENT_AUDIT_EVT_DATA" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "JHI_PERSISTENT_AUDIT_EVT_DATA" MODIFY ("EVENT_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PARTICIPATION
--------------------------------------------------------

  ALTER TABLE "PARTICIPATION" ADD CONSTRAINT "PK_PARTICIPATION" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "PARTICIPATION" MODIFY ("PRESENTATION_ID" NOT NULL ENABLE);
  ALTER TABLE "PARTICIPATION" MODIFY ("EMPLOYEE" NOT NULL ENABLE);
  ALTER TABLE "PARTICIPATION" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PRESENTATION
--------------------------------------------------------

  ALTER TABLE "PRESENTATION" ADD CONSTRAINT "PK_PRESENTATION" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "PRESENTATION" MODIFY ("STREAM_ID" NOT NULL ENABLE);
  ALTER TABLE "PRESENTATION" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "PRESENTATION" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table STREAM
--------------------------------------------------------

  ALTER TABLE "STREAM" ADD CONSTRAINT "PK_STREAM" PRIMARY KEY ("ID") ENABLE;
  ALTER TABLE "STREAM" MODIFY ("NAME" NOT NULL ENABLE);
  ALTER TABLE "STREAM" MODIFY ("ID" NOT NULL ENABLE);

  
  --------------------------------------------------------
--  DDL for Sequence FEEDBACK_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "FEEDBACK_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 100 CACHE 20 ORDER  NOCYCLE   ;
--------------------------------------------------------
--  DDL for Sequence HIBERNATE_SEQUENCE
--------------------------------------------------------

   CREATE SEQUENCE  "HIBERNATE_SEQUENCE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 50 START WITH 1000 CACHE 20 NOORDER  NOCYCLE   ;
--------------------------------------------------------
--  DDL for Sequence PARTICIPATION_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "PARTICIPATION_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 100 CACHE 20 ORDER  NOCYCLE   ;
--------------------------------------------------------
--  DDL for Sequence PRESENTATION_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "PRESENTATION_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 100 CACHE 20 ORDER  NOCYCLE   ;
--------------------------------------------------------
--  DDL for Sequence STREAM_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "STREAM_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 5 CACHE 20 ORDER  NOCYCLE   ;

  
REM INSERTING into DATABASECHANGELOG
SET DEFINE OFF;
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('00000000000000','jhipster','config/liquibase/changelog/00000000000000_initial_schema.xml',to_timestamp('11-MAY-18 03.12.20.788778000 PM','DD-MON-RR HH.MI.SSXFF AM'),1,'EXECUTED','7:a6235f40597a13436aa36c6d61db2269','createSequence sequenceName=hibernate_sequence',null,null,'3.5.3',null,null,'6051540592');
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('00000000000001','jhipster','config/liquibase/changelog/00000000000000_initial_schema.xml',to_timestamp('11-MAY-18 03.12.20.892732000 PM','DD-MON-RR HH.MI.SSXFF AM'),2,'EXECUTED','7:6b7ef420f18500c8389a13a1826dea42','createTable tableName=jhi_persistent_audit_event; createTable tableName=jhi_persistent_audit_evt_data; addPrimaryKey tableName=jhi_persistent_audit_evt_data; createIndex indexName=idx_persistent_audit_event, tableName=jhi_persistent_audit_event; c...',null,null,'3.5.3',null,null,'6051540592');
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('20180315101634-1','jhipster','config/liquibase/changelog/20180315101634_added_entity_Feedback.xml',to_timestamp('11-MAY-18 03.12.21.266248000 PM','DD-MON-RR HH.MI.SSXFF AM'),3,'EXECUTED','7:34bda03a71572b85a26c76dd9ef5a262','createTable tableName=feedback; createSequence sequenceName=feedback_seq; loadData tableName=feedback',null,null,'3.5.3',null,null,'6051540592');
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('20180315101635-1','jhipster','config/liquibase/changelog/20180315101635_added_entity_Presentation.xml',to_timestamp('11-MAY-18 03.12.21.396153000 PM','DD-MON-RR HH.MI.SSXFF AM'),4,'EXECUTED','7:bcbdb7e63e72ca6299f62acbacfc0f98','createTable tableName=presentation; createSequence sequenceName=presentation_seq; loadData tableName=presentation',null,null,'3.5.3',null,null,'6051540592');
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('20180315101636-1','jhipster','config/liquibase/changelog/20180315101636_added_entity_Participation.xml',to_timestamp('11-MAY-18 03.12.22.551457000 PM','DD-MON-RR HH.MI.SSXFF AM'),5,'EXECUTED','7:84fcbd10bf1b6eaff325081b15cea9d5','createTable tableName=participation; createSequence sequenceName=participation_seq; loadData tableName=participation',null,null,'3.5.3',null,null,'6051540592');
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('20180418120505-1','jhipster','config/liquibase/changelog/20180418120505_added_entity_Stream.xml',to_timestamp('11-MAY-18 03.12.22.596427000 PM','DD-MON-RR HH.MI.SSXFF AM'),6,'EXECUTED','7:3e024ff5a802ce6db254a380b0649e23','createTable tableName=stream; createSequence sequenceName=stream_seq; loadData tableName=stream',null,null,'3.5.3',null,null,'6051540592');
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('20180315101634-2','jhipster','config/liquibase/changelog/20180315101634_added_entity_constraints_Feedback.xml',to_timestamp('11-MAY-18 03.12.22.617937000 PM','DD-MON-RR HH.MI.SSXFF AM'),7,'EXECUTED','7:4f8060c2c7d3d91983dc15a8ec894cfe','addForeignKeyConstraint baseTableName=feedback, constraintName=fk_feedback_presentation_id, referencedTableName=presentation',null,null,'3.5.3',null,null,'6051540592');
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('20180315101636-2','jhipster','config/liquibase/changelog/20180315101636_added_entity_constraints_Participation.xml',to_timestamp('11-MAY-18 03.12.22.640705000 PM','DD-MON-RR HH.MI.SSXFF AM'),8,'EXECUTED','7:e54ec9be05bb075887dc62af5bed5f39','addForeignKeyConstraint baseTableName=participation, constraintName=participation_presentation_id, referencedTableName=presentation',null,null,'3.5.3',null,null,'6051540592');
Insert into DATABASECHANGELOG (ID,AUTHOR,FILENAME,DATEEXECUTED,ORDEREXECUTED,EXECTYPE,MD5SUM,DESCRIPTION,COMMENTS,TAG,LIQUIBASE,CONTEXTS,LABELS,DEPLOYMENT_ID) values ('20180315101635-2','jhipster','config/liquibase/changelog/20180315101635_added_entity_constraints_Presentation.xml',to_timestamp('11-MAY-18 03.12.22.659396000 PM','DD-MON-RR HH.MI.SSXFF AM'),9,'EXECUTED','7:42c5188da881e4451fc5b163d9c2ddf2','addForeignKeyConstraint baseTableName=presentation, constraintName=fk_presentation_stream_id, referencedTableName=stream',null,null,'3.5.3',null,null,'6051540592');
REM INSERTING into DATABASECHANGELOGLOCK
SET DEFINE OFF;
Insert into DATABASECHANGELOGLOCK (ID,LOCKED,LOCKGRANTED,LOCKEDBY) values (1,0,null,null);
REM INSERTING into JHI_PERSISTENT_AUDIT_EVENT
SET DEFINE OFF;
REM INSERTING into JHI_PERSISTENT_AUDIT_EVT_DATA
SET DEFINE OFF;


commit;
exit;