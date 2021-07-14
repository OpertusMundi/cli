DROP TABLE IF EXISTS admin.spring_session_attributes;
DROP TABLE IF EXISTS admin.spring_session;

CREATE TABLE admin.spring_session (
	PRIMARY_ID CHAR(36) NOT NULL,
	SESSION_ID CHAR(36) NOT NULL,
	CREATION_TIME BIGINT NOT NULL,
	LAST_ACCESS_TIME BIGINT NOT NULL,
	MAX_INACTIVE_INTERVAL INT NOT NULL,
	EXPIRY_TIME BIGINT NOT NULL,
	PRINCIPAL_NAME VARCHAR(100),
	CONSTRAINT admin_spring_session_pk PRIMARY KEY (PRIMARY_ID)
);

CREATE UNIQUE INDEX admin_spring_session_ix1 ON admin.spring_session (SESSION_ID);
CREATE INDEX        admin_spring_session_ix2 ON admin.spring_session (EXPIRY_TIME);
CREATE INDEX        admin_spring_session_ix3 ON admin.spring_session (PRINCIPAL_NAME);

CREATE TABLE admin.spring_session_attributes (
	SESSION_PRIMARY_ID CHAR(36) NOT NULL,
	ATTRIBUTE_NAME VARCHAR(200) NOT NULL,
	ATTRIBUTE_BYTES BYTEA NOT NULL,
	CONSTRAINT admin_spring_session_attributes_pk PRIMARY KEY (SESSION_PRIMARY_ID, ATTRIBUTE_NAME),
	CONSTRAINT admin_spring_session_attributes_fl FOREIGN KEY (SESSION_PRIMARY_ID) REFERENCES admin.spring_session(PRIMARY_ID) ON DELETE CASCADE
);
