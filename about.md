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
- Просмотр основной информации об университете:
   - факультеты
   - специальности
   - кафедры
   - преподаватели
- Регистрация
- Вход
  
### Студент
- Возможности [гостя](#гость)
- Просмотр рейтинга
- Просмотр расписания
  
### Преподаватель
- Возможности [гостя](#гость)
- Просмотр, выставление, удаление оценок
  
### Администратор
- Возможности [гостя](#гость)
- CRUD операции со всеми моделями
- назначение ролей пользователям
  
## Инфологическая модель
1. **User** – таблица, описывающая пользователя
   
    1.1. **Поля**:
    - username
    - password
    - email
    - isSuperUser
    - isStaff
      
    1.2. **Связи**:
    - OneToOne с таблицей Student
    - OneToOne с таблицей Professor
     
2. **Professor**:

   2.1 **Поля**:
    - specialization
    - userId (FK)
    - departmentId (FK)
   
   2.2 **Связи**:
   - ManyToMany с таблицей Discipline
   - ManyToMany с таблицей Group
   - ManyToOne с таблицей Department
   - OneToOne С таблицей User

3. **Student**:

   3.1 **Поля**:
   - enrollmentYear
   - graduationYear
   - userId (FK)
   - specialityId (FK)
   - groupId (FK)

   3.2 **Связи**:
   - ManyToOne с таблицей Group
   - ManyToOne с таблицей Speciality
   - OneToMany с таблицей Grade
   - OneToOne с таблицей User
  
4. **Faculty**:
   
   4.1 **Поля**:
   - name

   4.2 **Связи**:
   - OneToMany с таблицей Speciality
   
5. **Speciality**:
   
   5.1 **Поля**:
   - name
   - facultyId (FK)

   5.2 **Связи**:
   - ManyToOne с таблицей Faculty
   - OneToMany с таблицей Student
     
6. **Department**  – таблица, описывающая кафедру

   6.1 **Поля**:
   - name

   6.2 **Связи**:
   - OneToMany с таблицей Professor
   
7. **Discipline**:

   7.1 **Поля**:
   - name

   7.2 **Связи**:
   - ManyToOne с таблицей Group
   - ManyToOne с таблицей Speciality
   - OneToMany с таблицей Grade
   - OneToOne с таблицей User
   
8. **Group**:

   8.1 **Поля**:
   - number

   8.2 **Связи**:
   - OneToMany с таблицей Timetable
   - OneToMany с таблицей Student
   - ManyToMany с таблицей Professor

9. **Grade**:

   9.1 **Поля**:
   - disciplineId (FK)
   - studentId (FK)
   - grade

   9.2 **Связи**:
   - ManyToOne с таблицей Discipline
   - ManyToOne с таблицей Student

10. **Timetable**:

   10.1 **Поля**:
   - dayOfWeekId (FK)
   - classTypeId (FK)
   - disciplineId (FK)
   - groupId (FK)
   - classroomId (FK)
   - classId (FK)

   10.2 **Связи**:
   - ManyToOne с таблицей DayOfWeek
   - ManyToOne с таблицей ClassType
   - ManyToOne с таблицей Discipline
   - ManyToOne с таблицей Group
   - ManyToOne с таблицей Classroom
   - ManyToOne с таблицей Class

11. **Class**  – таблица, описывающая номер пары, ее время начала и конца

   11.1 **Поля**:
   - classNumber
   - startTime
   - endTime

   11.2 **Связи**:
   - OneToMany с таблицей Timetable
     
12. **Classroom**:

   12.1 **Поля**:
   - number
   - building

   12.2 **Связи**:
   - OneToMany с таблицей Timetable

13. **ClassType**  – таблица, описывающая тип пары(ЛК, ЛР, ПЗ)

   13.1 **Поля**:
   - type

   13.2 **Связи**:
   - OneToMany с таблицей Timetable
     
14. **DaysOfWeek**:

   14.1 **Поля**:
   - name

   14.2 **Связи**:
   - OneToMany с таблицей Timetable
     
## Даталогическая модель
![db_diagram](db_university.svg)

