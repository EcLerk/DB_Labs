import psycopg2

try:
    connection = psycopg2.connect(
        dbname='university_db',
        user='postgres',
        password='Vtufgjkbc123',
        host='localhost'
    )
except:
    print('Can`t establish connection to database')

def register_user():
    print("Registration:")
    name, surname = input("Enter your name and surname: ").split()
    email = input("Enter your email:")
    password = input("Enter your password: ")

    try:
        with connection.cursor() as cursor:
            cursor.execute('INSERT INTO "user" (name, surname, password, email, isstaff, issuperuser)'
                           'VALUES (%s, %s, %s, %s, %s, %s) RETURNING id',
                           (name, surname, password, email, False, False))
            user_id = cursor.fetchone()[0]
            connection.commit()
            print(f"Registration successful! Your user ID is {user_id}.")
            return user_id, email
    except Exception as e:
        print(f"Error: Unable to register user\n{e}")
        return None

def check_role(user_id):
    try:
        with connection.cursor() as cursor:
            cursor.execute('SELECT isstaff, issuperuser FROM "user" WHERE id = %s',
                           (user_id,))
            result = cursor.fetchone()

            #admin
            if result and result[1]:
                return 1
            #professor
            elif result and result[0]:
                return 2
            #student
            elif result and not result[0] and not result[1]:
                return 3
    except Exception as e:
        print(f"Error checking user role: {e}")
        return None

def login_user():
    email = input("Enter your email: ")
    password = input("Enter your password: ")

    try:
        with connection.cursor() as cursor:
            cursor.execute('SELECT id, isstaff, issuperuser FROM "user" WHERE email = %s AND password = %s',
                           (email, password))
            user = cursor.fetchone()

            if user:
                if user[2]:
                    print(f"Login successful! Your role is admin.")
                    return user[0], email
                elif user[1]:
                    print(f"Login successful! Your role is professor.")
                    return user[0], email
                else:
                    print(f"Login successful! Your role is student.")
                    return user[0], email
            else:
                print("Login failed. Invalid username or password.")
                return None

    except Exception as e:
        print(f"Error: Unable to log in\n{e}")

    return None

def delete_user_by_id(admin_id):

    try:
        user_id_to_delete = int(input("Enter the user ID to delete: "))

        if user_id_to_delete == 1:
            raise ValueError("Cannot delete the user with ID 1.")

        with connection.cursor() as cursor:
            cursor.execute('SELECT isstaff, issuperuser FROM "user" WHERE id = %s',
                           (user_id_to_delete,))

            user = cursor.fetchone()
            print("hello")
            if user[0]:
                cursor.execute('DELETE FROM professor WHERE userid = %s', (user_id_to_delete,))
                connection.commit()
            elif not user[0] and not user[1]:
                cursor.execute('DELETE FROM student WHERE userid = %s', (user_id_to_delete,))
                connection.commit()

            cursor.execute('DELETE FROM "user" WHERE id = %s', (user_id_to_delete,))
            connection.commit()

            print("user was successfully deleted")
    except ValueError as ve:
        print(f"Error: {ve}")
    except Exception as e:
        print(f"Error deleting user: {e}")


def view_profile(user_id):
    try:
        with connection.cursor() as cursor:
            cursor.execute('SELECT * FROM "user" WHERE id = %s', (user_id,))
            profile = cursor.fetchone()

            if profile:
                print("User:")
                print(f"Name: {profile[1]}")
                print(f"Surname: {profile[2]}")
                print(f"Email: {profile[4]}")
            else:
                print("Profile not found.")

        connection.commit()
    except Exception as e:
        print(f"Error: Unable to view profile\n{e}")

    connection.commit()


def edit_profile(user_id):
    while True:
        print("Edit Profile:")
        print("1. Change name")
        print("2. Change surname")
        print("3. Change email")
        print("0. Back")

        choice = input("Enter your choice: ")

        try:
            with connection.cursor() as cursor:
                if choice == '1':
                    new_name = input("Enter your new name: ")
                    cursor.execute('UPDATE "user" SET name = %s WHERE id = %s', (new_name, user_id))
                    connection.commit()
                    print("Name updated successfully.")
                elif choice == '2':
                    new_last_name = input("Enter your new last name: ")
                    cursor.execute('UPDATE "user" SET surname = %s WHERE id = %s', (new_last_name, user_id))
                    connection.commit()
                    print("Last name updated successfully.")
                elif choice == '3':
                    new_email = input("Enter your new email: ")
                    cursor.execute('UPDATE "user" SET email = %s WHERE id = %s', (new_email, user_id))
                    connection.commit()
                    print("Email updated successfully.")
                elif choice == '0':
                    print("Returning to the main menu.")
                    return
                else:
                    print("Invalid choice. Please try again.")
        except Exception as e:
            print(f"Error: Unable to edit profile\n{e}")


def change_user_role(admin_id):
    try:
        user_id_to_change = int(input("Enter the user ID to change the role: "))
        new_role = input('Enter the new role ("student", "professor", "admin"): ')

        with connection.cursor() as cursor:
            if user_id_to_change == admin_id:
                raise ValueError("Cannot change the role for the admin.")

            isstaff = False
            issuperuser = False
            update_query = 'UPDATE "user" SET isstaff = %s, issuperuser = %s WHERE id = %s'
            if new_role == "student":
                cursor.execute(update_query, (isstaff,issuperuser, user_id_to_change))
            elif new_role == "professor":
                isstaff = True
                issuperuser = False
                cursor.execute(update_query, (isstaff,issuperuser, user_id_to_change))
            elif new_role == "admin":
                isstaff = False
                issuperuser = True
                cursor.execute(update_query, (isstaff,issuperuser, user_id_to_change))
            else:
                print("Invalid data!")
            print(f"User role updated successfully for user ID {user_id_to_change}.")
    except ValueError as ve:
        print(f"Error: {ve}")
    except Exception as e:
        print(f"Error changing user role: {e}")
    connection.commit()

def add_grade(user_id):
    try:
        student_id = int(input("Enter the student ID to add a grade: "))
        discipline_name = input("Enter discipline name:")
        grade = int(input("Enter the grade: "))

        with connection.cursor() as cursor:

            cursor.execute('SELECT id FROM discipline WHERE name = %s', (discipline_name,))
            discipline = cursor.fetchone()[0]

            cursor.execute('INSERT INTO grade (grade, studentid, disciplineid) VALUES (%s, %s, %s)',
                               (grade, student_id, discipline))
            print(f"The grade successfully added to student {student_id}")
    except ValueError as ve:
        print(f"Error: {ve}")
    except Exception as e:
        print(f"Error adding grade: {e}")
    connection.commit()

def view_timetable(user_id):
    try:
        with connection.cursor() as cursor:
            cursor.execute("""SELECT id AS student_id
                                FROM student
                                WHERE userId = %s;
                                """, (user_id, ))
            student_id = cursor.fetchone()[0]

        with connection.cursor() as cursor:
            cursor.execute("""SELECT
                                    c.classnumber,
                                    c.starttime,
                                    c.endtime,
                                    dOW.name AS day_of_week,
                                    d.name AS discipline
                                FROM
                                    timetable t
                                JOIN
                                    class c ON t.classid = c.id
                                JOIN
                                    dayOfWeek dOW ON t.dayofweekid = dOW.id
                                JOIN
                                    discipline d ON t.disciplineid = d.id
                                JOIN
                                    student s ON t.groupid = s.groupid
                                WHERE
                                    s.id = %s;
        """, (student_id,))

            timetables = cursor.fetchall()
            if timetables:
                print("Timetable:")
                print("class number | start time | end time | day of week | discipline name")
                print("--------------------------------------------------------------------")
                for timetable in timetables:
                    print(f"{timetable[0]}      {timetable[1]}      "
                          f"{timetable[2]}      {timetable[3]}      {timetable[4]}")

    except Exception as e:
        print(f"Error: Unable to view timetable\n{e}")

def view_grades(user_id):
    try:
        with connection.cursor() as cursor:
            cursor.execute("""SELECT id AS student_id
                                FROM student
                                WHERE userId = %s;
                                """, (user_id, ))
            student_id = cursor.fetchone()[0]

        with connection.cursor() as cursor:
            cursor.execute("""SELECT g.grade, d.name AS discipline_name
                                    FROM grade g
                                    JOIN student s ON g.studentId = s.id
                                    JOIN "user" u ON s.userId = u.id
                                    JOIN discipline d ON g.disciplineId = d.id
                                    WHERE g.studentId = %s;
        """, (student_id,))

            grades = cursor.fetchall()
            if grades:
                print("Grades:")
                print("grade | discipline")
                print("------------------")
                for grade in grades:
                    print(f"{grade[0]}      {grade[1]}")

            cursor.execute("SELECT AVG(grade) FROM grade WHERE studentid = %s", (student_id,))
            avg = float(cursor.fetchone()[0])

            print(f"Average: {avg}")
    except Exception as e:
        print(f"Error: Unable to view grades\n{e}")

def view_professors():
    try:
        with connection.cursor() as cursor:
            cursor.execute("""SELECT u.name, u.surname,p.yearsofexperience, d.name AS department_name
                                FROM professor p
                                JOIN department d ON p.departmentId = d.id
                                JOIN "user" u ON p.userid = u.id"""
                                    , )
            professors = cursor.fetchall()

            if professors:
                print("Professors:")
                print("{:<20} {:<20} {:<20}".format("Professor", "years of experience", "department"))
                print("----------------------------------------------------------")

                for professor in professors:
                    professor_name = professor[0] + ' ' + professor[1]
                    print("{:<35} {:<5} {:<20}".format(professor_name, professor[2], professor[3]))

    except Exception as e:
        print(f"Error: Unable to view professors\n{e}")

def view_faculties():
    try:
        with connection.cursor() as cursor:
            cursor.execute("""SELECT * FROM faculty"""
                                    , )
            faculties = cursor.fetchall()

            if faculties:
                print("Faculties:")
                for faculty in faculties:
                    print(f"{faculty[1]}")

    except Exception as e:
        print(f"Error: Unable to view professors\n{e}")

def view_specialities():
    try:
        with connection.cursor() as cursor:
            cursor.execute("""SELECT * FROM speciality"""
                                    , )
            specialities = cursor.fetchall()

            if specialities:
                print("Specialities:")
                for speciality in specialities:
                    print(f"{speciality[1]}")

    except Exception as e:
        print(f"Error: Unable to view specialities\n{e}")


def delete_grade(user_id):
    try:
        student_id = int(input("Enter the student id to delete a grade: "))

        with connection.cursor() as cursor:
            cursor.execute('SELECT * FROM grade WHERE studentid = %s', (student_id,))
            grades = cursor.fetchall()

            print(f"Grades of student {student_id}")
            for grade in grades:
                print(f"{grade[0]} {grade[1]}")

            grade_id = int(input("Enter id of grade to be deleted:"))
            cursor.execute('DELETE FROM grade WHERE id = %s', (grade_id, ))
            print("Grade was successfully deleted")
    except ValueError as ve:
        print(f"Error: {ve}")
    except Exception as e:
        print(f"Error deleting grade: {e}")
    connection.commit()

def edit_grade(user_id):
    try:
        student_id = int(input("Enter the student id to edit a grade: "))

        with connection.cursor() as cursor:
            cursor.execute('SELECT * FROM grade WHERE studentid = %s', (student_id,))
            grades = cursor.fetchall()

            print(f"Grades of student {student_id}")
            for grade in grades:
                print(f"{grade[0]} {grade[1]}")

            grade_id = int(input("Enter id of grade to be updated:"))
            new_grade = int(input("Enter a new grade:"))
            cursor.execute('UPDATE grade SET grade = %s WHERE id = %s', (new_grade, grade_id))
            print("Grade was successfully updated")
    except ValueError as ve:
        print(f"Error: {ve}")
    except Exception as e:
        print(f"Error editing grade: {e}")
    connection.commit()

def view_action_table(user_id):
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT a.id, a.action_time, a.user_id, a_t.name "
                           "FROM action a JOIN action_type a_t ON a.action_type_id = a_t.id")
            actions = cursor.fetchall()

            if not actions:
                print("No actions found.")
            else:
                print("\nList of actions:")
                print("{:<5} {:<30} {:<10} {:<20}".format("ID", "Action Time", "User ID", "Action Type"))
                for action in actions:
                    print("{:<5} {:<30} {:<10} {:<20}".format(action[0], str(action[1]), str(action[2]), action[3]))

    except Exception as e:
        print(f"Error viewing action table: {e}")

def main():
    user_info = None
    user_role = None

    while True:
        print("\nMenu:")

        if user_info:
            print("3. View profile")
            print("4. Edit profile")
            if user_role in [1, 2]:
                print("8. Add grade")
                print("9. Delete grade")#
                print("10. Edit grade")#
                if user_role == 1:
                    print("11. Delete user")
                    print("12. Change user role")#
                    print("13. Users history")#
            if user_role == 3:
                print("14. View timetable")
                print("15. View grades")
            print("0. Logout")
        else:
            print("1. Register")
            print("2. Login")
            print("5. View professors")  #
            print("6. View faculties")  #
            print("7. View specialities")  #
            print("0. Exit")

        choice = input("Enter your choice: ")

        if choice == '1' and not user_info:
            user_info = register_user()
        elif choice == '2' and not user_info:
            user_info = login_user()
            if user_info:
                user_role = check_role(user_info[0])
        elif choice in ['5', '6', '7'] and not user_info:
            menu_options_user = {
                '5': view_professors,
                '6': view_faculties,
                '7': view_specialities
            }
            menu_options_user[choice]()

        elif user_info and choice in ['3', '4']:
            menu_options_common = {
                '3': view_profile,
                '4': edit_profile
            }
            menu_options_common[choice](user_info[0])

        elif user_info and choice in ['8', '9', '10', '11', '12', '13', '14', '15']:
            if user_role in [1, 2]:
                menu_options_professor = {
                    '8': add_grade,
                    '9': delete_grade,
                    '10': edit_grade
                }
                if choice in menu_options_professor:
                    menu_options_professor[choice](user_info[0])

                if user_role == 1:
                    menu_options_admin = {
                        '11': delete_user_by_id,
                        '12': change_user_role,
                        '13': view_action_table
                    }
                    if choice in menu_options_admin:
                        menu_options_admin[choice](user_info[0])
            elif user_role == 3:
                menu_options_student = {
                    '14': view_timetable,
                    '15': view_grades
                }
                if choice in menu_options_student:
                    menu_options_student[choice](user_info[0])
            else:
                print("Invalid choice. Please try again.")

        elif user_info and choice == '0':
            print("Logging out.")
            user_info = None
            user_role = None
        elif not user_info and choice == '0':
            print("Exiting the program.")
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == '__main__':
    main()