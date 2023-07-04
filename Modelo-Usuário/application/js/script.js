const cpf = '111.111.111-11';
const address = 'localhost';

$('#list').click(() => {
    $('#modal').css('display', 'block');
    $('#modal-container ul').empty();
    verificarInstituicoes();
});

$('#fechar-modal').click(() => {
    $('#modal').css('display', 'none');
});

function verificarNotificacoes() {
    $('#notification-board').empty();
    fetch(`http://${address}:5003/receber-solicitacoes?cpf=${cpf}`) 
    .then(response => response.json())
    .then(data => {
        if (data.length > 0) {
            for (item of data) {
                $('#notification-board').append(`<div class="prev-not"><p>${item.instituicao}: Acesso aos dados</p><div class="buttons"><button id="allow" class="not-btn" onclick="responderSolicitacao('${item.cnpj}', 1);">Aceitar</button><button id="deny" class="not-btn" onclick="responderSolicitacao('${item.cnpj}', 0);">Recusar</button></div></div>`);
            }
        }
    })
    .catch(error => console.error(error));
}

function responderSolicitacao(cnpj, resposta) {
    fetch(`http://${address}:5003/responder-solicitacao?cpf=${cpf}&cnpj=${cnpj}&resposta=${resposta}`)
    .then(response => response.json())
    .then(data => {
        keys = Object.keys(data);
        alert(keys);
    })
    .catch(error => console.error(error));
}

function verificarInstituicoes() {
    fetch(`http://${address}:5003/verificar-instituicoes?cpf=${cpf}`)
    .then(response => response.json())
    .then(data => {
        for (instituicao of data) {
            $('#modal-container ul').append(`<li><span>${instituicao[1]}</span><button onclick="solicitarExclusao('${instituicao[0]}')">Restringir</button></li>`)
        }
    })
    .catch(error => console.error(error));
}

function solicitarExclusao(cnpj) {
    fetch(`http://${address}:5003/solicitar-exclusao?cpf=${cpf}&cnpj=${cnpj}`)
    .then(response => response.json())
    .then(data => {
        keys = Object.keys(data);
        alert(keys);
        $('#modal').css('display', 'none');
    })
    .catch(error => console.error(error));
}

setInterval(verificarNotificacoes, 3000);
