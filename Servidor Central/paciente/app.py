from flask import Flask, jsonify, request
from flask_cors import CORS
import requests
import pymysql
import datetime

address = '10.0.22.16'

def bd_consulta(instrucao):
    conexao = pymysql.connect(db="hospital", user="root", password="bananasplit2023")
    cursor = conexao.cursor()
    cursor.execute(instrucao)
    resultado = cursor.fetchall()
    conexao.commit()
    conexao.close()
    return resultado

app = Flask(__name__)
CORS(app)

@app.after_request
def after_request(response):
    api = 2
    cpf = request.args.get('cpf')
    cnpj = request.args.get('cnpj')
    instituicao = request.args.get('instituicao')
    data = datetime.datetime.now().isoformat()
    rota = request.path
    resposta = str(response.data.decode('utf-8')).replace('\n', '').replace('\n', '').replace('"', '').replace("'", '')

    bd_consulta(f"INSERT INTO historico (api, cpf, cnpj, instituicao, horario, rota, resposta) VALUES ({api}, '{cpf}', '{cnpj}', '{instituicao}', '{data}', '{rota}', '{resposta}');")
    
    return response

@app.route('/consultar-instituicoes', methods=['GET'])
def consultar_clinicas():

    # Verificar parâmetros
    if not 'cpf' in request.args:
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})
    
    return jsonify(bd_consulta(f'SELECT instituicoes.cnpj, instituicoes.nome FROM acessos JOIN instituicoes ON acessos.instituicoes_cnpj = instituicoes.cnpj WHERE acessos.pacientes_cpf = "{request.args.get("cpf")}";'))

# SUS consulta aqui
@app.route('/excluir-acesso', methods=['GET'])
def excluir_acesso():

    # Verificar parâmetros
    if not all(x in request.args for x in ('cpf', 'cnpj')):
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})

    bd_consulta(f'DELETE FROM acessos WHERE pacientes_cpf="{request.args.get("cpf")}" AND instituicoes_cnpj="{request.args.get("cnpj")}";')

    return jsonify({'sucesso': 'acesso excluido com sucesso'})

@app.route('/solicitar-acesso', methods=['GET'])
def solicitar_acesso():

    # Verificar parâmetros
    if not all(x in request.args for x in ('cnpj', 'instituicao', 'cpf')):
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})

    if bd_consulta(f'select * from acessos where instituicoes_cnpj = "{request.args.get("cnpj")}" AND pacientes_cpf = "{request.args.get("cpf")}";'):
        return jsonify(True)
    
    return jsonify(requests.get(f'http://{address}:5003/solicitacao?cnpj={request.args.get("cnpj")}&instituicao={request.args.get("instituicao")}&cpf={request.args.get("cpf")}').json())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
