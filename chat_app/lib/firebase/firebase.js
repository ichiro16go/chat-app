// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyC7meOusz8ykfX9-uGGK50bkKZcrE2f0xc",
  authDomain: "chat-app-35b56.firebaseapp.com",
  projectId: "chat-app-35b56",
  storageBucket: "chat-app-35b56.appspot.com",
  messagingSenderId: "686130837530",
  appId: "1:686130837530:web:235be55e9b46a0685eb9a3",
  measurementId: "G-CF4JVTT29M"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

