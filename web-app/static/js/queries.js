query_id_input = document.getElementById('query-id');
query_args = document.getElementById('query-arguments');

query_id_input.addEventListener('change', function () {
    loadQueryFormFields(parseInt(this.value));
});

let queries = [
    [
        [
            ["type", "text"],
            ["id", "person-name"],
            ["placeholder", "Full Name"]
        ],
        [
            ["type", "date"],
            ["id", "begin-date"],
            ["placeholder", "Begin Date"]
        ]
    ],
]

function loadQueryFormFields(query_id) {

    const p = document.createElement('p');
    p.textContent = "Query " + query_id.toString() + " arguments:";
    query_args.appendChild(p);

    for (const field of queries[query_id - 1]) {
        const li = document.createElement('li');
        const input = document.createElement('input');
        for (const attr of field) {
            input.setAttribute(attr[0], attr[1]);
        }
        li.appendChild(input);
        query_args.appendChild(li);
    }
}