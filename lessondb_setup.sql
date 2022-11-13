create database if not exists LessonDB;
use LessonDB;

drop table if exists Students_Subjects_schedules_rel;
drop table if exists subjects_schedules_rel;
drop table if exists Students;
drop table if exists Faculties;
drop table if exists Subjects;
drop table if exists Teachers;
drop table if exists Managers;
drop table if exists Schedules;
drop table if exists Courses;


# დამხმარე მენეჯერების ცხრილი
CREATE TABLE Managers
(
    ID                bigint auto_increment,
    FirstName         varchar(255) not null,
    LastName          varchar(255) not null,
    PersonID          varchar(11)  not null unique,
    Email             varchar(255) not null unique,
    Address           varchar(255) not null,
    DateOfBirth       DATE         not null,
    Sex               varchar(255) not null,
    Address2          varchar(255),
    FlatNumber        int,
    BankAccountNumber varchar(255) not null unique,
    PRIMARY KEY (ID)

);

# ფაკულტეტების ცხრილი
CREATE TABLE Faculties
(
    ID         bigint auto_increment,
    Name       varchar(255) not null,
    Manager_id bigint       not null,
    PRIMARY KEY (ID),
    CONSTRAINT `faculties_managers_fk`
        FOREIGN KEY (Manager_id) REFERENCES Managers (Id)
            ON DELETE CASCADE ON UPDATE CASCADE
);

#კურსების ცხრილი
CREATE TABLE Courses
(
    ID   bigint auto_increment,
    Name varchar(255) not null,
    PRIMARY KEY (ID)

);
#ლექტორების ცხრილი
CREATE TABLE Teachers
(
    ID                bigint auto_increment,
    FirstName         varchar(255) not null,
    LastName          varchar(255) not null,
    PersonID          varchar(11)  not null unique,
    Email             varchar(255) not null unique,
    Address           varchar(255) not null,
    DateOfBirth       DATE         not null,
    Sex               varchar(255) not null,
    Address2          varchar(255),
    FlatNumber        int,
    BankAccountNumber varchar(255) not null unique,
    Rankk             varchar(255) not null,
    PRIMARY KEY (ID)

);

#საგნების ცხრილი
CREATE TABLE Subjects
(
    ID          bigint auto_increment,
    Name        varchar(255) not null,
    Course_id   bigint       not null,
    Teachers_id bigint       not null,
    PRIMARY KEY (ID),
    CONSTRAINT `subjects_courses_fk`
        FOREIGN KEY (Course_id) REFERENCES Courses (Id)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `subjects_teachers_fk`
        FOREIGN KEY (Teachers_id) REFERENCES Teachers (Id)
            ON DELETE CASCADE ON UPDATE CASCADE
);


# სტუდენტების ცხრილი
CREATE TABLE Students
(
    ID          bigint auto_increment,
    FirstName   varchar(255) not null,
    LastName    varchar(255) not null,
    PersonID    varchar(11)  not null unique,
    Email       varchar(255) not null unique,
    Address     varchar(255) not null,
    DateOfBirth DATE         not null,
    Sex         varchar(255) not null,
    Address2    varchar(255),
    FlatNumber  int,
    Faculty_id  bigint       not null,
    Course_id   bigint       not null,
    PRIMARY KEY (ID),
    CONSTRAINT `students_faculties_fk`
        FOREIGN KEY (Faculty_id) REFERENCES Faculties (Id)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `students_course_fk`
        FOREIGN KEY (Course_id) REFERENCES Courses (Id)
            ON DELETE CASCADE ON UPDATE CASCADE
);


# განრიგის ცხრილი
CREATE TABLE Schedules
(
    ID      bigint auto_increment,
    Weekday VARCHAR(20) not null,
    Time    TIME        not null,
    PRIMARY KEY (ID)
);


# საგნებისა და განრიგის რელაცია
create table subjects_schedules_rel
(
    ID           bigint auto_increment,
    Subject_id   bigint not null,
    Schedules_id bigint not null,
    primary key (ID),
    CONSTRAINT `subject_id_schedules_rel_fk`
        FOREIGN KEY (Subject_id) REFERENCES Subjects (ID)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `schedules_id_subject_rel_fk`
        FOREIGN KEY (Schedules_id) REFERENCES Schedules (ID)
            ON DELETE CASCADE ON UPDATE CASCADE
);


# სტუდენტებისა და ლექციების რელაცია
create table Students_Subjects_schedules_rel
(
    ID                  bigint AUTO_INCREMENT not null,
    Student_id          bigint                not null,
    Subject_Schedule_id bigint                not null,
    primary key (ID),
    CONSTRAINT `students_id_subject_id_schedules_rel_fk`
        FOREIGN KEY (Student_id) REFERENCES Students (ID)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `students_schedules_id_subject_rel_fk`
        FOREIGN KEY (Subject_Schedule_id) REFERENCES Subjects_schedules_rel (ID)
            ON DELETE CASCADE ON UPDATE CASCADE
);
