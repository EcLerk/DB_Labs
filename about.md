# Университет  
- [Функциональные требования](#функциональные-требования)
- [Инфологическая модель](#инфологическая-модель)
- [Даталогическая модель](#даталогическая-модель)

## Функциональные требования
### Система ролей представлена следующими типами пользователей:
- [Гость](#гость)
- [Студент](#студент)
- [Преподаватель](#преподаватель)
- [Администратор](#администратор)

### Гость
- Просмотр основной информации (...)
- Регистрация
- Авторизация  
### Студент
- Просмотр рейтинга
### Преподаватель
- Выставление оценок
### Администратор

## Инфологическая модель
1. **User** – таблица, описывающая пользователя
   
    1.1. **Поля**:
    - username
    - password
    - email
      
    1.2. **Связи**:
    - OneToOne с таблицей Student
    - OneToOne с таблицей Professor
    - OneToOne с таблицей Admin
  
2. **Admin**

   2.1 **Поля**:

   2.2 **Связи**:
   - OneToOne с таблицей User
     
3. **Professor**:

   3.1 **Поля**:
    - specialization
    - departmentId (FK)
   
   3.2 **Связи**:
   - ManyToMany с таблицей Discipline
   - ManyToMany с таблицей Group
   - ManyToOne с таблицей Department
   - OneToOne С таблицей User

4. **Student**:

   4.1 **Поля**:
   - enrollmentYear
   - graduationYear
   - specialityId (FK)
   - groupId (FK)

   4.2 **Связи**:
   - ManyToOne с таблицей Group
   - ManyToOne с таблицей Speciality
   - OneToMany с таблицей Grade
   - OneToOne с таблицей User
  
5. **Faculty**:
   
   5.1 **Поля**:
   - name

   5.2 **Связи**:
   - OneToMany с таблицей Speciality
   
6. **Speciality**:
   
   6.1 **Поля**:
   - name
   - facultyId (FK)

   6.2 **Связи**:
   - ManyToOne с таблицей Faculty
   - OneToMany с таблицей Student
     
7. **Department**  – таблица, описывающая кафедру

   7.1 **Поля**:
   - name

   7.2 **Связи**:
   - OneToMany с таблицей Professor
   
8. **Discipline**:

   8.1 **Поля**:
   - name

   8.2 **Связи**:
   - ManyToOne с таблицей Group
   - ManyToOne с таблицей Speciality
   - OneToMany с таблицей Grade
   - OneToOne с таблицей User
   
10. **Group**:

   10.1 **Поля**:
   - number

   10.2 **Связи**:
   - OneToMany с таблицей Timetable
   - OneToMany с таблицей Student
   - ManyToMany с таблицей Professor

11. **Grade**:

   13.1 **Поля**:
   - disciplineId (FK)
   - studentId (FK)
   - grade

   13.2 **Связи**:
   - ManyToOne с таблицей Discipline
   - ManyToOne с таблицей Student
     
12. **Timetable**:

   12.1 **Поля**:
   - dayOfWeekId (FK)
   - classTypeId (FK)
   - disciplineId (FK)
   - groupId (FK)
   - classroomId (FK)
   - classId (FK)

   12.2 **Связи**:
   - ManyToOne с таблицей DayOfWeek
   - ManyToOne с таблицей ClassType
   - ManyToOne с таблицей Discipline
   - ManyToOne с таблицей Group
   - ManyToOne с таблицей Classroom
   - ManyToOne с таблицей Class

13. **Class**  – таблица, описывающая номер пары, ее время начала и конца

   13.1 **Поля**:
   - classNumber
   - startTime
   - endTime

   13.2 **Связи**:
   - OneToMany с таблицей Timetable
     
14. **Classroom**:

   14.1 **Поля**:
   - number
   - building

   14.2 **Связи**:
   - OneToMany с таблицей Timetable
     
15. **ClassType**  – таблица, описывающая тип пары(ЛК, ЛР, ПЗ)

   15.1 **Поля**:
   - type

   15.2 **Связи**:
   - OneToMany с таблицей Timetable
     
16. **DaysOfWeek**:

   16.1 **Поля**:
   - name

   16.2 **Связи**:
   - OneToMany с таблицей Timetable
     
## Даталогическая модель
![db_diagram](db_university.svg)

