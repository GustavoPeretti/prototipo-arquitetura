// Formatação do campo de CPF

function formatarCPF(obj) {
    setTimeout(() => {
        let cpf = obj.value;

        cpf = cpf.replace(/\D/g,"");
        cpf = cpf.replace(/(\d{3})(\d)/,"$1.$2");
        cpf = cpf.replace(/(\d{3})(\d)/,"$1.$2");
        cpf = cpf.replace(/(\d{3})(\d{1,2})$/,"$1-$2");

        obj.value = cpf;
    }, 1);
}

function solicitarDados(){
    $('#resultado').empty();

    // Dados

    let cnpj = localStorage.getItem("cnpj");
    let instituicao = localStorage.getItem("instituicao");

    let cpf = $('#cpf').val();
    
    fetch(`http://localhost:5002/verificar-paciente?cpf=${cpf}`)
    .then(response => response.json())
    .then(data => {
        console.log(data)
        console.log(cpf)
        if (!data) {
            alert(`O usuário com CPF ${cpf} não existe na base de dados.`);
            return;
        }
    });

    fetch(`http://localhost:5002/consultar-dados?cnpj=${cnpj}&instituicao=${instituicao}&cpf=${cpf}`)
    .then(response => response.json())
    .then(data => {
        console.log(data);
        if (Object.keys(data)[0] == 'acesso negado') {
            alert(`O usuário com CPF ${cpf} negou o compartilhamento dos dados.`);
            return; 
        }
        $('#resultado').append('<div class="paciente"></div>');
        for (a in data['dados']) {
            $('.paciente').append(`<div id="${a}-data"><h5>${a}</h5></div>`);
            for (b in data['dados'][a][0]) {
                $(`#${a}-data`).append(`<h6>${data['dados'][a][0][b]}</h6>`); 
            }
        }
    });
}
