// Manipulação da seleção

let selected = 'paciente';

function selectTab(arg) {
    selected = arg;
    document.querySelectorAll('#tabs > *').forEach((i) => {
        i.classList.remove('selected');
    });
    document.querySelector('#tab-' + arg).classList.add('selected');
    if (document.querySelectorAll('#resultado > *').length == 0) {
        return;
    }
    document.querySelectorAll('#resultado > *').forEach((i) => {
        i.classList.add('hidden');
    });
    document.querySelector('#div-' + arg).classList.remove('hidden');
}

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

function solicitarDados(){
    $('#resultado').empty();

    // Dados

    let cnpj = localStorage.getItem("cnpj");
    let instituicao = localStorage.getItem("instituicao");

    let cpf = $('#cpf').val();
    
    fetch(`http://localhost:5002/verificar-paciente?cpf=${cpf}`)
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

        dados = data;

        if (Object.keys(data)[0] == 'acesso negado') {
            alert(`O usuário com CPF ${cpf} negou o compartilhamento dos dados.`);
            return; 
        }
        
        let paciente = dados['dados']['pacientes'][0];

        $('#resultado').append('<div class="hidden" id="div-paciente"></div>')

        $('#div-paciente').append(`<h6>CPF: ${paciente.cpf}</h6>`);
        $('#div-paciente').append(`<h6>Nome: ${paciente.nome}</h6>`);
        $('#div-paciente').append(`<h6>RG: ${paciente.rg}</h6>`);
        $('#div-paciente').append(`<h6>Data de nascimento: ${paciente.data_nasc}</h6>`);
        $('#div-paciente').append(`<h6>Sexo: ${paciente.sexo}</h6>`);
        $('#div-paciente').append(`<h6>Nome da mãe: ${paciente.mae}</h6>`);
        $('#div-paciente').append(`<h6>Nome do pai: ${paciente.pai}</h6>`);
        $('#div-paciente').append(`<h6>E-mail: ${paciente.email}</h6>`);
        $('#div-paciente').append(`<h6>CEP: ${paciente.cep}</h6>`);
        $('#div-paciente').append(`<h6>Endereço: ${paciente.endereço}</h6>`);
        $('#div-paciente').append(`<h6>Número para contato: ${paciente.numero}</h6>`);
        $('#div-paciente').append(`<h6>Bairro: ${paciente.bairro}</h6>`);
        $('#div-paciente').append(`<h6>Cidade: ${paciente.cidade}</h6>`);
        $('#div-paciente').append(`<h6>Estado: ${paciente.estado}</h6>`);
        $('#div-paciente').append(`<h6>Telefone fixo: ${paciente.telefone_fixo}</h6>`);
        $('#div-paciente').append(`<h6>Celular: ${paciente.celular}</h6>`);
        $('#div-paciente').append(`<h6>Altura (cm): ${paciente.altura}</h6>`);
        $('#div-paciente').append(`<h6>Peso (kg): ${paciente.peso}</h6>`);
        $('#div-paciente').append(`<h6>Tipo sanguíneo: ${paciente.tipo_sanguineo}</h6>`);
        $('#div-paciente').append(`<h6>Médio responsável: ${paciente.medico_responsavel}</h6>`);
        $('#div-paciente').append(`<h6>Data de cadastro: ${paciente.data_cadastro}</h6>`);

        let planos = dados['dados']['planos'];

        $('#resultado').append('<div class="hidden" id="div-planos"></div>')

        for (plano of planos) {
            $('#div-planos').append(`<h6>Pacote: ${plano.pacote_do_plano}`);
            $('#div-planos').append(`<h6>Região: ${plano.regiao}`);
            $('#div-planos').append(`<h6>CPF do cliente: ${plano.id_cliente}</h6>`); 
            $('#div-planos').append('<br>'); 
        }

        let medicos = dados['dados']['medicos'];

        $('#resultado').append('<div class="hidden" id="div-medicos"></div>')

        for (medico of medicos) {
            $('#div-medicos').append(`<h6>CRM: ${medico.crm}`);
            $('#div-medicos').append(`<h6>Nome: ${medico.nome}`);
            $('#div-medicos').append(`<h6>Especialização: ${medico.especializacao}`);
            $('#div-medicos').append('<br>');
        }

        let consultas = dados['dados']['consultas'];

        $('#resultado').append('<div class="hidden" id="div-consultas"></div>')

        for (consulta of consultas) {
            $('#div-consultas').append(`<h6>Data: ${consulta.data}`);
            $('#div-consultas').append(`<h6>Médico: ${consulta.id_medico}`);
            $('#div-consultas').append('<br>');
        }

        let cirurgias = dados['dados']['cirurgias'];

        $('#resultado').append('<div class="hidden" id="div-cirurgias"></div>')

        for (cirurgia of cirurgias) {
            $('#div-cirurgias').append(`<h6>Data: ${cirurgia.data}`);
            $('#div-cirurgias').append(`<h6>Médico: ${cirurgia.id_medico}`);
            $('#div-cirurgias').append('<br>');
        }

        selectTab(selected);
    });
}


