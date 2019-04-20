/*
DROP TABLE IF EXISTS USR CASCADE;
DROP TABLE IF EXISTS ROLE_R CASCADE;
DROP TABLE IF EXISTS ASSIGNED_ROLE;
DROP TABLE IF EXISTS PROBLEM CASCADE;
DROP TABLE IF EXISTS PROBLEM_STATUS;
DROP TABLE IF EXISTS PROBLEM_MESSAGE;
DROP TABLE IF EXISTS SUITABILITY;
DROP TABLE IF EXISTS DESIRABLE_SCHEDULE CASCADE;
DROP TABLE IF EXISTS LEVEL;
DROP TABLE IF EXISTS COURSE_STATUS;
DROP TABLE IF EXISTS COURSE CASCADE;
DROP TABLE IF EXISTS USR_GROUP CASCADE;
DROP TABLE IF EXISTS GRUP CASCADE;
DROP TABLE IF EXISTS ATTACHMENT;
DROP TABLE IF EXISTS LESSON_ATTACHMENT CASCADE;
DROP TABLE IF EXISTS LESSON CASCADE;
DROP TABLE IF EXISTS NOTIFICATION CASCADE;
DROP TABLE IF EXISTS EVENT;
DROP TABLE IF EXISTS FEEDBACK CASCADE;
DROP TABLE IF EXISTS CHAT CASCADE;
DROP TABLE IF EXISTS CHAT_USER CASCADE;
*/
CREATE TABLE USR
(
    USER_ID            SERIAL PRIMARY KEY,
    EMAIL              VARCHAR(50) NOT NULL UNIQUE,
    PASSWORD           VARCHAR(50) NOT NULL,
    FIRST_NAME         VARCHAR(50) NOT NULL,
    LAST_NAME          VARCHAR(50),
    TOKEN              VARCHAR(256),
    CREATED            TIMESTAMP with time zone,
    MANAGER_ID         INTEGER REFERENCES USR (USER_ID),
    USER_IMAGE_URL     VARCHAR(256),
    IS_ACTIVE          BOOLEAN,
    IS_ON_LANDING_PAGE BOOLEAN,
    DESCRIPTION        TEXT
);

CREATE TABLE ROLE_R
(
    ROLE_ID   SERIAL PRIMARY KEY,
    ROLE_NAME VARCHAR(15) NOT NULL
);

CREATE TABLE ASSIGNED_ROLE
(
    USER_ID INTEGER REFERENCES USR (USER_ID),
    ROLE_ID INTEGER REFERENCES ROLE_R (ROLE_ID)
);

CREATE TABLE PROBLEM_STATUS
(
    PROBLEM_STATUS_ID SERIAL PRIMARY KEY,
    TITLE             VARCHAR(50) NOT NULL,
    DESCRIPTION       TEXT
);

CREATE TABLE PROBLEM
(
    PROBLEM_ID        SERIAL PRIMARY KEY,
    PROBLEM_SENDER_ID INTEGER REFERENCES USR (USER_ID),
    TITLE             VARCHAR(50) NOT NULL,
    PROBLEM_STATUS_ID INTEGER REFERENCES PROBLEM_STATUS (PROBLEM_STATUS_ID),
    DESCRIPTION       TEXT
);

CREATE TABLE PROBLEM_MESSAGE
(
    PROBLEM_MASSAGE_ID SERIAL PRIMARY KEY,
    PROBLEM_ID         INTEGER REFERENCES PROBLEM (PROBLEM_ID),
    PROBLEM_SENDER_ID  INTEGER REFERENCES USR (USER_ID),
    MESSAGE            TEXT NOT NULL,
    DATE_TIME          TIMESTAMP with time zone
);

CREATE TABLE COURSE
(
    COURSE_ID              SERIAL PRIMARY KEY,
    COURSE_NAME            VARCHAR(150) NOT NULL,
    COURSE_LEVEL           INTEGER REFERENCES LEVEL (LEVEL_ID),
    COURSE_STATUS_ID       INTEGER REFERENCES COURSE_STATUS (COURSE_STATUS_ID),
    TRAINER_ID             INTEGER REFERENCES USR (USER_ID),
    COURSE_IMAGE_URL       VARCHAR(256),
    COURSE_START_DATE      DATE,
    COURSE_END_DATE        DATE,
    COURSE_ON_LANDING_PAGE BOOLEAN,
    COURSE_DESCRIPTION     TEXT
);

CREATE TABLE COURSE_STATUS
(
    COURSE_STATUS_ID          SERIAL PRIMARY KEY,
    COURSE_STATUS_NAME        VARCHAR(50) NOT NULL,
    COURSE_STATUS_DESCRIPTION TEXT
);

CREATE TABLE LEVEL
(
    LEVEL_ID   SERIAL PRIMARY KEY,
    LEVEL_NAME VARCHAR(50) NOT NULL
);


CREATE TABLE SUITABILITY
(
    SUITABILITY_ID SERIAL PRIMARY KEY,
    TITLE          VARCHAR(150) NOT NULL,
    PRIORITY       INTEGER
);


CREATE TABLE DESIRABLE_SCHEDULE
(
    SCHEDULE_ID           SERIAL PRIMARY KEY,
    DESIRED_USER_ID       INTEGER REFERENCES USR (USER_ID),
    DESIRED_FOR_COURSE_ID INTEGER REFERENCES COURSE (COURSE_ID),
    CRON_INTERVAL         VARCHAR(50),
    SUITABILITY           INTEGER REFERENCES SUITABILITY (SUITABILITY_ID)
);

CREATE TABLE GRUP
(
    GROUP_ID        SERIAL PRIMARY KEY,
    GROUP_COURSE_ID INTEGER REFERENCES COURSE (COURSE_ID),
    GROUP_TITLE     VARCHAR(150) NOT NULL
);

CREATE TABLE USR_GROUP
(
    USER_GROUP_ID SERIAL PRIMARY KEY,
    STUDENT_ID    INTEGER REFERENCES USR (USER_ID),
    GROUP_ID      INTEGER REFERENCES GRUP (GROUP_ID),
    IS_ATTENDING  BOOLEAN
);

CREATE TABLE ATTACHMENT
(
    ATTACHMENT_ID          SERIAL PRIMARY KEY,
    ATTACHMENT_URL         TEXT,
    ATTACHMENT_DESCRIPTION TEXT
);
CREATE TABLE LESSON
(
    LESSON_ID        SERIAL PRIMARY KEY,
    GROUP_ID         INTEGER REFERENCES GRUP (GROUP_ID),
    LESSON_TOPIC     VARCHAR(150) NOT NULL,
    TRAINER_ID       INTEGER REFERENCES USR (USER_ID),
    LESSON_TIME_DATE TIMESTAMP WITH TIME ZONE
);

CREATE TABLE LESSON_ATTACHMENT
(
    LESSON_ID     INTEGER REFERENCES LESSON (LESSON_ID),
    ATTACHMENT_ID INTEGER REFERENCES ATTACHMENT (ATTACHMENT_ID)
);

CREATE TABLE EVENT
(
    EVENT_ID              SERIAL PRIMARY KEY,
    EVENT_TITLE           VARCHAR(150) NOT NULL,
    NOTIFICATION_TEMPLATE VARCHAR(100) NOT NULL
);

CREATE TABLE NOTIFICATION
(
    NOTIFICATION_ID        SERIAL PRIMARY KEY,
    EVENT_ID               INTEGER REFERENCES EVENT (EVENT_ID),
    NOTIFIED_USER          INTEGER REFERENCES USR (USER_ID),
    NOTIFICATION_DATE_TIME TIMESTAMP WITH TIME ZONE NOT NULL,
    IS_READ                BOOLEAN,
    NOTIFICATION_TEXT      VARCHAR(150)
);

CREATE TABLE FEEDBACK
(
    FEEDBACK_ID         SERIAL PRIMARY KEY,
    FEEDBACK_USER_ID    INTEGER REFERENCES USR (USER_ID),
    FEEDBACK_TRAINER_ID INTEGER REFERENCES USR (USER_ID),
    FEEDBACK_COURSE_ID  INTEGER REFERENCES COURSE (COURSE_ID),
    FEEDBACK_TEXT       TEXT,
    FEEDBACK_DATE_TIME  TIMESTAMP WITH TIME ZONE
);


CREATE TABLE CHAT_MESSAGE
(
    CHAT_MESSAGE_ID        SERIAL PRIMARY KEY,
    CHAT_ID                INTEGER REFERENCES CHAT (CHAT_ID),
    SENDER_ID              INTEGER REFERENCES USR (USER_ID),
    CHAT_MESSAGE_TIME_DATE TIMESTAMP WITH TIME ZONE,
    CHAT_MESSAGE_TEXT      TEXT
);

CREATE TABLE CHAT
(
    CHAT_ID        SERIAL PRIMARY KEY,
    CHAT_NAME      VARCHAR(50) NOT NULL,
    CHAT_TIME_DATE TIMESTAMP WITH TIME ZONE,
    GROUP_ID       INTEGER REFERENCES GRUP (GROUP_ID)
);

CREATE TABLE CHAT_USER
(
    CHAT_ID INTEGER REFERENCES CHAT (CHAT_ID),
    USER_ID INTEGER REFERENCES USR (USER_ID)
);