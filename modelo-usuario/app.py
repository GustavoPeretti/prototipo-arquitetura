from flask import Flask, jsonify, request, render_template
from flask_cors import CORS
import requests

address =  'localhost'

app = Flask(__name__)
CORS(app)

class Solicitacao:
    solicitacoes = []

    def __init__(self, cnpj, instituicao, cpf):
        self.cnpj = cnpj
        self.instituicao = instituicao
        self.cpf = cpf
        self.estado = 'em espera'

        self.solicitacoes.append(self)

    def responder(self, resposta):
        self.estado = resposta


@app.route("/")
def index():
    return render_template('index.html')

@app.route('/interface')
def interface():
    return render_template('interface.html')

# Instituição solicita nesta rota
@app.route('/solicitacao', methods=['GET'])
def solicitacao():

    # Verificar parâmetros
    if not all(x in request.args for x in ('cnpj', 'instituicao', 'cpf')):
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})
    
    cnpj = request.args.get('cnpj')
    instituicao = request.args.get('instituicao')
    cpf = request.args.get('cpf')

    solicitacao = Solicitacao(cnpj, instituicao, cpf)
    
    while solicitacao.estado == 'em espera':
        pass
    else:
        return jsonify(solicitacao.estado)

# Paciente verifica se há solicitações
@app.route('/receber-solicitacoes', methods=['GET'])
def receber_solicitacoes():

    # Verificar parâmetros
    if not 'cpf' in request.args:
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})
    
    return jsonify(list(x.__dict__ for x in Solicitacao.solicitacoes if x.cpf == request.args.get('cpf')))

# Pacitente responde uma solicitação
@app.route('/responder-solicitacao', methods=['GET'])
def responder_solicitacao():

    # Verificar parâmetros
    if not all(x in request.args for x in ('cpf', 'cnpj', 'resposta')):
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})
    
    cpf = request.args.get('cpf')
    cnpj = request.args.get('cnpj')

    pedido = [x for x in Solicitacao.solicitacoes if (x.cpf == cpf and x.cnpj == cnpj)][0]

    pedido.estado = bool(int(request.args.get('resposta')))

    Solicitacao.solicitacoes.pop(Solicitacao.solicitacoes.index(pedido))

    return jsonify({'sucesso': 'solicitacao respondida'})

@app.route('/verificar-instituicoes', methods=['GET'])
def verificar_instituicoes():

    # Verificar parâmetros
    if not 'cpf' in request.args:
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})
    
    return jsonify(requests.get(f'http://{address}:5001/consultar-instituicoes?cpf={request.args.get("cpf")}').json())

@app.route('/solicitar-exclusao', methods=['GET'])
def solicitar_exclusao():

    # Verificar parâmetros
    if not all(x in request.args for x in ('cpf', 'cnpj')):
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})
    
    return jsonify(requests.get(f'http://{address}:5001/excluir-acesso?cpf={request.args.get("cpf")}&cnpj={request.args.get("cnpj")}').json())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003)
