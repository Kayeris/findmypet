import * as functions from 'firebase-functions';

import Keys from "./keys";
//import admin from 'firebase-admin';
import firebase from 'firebase/app';
import admin from 'firebase-admin';
import serviceAccount from './admin.json';

require("firebase/database");

require("firebase/auth");
require("firebase/storage");




import express from "express";


const app = express();

let params = {
    type: serviceAccount.type,
    projectId: serviceAccount.project_id,
    privateKeyId: serviceAccount.private_key_id,
    privateKey: serviceAccount.private_key,
    clientEmail: serviceAccount.client_email,
    clientId: serviceAccount.client_id,
    authUri: serviceAccount.auth_uri,
    tokenUri: serviceAccount.token_uri,
    authProviderX509CertUrl: serviceAccount.auth_provider_x509_cert_url,
    clientC509CertUrl: serviceAccount.client_x509_cert_url
}
admin.initializeApp({
    credential: admin.credential.cert(params),
    databaseURL: "https://findmypet-312403-default-rtdb.firebaseio.com"
});

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

    let ref = firebase.database().ref();

    if (req.query.userId == null) {
        ref.child('Posts').orderByChild("creationTime").get().then((function (snapshot) {
            if (!snapshot.exists()) { res.json([]) }
            else {
                snapshot.forEach(function (snapshot) {

                    let childData = snapshot.val()
                    console.log(childData);
                });

                res.json({ "data": true })
            }
        }))

    }

    return
});






/*
const findKeyByEmail = async function (ref: firebase.database.Reference, user: string): Promise<string> {
    let key: string = "";
    await ref.get().then((function (snapshot) {

        if (snapshot.exists()) {
            snapshot.forEach(function (snapshot) {

                let childData = snapshot.val()
                if (user == childData["user"]) {
                    key = (snapshot.key) as string
                }
            });
        }

    }))
    if (key == "")
        console.log("user: " + user + " does not exist")
    return key;

}
*/
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


exports.widgets = functions.https.onRequest(app);
