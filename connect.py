from sqlalchemy import create_engine
from sqlalchemy.sql import text


def get_engine(user, passwd, host, port, db ):
    url = f"postgresql://{user}:{passwd}@{host}: {port}/{db}"
    engine = create_engine(url)
    return engine


engine = get_engine('postgres',
                    'damir3221',
                    'localhost', 
                    '5432', 
                    'Diseases')
conn = engine.connect()
res_select = text("SELECT * FROM diseasetype")

print("Query 1\nDiseases that are caused by bacteria and were discovered before 1990")
q1 = text("SELECT D.disease_code, D.description FROM Discover V, Disease D WHERE V.disease_code = D.disease_code AND V.first_enc_date < '1990-01-01' AND D.pathogen = 'bacteria' ")
for q in conn.execute(q1):
    print(q)

print("\nQuery 2\nInfo about the doctors who aren't specialized in infectious diseases")
q2 = text("SELECT DISTINCT U.name, U.surname, Doc.degree FROM Doctor Doc, DiseaseType T, Specialize S, Users U WHERE U.email = Doc.email AND Doc.email = S.email AND T.id != 2 AND S.id = T.id ")
for q in conn.execute(q2):
    print(q)

print("\nQuery 3\nInfo about the doctors who specialize in more than 2 dis_types")
q3 = text("SELECT U.name, U.surname, Doc.degree FROM Doctor Doc, Users U, Specialize S, DiseaseType T  WHERE U.email = Doc.email AND Doc.email = S.email AND S.id = T.id GROUP BY U.name, U.surname, Doc.degree HAVING COUNT(S.id) > 2")
for q in conn.execute(q3):
    print(q)

print("\nQuery 4\nAverage salary in all countries where we have doctors who specialize in virology")
q4 = text("SELECT U.cname, AVG(U.salary) FROM Country C, Doctor Doc, Users U, DiseaseType T, Specialize S WHERE U.email = Doc.email AND U.cname = C.cname AND T.id = 1 AND S.id = T.id GROUP BY U.cname")
for q in conn.execute(q4):
    print(q)

print("\nQuery 5\nDepartments of pub_ser who reported covid-19 cases more than 3 times")
q5= text("SELECT P.department, COUNT(*) FROM PublicServant P WHERE P.email IN (SELECT P.email FROM PublicServant P, Record R WHERE R.disease_code = 'U07.1' AND R.email = P.email GROUP BY P.email, R.disease_code HAVING COUNT(*) > 1) GROUP BY P.department")
for q in conn.execute(q5):
    print(q)

print("\nQuery 6")
print("Salaries before") #salaries before the query
q6_bef = text("SELECT U.name, U.salary FROM Users U WHERE email IN (SELECT P.email FROM Users U, PublicServant P, Disease D, Record R WHERE P.email = R.email AND R.disease_code = D.disease_code AND D.disease_code = 'U07.1' GROUP BY P.email, R.disease_code HAVING COUNT(R.disease_code) > 3)")
for q in conn.execute(q6_bef):
    print(q)

print("\nSalaries are updated\n")
q6 = text("UPDATE Users SET salary = salary * 2 WHERE email IN (SELECT P.email FROM Users U, PublicServant P, Disease D, Record R WHERE P.email = R.email AND R.disease_code = D.disease_code AND D.disease_code = 'U07.1' GROUP BY P.email, R.disease_code HAVING COUNT(R.disease_code) > 3)")
conn.execute(q6) #execute the updating query
q6_aft = text("SELECT U.name, U.salary FROM Users U WHERE email IN (SELECT P.email FROM Users U, PublicServant P, Disease D, Record R WHERE P.email = R.email AND R.disease_code = D.disease_code AND D.disease_code = 'U07.1' GROUP BY P.email, R.disease_code HAVING COUNT(R.disease_code) > 3)")
print("Salaries after")
for q in conn.execute(q6_aft):
    print(q)

print("\nQuery 7")
print("Table before the DELETE query")
q7_bef = text("SELECT name FROM Users")
for q in conn.execute(q7_bef):
    print(q)
q7 = text("DELETE FROM Users U WHERE U.name LIKE '%bek' or U.name LIKE '%gul' OR U.name LIKE 'Gul%' or U.name LIKE 'Bek%'")
print("\nThe DELETE Query\n")
conn.execute(q7)
print("Table after the DELETE query")
q7_aft = text("SELECT (name) FROM Users")
for q in conn.execute(q7_aft):
    print(q)

print("Query 8")
q8 = text("CREATE INDEX idxpathogen ON Disease(pathogen)")
conn.execute(q8)
print("The index is created")

print("\nQuery 9\nContacts of the pub_servants who have created records with given constraints")
q9 = text("SELECT DISTINCT U.email, U.name, P.department, R.total_patients FROM Users U, PublicServant P, Record R WHERE U.email = P.email AND P.email = R.email GROUP BY U.email, U.name, P.department, R.total_patients HAVING R.total_patients > 99999 AND R.total_patients < 1000000 ")
for q in conn.execute(q9):
    print(q)

print("\nQuery 10\nTop 5 countries with highest # of total_pat recorded")
q10 = text("SELECT R.cname, SUM(R.total_patients) FROM Record R GROUP BY R.cname ORDER BY SUM(R.total_patients) DESC LIMIT 5")
for q in conn.execute(q10):
    print(q)

print("\nQuery 11\nGrouping of the diseases by dis_type and # of patients")
q11 = text("SELECT T.description, SUM(R.total_patients) FROM Disease D, DiseaseType T, Record R WHERE D.id = T.id AND D.disease_code = R.disease_code GROUP BY T.description ORDER BY SUM(R.total_patients)")
for q in conn.execute(q11):
    print(q)