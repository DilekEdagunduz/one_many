
--Öğrenci => Ad, Soyad, No, EMail, Telefon, DogumTarih
create table students (
studentID int PRIMARY KEY IDENTITY(1,1),
studentFirstName NvarChar(MAX),
studentLastName NvarChar(MAX), 
studentEmail NvarChar(MAX), 
studentPhone NvarChar(MAX), 
studentBirthDate Date,
studentsectionID int  not null
)
insert into Students
    (studentFirstName,studentLastName,studentsectionID)
values('Eda', 'Gündüz',1)
select * from students

--Eğitmen => Ad, Soyad
Create Table Teachers (
TeacherID int PRIMARY KEY IDENTITY(1,1),
TeacherName NvarChar(MAX),
TeacherLastname NvarChar(MAX),
TeachersectionID int  not null
)
insert into Teachers
    (TeacherName,TeacherLastname,TeachersectionID)
values('Meltem', 'Gündüz',1)
select * from Teachers

--Bölüm => Ad, Kurulus Tarih
Create Table Sections(
SectionID int PRIMARY KEY IDENTITY(1,1),
SectionName NvarChar(MAX),
SectionDate Date,
SectionFacultyID int not null
)
insert into Sections
    (SectionName,SectionFacultyID)
values('Fizik',1)
select * from Sections

-- Fakulte => Ad
Create Table Faculties (
FacultyID int PRIMARY KEY IDENTITY(1,1),
FakultyName NvarChar (MAX)
)
insert into Faculties
    (FakultyName)
values('Fen')
select * from Faculties

create Table TeacherSections(
ID int PRIMARY KEY IDENTITY(1,1),
TchrID int,
SctID int
)

-- Öğrenci Ad, Soyad, Bölüm Ad, Fakülte Ad
select s.studentFirstName,s.studentLastName,stns.SectionName,f.FakultyName from students s 
inner join Sections stns on s.studentsectionID=stns.SectionID
inner join Faculties f on f.FacultyID=stns.SectionID

-- Eğitmen Ad, Bölüm Ad (inner join)
select * from Teachers t
inner join Sections s on t.TeacherID=s.SectionID

-- Fen Fakültesindeki EĞİTMENLERİ LİSTELE (YAPAMADIM)
select f.FakultyName,t.TeacherID,TeacherName,t.TeacherLastname from TeacherSections ts
inner join Teachers t on t.TeacherID=ts.TchrID
inner join Sections s on s.SectionID=ts.SctID
inner join Faculties f on f.FacultyID=s.SectionFacultyID where  f.FakultyName like '%Fizik%'

-- Fakülte ekleyen bir store procedure yaz
create proc sp_facultyAdd(@name nvarchar (MAX))
as 
begin 
insert into Faculties (FakultyName) values (@name)
end

sp_facultyAdd 'Yazılım mühendisi'
create proc sp_AddFaculty(@Name nvarchar(30))
as
begin 
insert into Faculties (FakultyName) values (@Name)
end

sp_AddFaculty 'İktisadi ve İdari Bilimler Fakültesi'

-- Herhangi bir fakülte eklendiğinde ekrana 'Yeni bir fakülte eklendi!' yazsın (TRIGGER) (Normalde çalışıyor fakat bu dosyada çalışmıyor, araştır....)

create Trigger trg_Add_Fakulties
on Faculties
After insert
as 
begin 
print('Yeni bir fakülte eklendi!')
end

insert into Faculties(FakultyName)
values ('mat3')

-- Bölüm ID, Ad, Fakülte Ad isimli 3 kolonu olan bir VIEW yaz

create view vw_SF
as
select s.SectionID,s.SectionName,f.FakultyName from  Sections s inner join Faculties f 
on f.FacultyID=s.SectionFacultyID

select *from vw_SF