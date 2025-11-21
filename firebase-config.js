// Firebase Configuration
// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional

const firebaseConfig = {
  apiKey: "AIzaSyBdQR_DJzZIucPBEWRMqWlj9-PShbe5x6c",
  authDomain: "insidedeephouse-43ba1.firebaseapp.com",
  databaseURL: "https://insidedeephouse-43ba1-default-rtdb.firebaseio.com",
  projectId: "insidedeephouse-43ba1",
  storageBucket: "insidedeephouse-43ba1.firebasestorage.app",
  messagingSenderId: "250172266194",
  appId: "1:250172266194:web:cc3e05292ef2302ad3ff0b",
  measurementId: "G-1SFNZR8WH8"
};

// Initialize Firebase
let app, database, storage;

try {
  app = firebase.initializeApp(firebaseConfig);
  database = firebase.database(app);
  storage = firebase.storage(app);
  console.log('Firebase initialized successfully');
} catch (error) {
  console.error('Firebase initialization error:', error);
}
