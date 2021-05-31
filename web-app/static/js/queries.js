query_id_input = document.getElementById('query-id');
query_args = document.getElementById('query-arguments');

query_id_input.addEventListener('change', function () {
    loadQueryFormFields(parseInt(this.value));
});

function inputTextField(id, placeholder) {
    return [
        ["type", "text"],
        ["name", id],
        ["id", id],
        ["placeholder", placeholder]
    ];
}

function inputNumberField(id, placeholder) {
    return [
        ["type", "number"],
        ["name", id],
        ["id", id],
        ["placeholder", placeholder],
        ["min", "0"],
        ["step", "1"],
        ["oninput", "validity.valid||(value='');"]
    ];
}

function inputDateField(id, placeholder) {
    return [
        ["type", "text"],
        ["name", id],
        ["id", id],
        ["placeholder", placeholder],
        ["onfocus", "(this.type='date')"],
        ["onblur", "(this.type='text')"]
    ];
}

let queries = [
    [
        inputTextField("client", "Client name"),
        inputNumberField("minimum", "Minimum amount"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
        inputTextField("friend", "Friend name"),
        inputNumberField("minimum", "Minimum amount"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
        inputTextField("friend", "Friend name"),
        inputNumberField("minimum", "Minimum amount"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
        inputNumberField("minimum", "Minimum amount"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
        inputNumberField("minimum", "Minimum amount"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
    ],
    [
        inputTextField("friend", "Friend name"),
        inputNumberField("minimum", "Minimum amount"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
        inputTextField("client", "Client name"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
        inputNumberField("minimum", "Minimum amount"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
        inputTextField("client", "Client name"),
        inputTextField("friend", "Friend name"),
        inputDateField("begin", "Begin date"),
        inputDateField("end", "End date")
    ],
    [
        inputNumberField("minimum", "Minimum amount"),
        inputNumberField("maximum", "Maximum amount")
    ],
    [
        inputTextField("friend", "Friend name") // TODO fix input fields, slightly not centered
    ]
]

function loadQueryFormFields(query_id) {
    query_args.innerHTML = "";

    for (const field of queries[query_id - 1]) {
        const li = document.createElement('li');
        const input = document.createElement('input');
        input.setAttribute('class', 'query-form-control');

        for (const attr of field) {
            input.setAttribute(attr[0], attr[1]);
        }

        li.appendChild(input);
        query_args.appendChild(li);
    }
}