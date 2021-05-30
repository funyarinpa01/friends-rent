query_id_input = document.getElementById('query-id')

query_id_input.addEventListener('keyup', function () {
    loadQueryFormFields(this.value);
});

let queries = [

]

function loadQueryFormFields(query_id) {
    console.log(query_id);
}