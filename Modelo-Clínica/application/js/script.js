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

// Dados

let cnpj = localStorage.getItem("cnpj");
let instituicao = localStorage.getItem("instituicao");

let cpf = $('#cpf').val();

// let resposta_teste = {
//     dados: {
//         medicos: ['000000/SC', 'João', 'Cardiologia'],
//         pacientes: ['111.111.111-11', 'Bob', '1.111.111', '1970-01-01', 'M', 'Maria', 'João', 'bob@bobmail.com', '11111-111', 'Rua do Bob, 111', '1111111111', 'Bairro do Bob', 'Cidade do Bob', 'SC', '11 111111111', '11 111111111', 170, 60, 'ab+', '000000/SC'],
//         planos: ['Plano X', 'SC', '111.111.111-11'],
//         consultas: ['2023-05-3', '111.111.111-11', '000000/SC'],
//         cirurgias: ['2023-06-30', '111.111.111-11', '000000/SC']
//     }
// };

// function teste() {
//     $('#resultado').empty();
//     $('#resultado').append('<div class="paciente"></div>');
//     for (a in resposta_teste['dados']) {+
//         $('.paciente').append(`<div id="${a}-data"><h5>${a}</h5></div>`);
//         for (b of resposta_teste['dados'][a]) {
//             $(`#${a}-data`).append(`<h6>${b}</h6>`);
//         }
//     }
// }

function solicitarDados(){
    $('#resultado').empty();
    
    fetch(`http://localhost:5002/verificar-dados?cpf=${cpf}`)
    .then(response => response.json())
    .then(data => {
        if (!data) {
            alert(`O usuário com CPF ${cpf} não existe na base de dados.`);
            return;
        }
    });

    fetch(`http://localhost:5002/consultar-dados?cnpj=${cnpj}&instituicao=${instituicao}&cpf=${cpf}`)
    .then(response => response.json())
    .then(data => {
        if (Object.keys(data)[0] == 'acesso negado') {
            alert(`O usuário com CPF ${cpf} negou o compartilhamento dos dados.`);
            return;
        }
        $('#resultado').append('<div class="paciente"></div>');
        for (a in data['dados']) {
            $('.paciente').append(`<div id="${a}-data"><h5>${a}</h5></div>`);
            for (b of data['dados'][a]) {
                $(`#${a}-data`).append(`<h6>${b}</h6>`);
            }
        }
    });
}
