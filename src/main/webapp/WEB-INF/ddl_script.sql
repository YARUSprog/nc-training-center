DROP TABLE IF EXISTS USR CASCADE;
DROP TABLE IF EXISTS ROLE_R CASCADE;
DROP TABLE IF EXISTS ASSIGNED_ROLE CASCADE;
DROP TABLE IF EXISTS PROBLEM CASCADE;
DROP TABLE IF EXISTS PROBLEM_STATUS CASCADE;
DROP TABLE IF EXISTS PROBLEM_MESSAGE CASCADE;
DROP TABLE IF EXISTS SUITABILITY CASCADE;
DROP TABLE IF EXISTS DESIRABLE_SCHEDULE CASCADE;
DROP TABLE IF EXISTS LEVEL CASCADE;
DROP TABLE IF EXISTS COURSE_STATUS CASCADE;
DROP TABLE IF EXISTS COURSE CASCADE;
DROP TABLE IF EXISTS USR_GROUP CASCADE;
DROP TABLE IF EXISTS GRUP CASCADE;
DROP TABLE IF EXISTS ATTACHMENT CASCADE;
DROP TABLE IF EXISTS LESSON_ATTACHMENT CASCADE;
DROP TABLE IF EXISTS LESSON CASCADE;
DROP TABLE IF EXISTS ABSENCE_REASON CASCADE;
DROP TABLE IF EXISTS ATTENDANCE_STATUS CASCADE;
DROP TABLE IF EXISTS ATTENDANCE CASCADE;
DROP TABLE IF EXISTS NOTIFICATION CASCADE;
DROP TABLE IF EXISTS EVENT CASCADE;
DROP TABLE IF EXISTS FEEDBACK CASCADE;
DROP TABLE IF EXISTS CHAT CASCADE;
DROP TABLE IF EXISTS CHAT_USER CASCADE;
DROP TABLE IF EXISTS CHAT_MESSAGE CASCADE;


CREATE SEQUENCE usr_seq;
CREATE TABLE USR
(
    ID                 INTEGER DEFAULT NEXTVAL('usr_seq') PRIMARY KEY,
    EMAIL              VARCHAR(50) NOT NULL UNIQUE,
    PASSWORD           VARCHAR(50) NOT NULL,
    FIRST_NAME         VARCHAR(50) NOT NULL,
    LAST_NAME          VARCHAR(50),
    TOKEN              VARCHAR(256),
    CREATED            TIMESTAMP with time zone,
    MANAGER_ID         INTEGER REFERENCES USR (ID),
    IMAGE_URL          VARCHAR(256),
    IS_ACTIVE          BOOLEAN,
    IS_ON_LANDING_PAGE BOOLEAN,
    DESCRIPTION        TEXT
);

CREATE SEQUENCE role_seq;
CREATE TABLE ROLE_R
(
    ID   INTEGER DEFAULT NEXTVAL('role_seq') PRIMARY KEY,
    NAME VARCHAR(15) NOT NULL
);

CREATE TABLE ASSIGNED_ROLE
(
    USER_ID INTEGER REFERENCES USR (ID),
    ROLE_ID INTEGER REFERENCES ROLE_R (ID)
);

CREATE SEQUENCE problem_status_seq;
CREATE TABLE PROBLEM_STATUS
(
    ID          INTEGER DEFAULT NEXTVAL('problem_status_seq') PRIMARY KEY,
    TITLE       VARCHAR(50) NOT NULL,
    DESCRIPTION TEXT
);

CREATE SEQUENCE problem_seq;
CREATE TABLE PROBLEM
(
    ID                INTEGER DEFAULT NEXTVAL('problem_seq') PRIMARY KEY,
    USER_ID           INTEGER REFERENCES USR (ID),
    TITLE             VARCHAR(50) NOT NULL,
    PROBLEM_STATUS_ID INTEGER REFERENCES PROBLEM_STATUS (ID),
    DESCRIPTION       TEXT
);

CREATE SEQUENCE problem_message_seq;
CREATE TABLE PROBLEM_MESSAGE
(
    ID         INTEGER DEFAULT NEXTVAL('problem_message_seq') PRIMARY KEY,
    PROBLEM_ID INTEGER REFERENCES PROBLEM (ID),
    USER_ID    INTEGER REFERENCES USR (ID),
    MESSAGE    TEXT NOT NULL,
    DATE_TIME  TIMESTAMP with time zone
);

CREATE SEQUENCE course_status_seq;
CREATE TABLE COURSE_STATUS
(
    ID          INTEGER DEFAULT NEXTVAL('course_status_seq') PRIMARY KEY,
    NAME        VARCHAR(50) NOT NULL,
    DESCRIPTION TEXT
);

CREATE TABLE LEVEL
(
    ID    INTEGER DEFAULT NEXTVAL('level_seq') PRIMARY KEY,
    TITLE VARCHAR(50)
);

CREATE SEQUENCE course_seq;
CREATE TABLE COURSE
(
    ID                 INTEGER DEFAULT NEXTVAL('course_seq') PRIMARY KEY,
    NAME               VARCHAR(150) NOT NULL,
    LEVEL              INTEGER REFERENCES LEVEL (ID),
    COURSE_STATUS_ID   INTEGER REFERENCES COURSE_STATUS (ID),
    USER_ID            INTEGER REFERENCES USR (ID),
    IMAGE_URL          VARCHAR(256),
    START_DATE         DATE,
    END_DATE           DATE,
    IS_ON_LANDING_PAGE BOOLEAN,
    DESCRIPTION        TEXT
);

CREATE SEQUENCE suitability_seq;
CREATE TABLE SUITABILITY
(
    ID       INTEGER DEFAULT NEXTVAL('suitability_seq') PRIMARY KEY,
    TITLE    VARCHAR(150) NOT NULL,
    PRIORITY INTEGER,
    COLOR    VARCHAR(20)
);

CREATE SEQUENCE desirable_schedule_seq;
CREATE TABLE DESIRABLE_SCHEDULE
(
    ID            INTEGER DEFAULT NEXTVAL('desirable_schedule_seq') PRIMARY KEY,
    USER_ID       INTEGER REFERENCES USR (ID),
    COURSE_ID     INTEGER REFERENCES COURSE (ID),
    CRON_INTERVAL VARCHAR(50),
    SUITABILITY   INTEGER REFERENCES SUITABILITY (ID)
);

CREATE SEQUENCE grup_seq;
CREATE TABLE GRUP
(
    ID        INTEGER DEFAULT NEXTVAL('grup_seq') PRIMARY KEY,
    COURSE_ID INTEGER REFERENCES COURSE (ID),
    TITLE     VARCHAR(150) NOT NULL
);

CREATE SEQUENCE usr_group_seq;
CREATE TABLE USR_GROUP
(
    ID           INTEGER DEFAULT NEXTVAL('usr_group_seq') PRIMARY KEY,
    USER_ID      INTEGER REFERENCES USR (ID),
    GROUP_ID     INTEGER REFERENCES GRUP (ID),
    IS_ATTENDING BOOLEAN
);

CREATE SEQUENCE attachment_seq;
CREATE TABLE ATTACHMENT
(
    ID          INTEGER DEFAULT NEXTVAL('attachment_seq') PRIMARY KEY,
    URL         TEXT,
    DESCRIPTION TEXT
);

CREATE SEQUENCE lesson_seq;
CREATE TABLE LESSON
(
    ID        INTEGER DEFAULT NEXTVAL('lesson_seq') PRIMARY KEY,
    GROUP_ID  INTEGER REFERENCES GRUP (ID),
    TOPIC     VARCHAR(150) NOT NULL,
    USER_ID   INTEGER REFERENCES USR (ID),
    TIME_DATE TIMESTAMP WITH TIME ZONE
);

CREATE TABLE LESSON_ATTACHMENT
(
    LESSON_ID     INTEGER REFERENCES LESSON (ID),
    ATTACHMENT_ID INTEGER REFERENCES ATTACHMENT (ID)
);

CREATE SEQUENCE absence_reason_seq;
CREATE TABLE ABSENCE_REASON
(
    ID    INTEGER DEFAULT NEXTVAL('abscence_reason_seq') PRIMARY KEY,
    TITLE VARCHAR(50)
);

CREATE SEQUENCE attendance_status_seq;
CREATE TABLE ATTENDANCE_STATUS
(
    ID    INTEGER DEFAULT NEXTVAL('attendance_status_seq') PRIMARY KEY,
    TITLE VARCHAR(50)
);

CREATE SEQUENCE attendance_seq;
CREATE TABLE ATTENDANCE
(
    ID        INTEGER DEFAULT NEXTVAL('attendance_seq') PRIMARY KEY,
    LESSON_ID INTEGER REFERENCES LESSON (ID),
    USER_ID   INTEGER REFERENCES USR (ID),
    REASON_ID INTEGER REFERENCES ABSENCE_REASON (ID),
    STATUS_ID INTEGER REFERENCES ATTENDANCE_STATUS (ID)
);

CREATE SEQUENCE event_seq;
CREATE TABLE EVENT
(
    ID                    INTEGER DEFAULT NEXTVAL('event_seq') PRIMARY KEY,
    TITLE                 VARCHAR(150) NOT NULL,
    NOTIFICATION_TEMPLATE VARCHAR(100) NOT NULL
);

CREATE SEQUENCE notification_seq;
CREATE TABLE NOTIFICATION
(
    ID        INTEGER DEFAULT NEXTVAL('notification_seq') PRIMARY KEY,
    EVENT_ID  INTEGER REFERENCES EVENT (ID),
    USER_ID   INTEGER REFERENCES USR (ID),
    DATE_TIME TIMESTAMP WITH TIME ZONE NOT NULL,
    IS_READ   BOOLEAN,
    TEXT      VARCHAR(150)
);

CREATE SEQUENCE feedback_seq;
CREATE TABLE FEEDBACK
(
    ID         INTEGER DEFAULT NEXTVAL('feedback_seq') PRIMARY KEY,
    USER_ID    INTEGER REFERENCES USR (ID),
    TRAINER_ID INTEGER REFERENCES USR (ID),
    COURSE_ID  INTEGER REFERENCES COURSE (ID),
    TEXT       TEXT,
    DATE_TIME  TIMESTAMP WITH TIME ZONE
);

CREATE SEQUENCE chat_seq;
CREATE TABLE CHAT
(
    ID        INTEGER DEFAULT NEXTVAL('chat_seq') PRIMARY KEY,
    NAME      VARCHAR(50) NOT NULL,
    TIME_DATE TIMESTAMP WITH TIME ZONE,
    GROUP_ID  INTEGER REFERENCES GRUP (ID)
);

CREATE SEQUENCE chat_message_seq;
CREATE TABLE CHAT_MESSAGE
(
    ID        INTEGER DEFAULT NEXTVAL('chat_message_seq') PRIMARY KEY,
    CHAT_ID   INTEGER REFERENCES CHAT (ID),
    USER_ID   INTEGER REFERENCES USR (ID),
    TIME_DATE TIMESTAMP WITH TIME ZONE,
    TEXT      TEXT
);


CREATE TABLE CHAT_USER
(
    CHAT_ID INTEGER REFERENCES CHAT (ID),
    USER_ID INTEGER REFERENCES USR (ID)
);


alter table lesson
  add column is_canceled boolean;

alter table lesson
  add column is_archived boolean;


COMMIT;
