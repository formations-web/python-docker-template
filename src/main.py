import asyncio 

"""
Petit serveur FastAPI pour le cours de Python.
 
Lancement depuis l'intérieur du container, voir make serve :
    uvicorn main:app --host 0.0.0.0 --port 8000 --reload

Depuis l'extérieur :
    make serve
 
Puis, depuis votre machine hôte, rendez-vous sur localhost:8000.
"""
 
from fastapi import FastAPI
 
app = FastAPI(title="Cours Python - Serveur d'exemple")
 
@app.get("/")
def root():
    return {"message": "Bonjour !"}
 
 
@app.get("/health")
def health():
    return {"status": True}
