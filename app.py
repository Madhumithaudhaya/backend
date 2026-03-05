from fastapi import FastAPI
from pydantic import BaseModel
import mysql.connector


app = FastAPI()

# Database connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Madhu@77",
    database="fastapi_db"
)

cursor = db.cursor()

@app.get("/")
def home():
    return {"message": "FastAPI + MySQL working"}

@app.get("/users")
def get_users():
    cursor.execute("SELECT * FROM users")
    result = cursor.fetchall()
    return result



class User(BaseModel):
    name: str
    email: str

@app.post("/create_user")
def create_user(user: User):
    query = "INSERT INTO users (name, email) VALUES (%s, %s)"
    values = (user.name, user.email)

    cursor.execute(query, values)
    db.commit()

    return {"message": "User created successfully"}

@app.get("/users/{user_id}")
def get_user(user_id: int):
    query = "SELECT * FROM users WHERE id=%s"
    cursor.execute(query,(user_id,))
    user = cursor.fetchone()

    if user:
        return user
    else:
        return {"message":"User not found"}