from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Sample in-memory database
users = [
    {"id": 1, "name": "Madhu", "age": 25},
    {"id": 2, "name": "John", "age": 30}
]

# 1️⃣ GET with Path Parameter
@app.get("/users/{user_id}")
def get_user(user_id: int):
    for user in users:
        if user["id"] == user_id:
            return user
    return {"message": "User not found"}


# 2️⃣ GET with Query Parameter
@app.get("/users")
def get_users(age: int = None):
    if age:
        return [user for user in users if user["age"] == age]
    return users


# 3️⃣ POST with Request Body
class User(BaseModel):
    id: int
    name: str
    age: int


@app.post("/users")
def create_user(user: User):
    users.append(user.dict())
    return {"message": "User added successfully", "user": user}
    
@app.delete("/users/{user_id}")
def delete_user(user_id: int):
    for user in users:
        if user["id"] == user_id:
            users.remove(user)
            return {"message": "User deleted"}
    return {"message": "User not found"}