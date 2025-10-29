# 🧠 Image Description AI

Aplicación completa (Flutter + NestJS + OpenAI) que permite al usuario **tomar o seleccionar una imagen**, enviarla a un backend en **NestJS**, el cual usa **ChatGPT (Vision)** para generar una **descripción automática** de la imagen.

---

## 🚀 Tecnologías utilizadas

- **Frontend:** Flutter  
- **Backend:** NestJS (TypeScript)  
- **IA:** OpenAI GPT-4o (Vision)  
- **Despliegue:** Render (nube gratuita)

## ⚙️ Cómo ejecutar localmente

### 1️⃣ Backend (NestJS)

cd backend-nest
npm install
cp .env.example .env
# Agrega tu clave de OpenAI dentro del .env
npm run start:dev
El backend correrá por defecto en http://localhost:3000.

### 2️⃣ Flutter App
- cd flutter_app
- flutter pub get
- flutter run
