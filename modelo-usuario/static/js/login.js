localStorage.clear();

function entrar() {
    localStorage.clear();

    let cpf = $('#cpf').val();
    
    localStorage.setItem('cpf', cpf);

    window.location.href = "interface";
}

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