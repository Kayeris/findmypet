import * as functions from 'firebase-functions';

import Keys from "./keys";
//import admin from 'firebase-admin';
import firebase from 'firebase/app';

require("firebase/database");

require("firebase/auth");
require("firebase/storage");


import express from "express";


const app = express();


//tsc - w
//find a way to enter firebase init emulators and choose db & functions
//firebase emulators:start

//Deploy: firecast jason$ firebase deploy --only functions




firebase.initializeApp({
    apiKey: Keys.APIKEY,
    authDomain: Keys.AUTHDOMAIN,
    databaseURL: Keys.DATABASEURL,
    projectId: Keys.PROJECTID,
    storageBucket: Keys.STORAGEBUCKET,
    messagingSenderId: Keys.MESSAGINGSENDERID,
    appId: Keys.APPID
})




app.post('/inputForm', async (req, res) => {

    //takes in input form and sends it to firebase and assign an id to it

    let query = req.query;

    if (query.userId == null) { return res.json({ data: false, message: "You need to pass the userId" }) }
    let ref = firebase.database().ref();
    let id = await getNewId(ref.child("numPets"));
    ref.child("Posts").push({
        id: id,
        userId: query.userId,
        petName: query.petName ?? " ",
        image: query.image ?? " hello",
        description: query.description ?? " ",
        location: query.location ?? " ",
        ownerName: query.ownerName ?? " ",
        ownerPN: query.ownerPN ?? " ",
        ownerEmail: query.ownerEmail ?? " ",
        hashtags: query.hashtags ?? [],
        creationTime: Date.now()

    }).then(() => {
        return res.json({ data: true });
    }).catch(async () => {

        await getNewId(ref.child("numPets"), false);
        return res.json({ data: false })
    })
    return
});


app.get('/search', async (req, res) => {

    let ref = firebase.database().ref("Posts");
    let array: any[] = []
    let userId: any = req.query.userId;
    let userIdArr: any[] = [];

    ref.orderByChild("creationTime").once('value').then((async function (snapshot) {
        if (!snapshot.exists()) { return res.json(array) }

        else {
            snapshot.forEach(function (snapshot) {

                let childData = snapshot.val()
                if (userId == null) {
                    array.push(childData)
                }

                if (userId != null) {
                    if (childData["userId"] == userId) {
                        userIdArr.push(childData);
                    }
                    else {
                        array.push(childData)

                    }
                }

            });
            userIdArr.reverse();
            array.reverse()
            Array.prototype.push.apply(userIdArr, array);

            return res.json(userIdArr)

        }
    })).catch(() => { res.json({ "data": false }) })


    return;
});





app.get('/viewPost', async (req, res) => {



    let id: any = req.query.id;
    if (id == null) { return res.json({ data: false, message: "You need to pass the id" }) }
    let ref = firebase.database().ref("Posts");

    ref.orderByChild("creationTime").once('value').then((async function (snapshot) {
        if (!snapshot.exists()) {
            console.log("empoty");

            return res.json({})
        }
        else {
            let data: any;
            snapshot.forEach(function (snapshot) {

                let childData = snapshot.val()

                if (childData["id"] == id) {
                    data = childData
                }



            });
            if (data == null) {
                return res.json({ "data": false, message: "No Such id in the database" })
            }
            return res.json(data);

        }
    })).catch(() => { res.json({ "data": false }) })


    return;
});




const getNewId = async function (ref: firebase.database.Reference, increment = true): Promise<number> {

    let num: number = 1

    await ref.transaction((post) => {
        if (post == null) {
            return { "id": num }
        }
        else {
            if (increment)
                num = (post.id as number) + 1
            num = (post.id as number) + 1

            return { "id": num }
        }

    })

    return num

}


exports.api = functions.https.onRequest(app);
