from fastapi import FastAPI
import mysql.connector
from passlib.context import CryptContext
from pydantic import BaseModel

app = FastAPI()

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Database connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Madhu@77",
    database="fastapi_db"
)

cursor = db.cursor(dictionary=True)

# Request model
class User(BaseModel):
    name: str
    email: str
    password: str


class Login(BaseModel):
    email: str
    password: str


# Password hash function
def hash_password(password: str):
    return pwd_context.hash(password[:72])


# Verify password
def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


# Home route
@app.get("/")
def home():
    return {"message": "FastAPI Backend Working"}


# Create User
@app.post("/users")
def create_user(user: User):

    hashed_password = hash_password(user.password)

    query = """
    INSERT INTO users (name, email, password)
    VALUES (%s, %s, %s)
    """

    cursor.execute(query, (user.name, user.email, hashed_password))
    db.commit()

    return {"message": "User created successfully"}


# Get Users
@app.get("/users")
def get_users():

    cursor.execute("SELECT id, name, email FROM users")
    users = cursor.fetchall()

    return users


# Login API
@app.post("/login")
def login(login: Login):

    query = "SELECT * FROM users WHERE email = %s"
    cursor.execute(query, (login.email,))

    user = cursor.fetchone()

    if not user:
        return {"message": "User not found"}

    if verify_password(login.password, user["password"]):
        return {"message": "Login successful"}

    return {"message": "Invalid password"}