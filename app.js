var express = require("express");
var keys = require("./keys");

var app = express();


/*
 // Your web app's Firebase configuration

*/

firebase.initializeApp(keys.firebaseConfig);

app.get("/inputForm", (req, res, next) => {
    res.json(["Tony", "Lisa", "Michael", "Ginger", "Food"]);
});



app.listen(3000, () => {
    console.log("Server running on port 3000");
});

