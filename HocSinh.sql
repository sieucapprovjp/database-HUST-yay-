DROP TABLE IF EXISTS student CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS enrollment CASCADE;
DROP TABLE IF EXISTS instructor CASCADE;

CREATE TABLE student(
    sid INT primary key,
    name varchar(100) not null,
    major varchar(50),
    year INT check(year >=1 AND year <= 5)
);

Create table course(
    cid int PRIMARY KEY,
    title varchar(100) not null,
    credits int check(credits > 0)
);

CREATE TABLE enrollment(
    sid int,
    cid int,
    midterm DECIMAL(4,2) check (midterm between 0 and 10),
    final DECIMAL(4,2) check(final between 0 and 10),
    primary key(sid,cid),
    CONSTRAINT FK_sid FOREIGN KEY (sid) REFERENCES student(sid)
                       ON UPDATE CASCADE
                       ON DELETE CASCADE,
    CONSTRAINT FK_cid FOREIGN KEY (cid) REFERENCES course(cid)
                       ON UPDATE CASCADE
                       ON DELETE CASCADE
);

CREATE TABLE instructor(
    iid int primary key,
    name varchar(100) not null,
    department varchar(50)
);
