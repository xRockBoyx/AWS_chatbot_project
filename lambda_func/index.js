'use strict';
//main handler
exports.handler = (event, context, callback) =>{
    //log out the input from Lxx
    console. log("event: " + JSON.stringify(event));
    checkIntent(event, (response) => callback(null, response));
}
//take action based on what intent
function checkIntent(event, callback) {
    //get current intemt
    const name = event.currentIntent.name;
    const outputSessionAttributes = event.sesstonAttributes || {};
    const slots = event.currentIntent.slots;
    const variety = slots.variety;
    const seasoning = slots.seasoning;
    const size = slots.size;
//if ExplainBot intent
    switch(name){
        case 'ChickenCutletOrders':
            writedatabase(variety,seasoning,size);
            callback(close(outputSessionAttributes,'Fulfilled', `OK,I have ordered a ${size} ${variety} chicken cutlets that add ${seasoning}.`));
            break;
        default:
            callback(close(outputSessionAttributes, 'Fulfilled', 'I"m afraid I did not understand the question'));
    }
}
function writedatabase(variety, seasoning,size){
    var mysql = require('mysql');

    var con = mysql.createConnection({
        host: "",
        user: "",
        password: "",
        database: ""
    });

    con.connect(function(err) {
        if (err) throw err;
        console.log("Connected!");
        var sql = `INSERT INTO Orders(Variety,Seasoning,Size) VALUES('${variety}', '${seasoning}','${size}')`;
        con.query(sql, function (err, result) {
            if (err) throw err;
            console.log("1 record inserted");
            con.end();
        });
        
    });
}

function close(sessionAttributes, fulfillmentState, messageContent) {
    return {
        sessionAttributes,
        dialogAction:{
            type:"Close",
            fulfillmentState: fulfillmentState,
            message: { contentType: 'PlainText', content: messageContent }
        }
    }
}
