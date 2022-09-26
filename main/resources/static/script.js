// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCJwATudRweCOtajSaneTVZGDT8mRSRiiA",
  authDomain: "bestcosmetic-624a1.firebaseapp.com",
  projectId: "bestcosmetic-624a1",
  storageBucket: "bestcosmetic-624a1.appspot.com",
  messagingSenderId: "925032279772",
  appId: "1:925032279772:web:92bc96a0e161013ff88e19"
};		  

	firebase.initializeApp(firebaseConfig);

// also store files path in localstorage or in database for further use
if(!localStorage.getItem("uploaded-metadata")){
    var metadata = '[]';
    localStorage.setItem('uploaded-metadata', metadata)
}
    