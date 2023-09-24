localStorage.clear();

function entrar() {
    localStorage.clear();

    let cnpj = $('#cnpj').val();
    let instituicao = $('#instituicao').val();
    
    localStorage.setItem('cnpj', cnpj);
    localStorage.setItem('instituicao', instituicao);

    window.location.href = "interface";
}