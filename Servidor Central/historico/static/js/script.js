function consultar() {
    fetch('http://localhost:5005/consultar')
    .then(response => response.json())
    .then(data => {
        $('tbody').empty();
        for (row of data) {
            $('tbody').append(`<tr><td>${row.api}</td><td>${row.cpf}</td><td>${row.cnpj}</td><td>${row.instituicao}</td><td>${row.horario}</td><td>${row.rota}</td><td><button onclick="modalDisplay('${row.resposta}')">Ver Resposta</button></td></tr>`);
        }
    });
}

consultar();

$('#close-modal').click(() => {
    $('#modal-container').css('display', 'none');
});

function modalDisplay(resposta) {
    $('#modal-container').css('display', 'flex');
    $('#modal p').html(resposta);
}

setInterval(consultar, 10000);