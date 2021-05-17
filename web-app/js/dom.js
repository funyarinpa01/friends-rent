document.addEventListener('DOMContentLoaded', function () {
    init();
});


const init = function() {
    var page = document.body.id;
    switch (page) {
        case 'register-page':
            document.getElementById("register-button").onclick = function () {
                getUserInfo();
                window.document.location = "shop.html";
            }
            break;
        case 'shop-page':
            getLocalStorageInfo();
            break;
        case 'order-page':
            document.getElementById("order-button").onclick = function () {
                getOrderInfo();
                window.document.location = "shop.html";
            }
            break;
        case 'stats-page':
            document.getElementById("send-query-button").onclick = function () {
                getQueryInfo();
            }
            break;
    }
}

function getUserInfo() {
    let user = {
        "firstName": document.getElementById("fname").value,
        "secondName": document.getElementById("sname").value,
        "email": document.getElementById("email").value,
        "password": document.getElementById("password").value
    }
    localStorage.setItem("user", JSON.stringify(user));
    localStorage.setItem("orders", JSON.stringify([]));
    localStorage.setItem("queries", JSON.stringify([]));
}


function getOrderInfo() {
    let order = {
        "partyType": document.getElementById("party-type").value,
        "beginDate": document.getElementById("begin-date").value,
        "endDate": document.getElementById("end-date").value,
        "present": document.getElementById("present").value
    }
    let orders = JSON.parse(localStorage.getItem("orders"));
    orders.push(order);

    localStorage.setItem("orders", JSON.stringify(orders));
}


function getQueryInfo() {
    let query = {
        "queryID": document.getElementById("query-id").value,
        "personName": document.getElementById("person-name").value,
        "timesNum": document.getElementById("times-num").value,
        "beginDate": document.getElementById("begin-date").value,
        "endDate": document.getElementById("end-date").value
    }
    let queries = JSON.parse(localStorage.getItem("queries"));
    queries.push(query);

    localStorage.setItem("queries", JSON.stringify(queries));
}


function getLocalStorageInfo() {
    let user = JSON.parse(localStorage.getItem("user"));
    let orders = JSON.parse(localStorage.getItem("orders"));
    let queries = JSON.parse(localStorage.getItem("queries"));

    console.log(user, orders, queries);
}