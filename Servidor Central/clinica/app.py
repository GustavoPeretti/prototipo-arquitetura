from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import pymysql
import datetime

app = Flask(__name__)
CORS(app)

def bd_consulta(instrucao, dict_mode=False):
    conexao = pymysql.connect(db="hospital", user="root", password="")
    if dict_mode:
        cursor = conexao.cursor(pymysql.cursors.DictCursor)
    else:
        cursor = conexao.cursor()
    cursor.execute(instrucao)
    resultado = cursor.fetchall()
    conexao.commit()
    conexao.close()
    return resultado

@app.after_request
def after_request(response):
    api = 1
    cpf = request.args.get('cpf')
    cnpj = request.args.get('cnpj')
    instituicao = request.args.get('instituicao')
    data = datetime.datetime.now().isoformat()
    rota = request.path
    resposta = str(response.data.decode('utf-8')).replace('\n', '').replace('\n', '').replace('"', '').replace("'", '')

    bd_consulta(f"INSERT INTO historico (api, cpf, cnpj, instituicao, horario, rota, resposta) VALUES ({api}, '{cpf}', '{cnpj}', '{instituicao}', '{data}', '{rota}', '{resposta}');")
    
    return response

@app.route("/verificar-paciente", methods=["GET"])
def verificar_paciente():
    if "cpf" not in request.args:
        return jsonify({"erro": 'parametro(s) obrigatorio(s) nao informado(s)'})
    cpf = request.args.get("cpf")
    dados = bd_consulta(f"SELECT * FROM pacientes WHERE cpf = '{cpf}';")
    return jsonify(bool(dados)) 

@app.route("/consultar-dados", methods=["GET"])
def consultar_dados():

    if not all(x in request.args for x in ('cpf', 'cnpj', 'instituicao')):
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})
    
    cpf =  request.args.get("cpf")
    cnpj = request.args.get("cnpj")
    instituicao =  request.args.get("instituicao")

    if not requests.get(f"http://localhost:5001/solicitar-acesso?cpf={cpf}&cnpj={cnpj}&instituicao={instituicao}").json():
        return jsonify({"acesso negado": "paciente nao permitiu acesso aos dados"})
    
    bd_consulta(f"INSERT INTO instituicoes (cnpj, nome) SELECT '{cnpj}' , '{instituicao}' WHERE NOT EXISTS (SELECT * FROM instituicoes WHERE cnpj = '{cnpj}');")
    bd_consulta(f"INSERT INTO acessos (pacientes_cpf, instituicoes_cnpj) SELECT '{cpf}' , '{cnpj}' WHERE NOT EXISTS (SELECT * FROM acessos WHERE pacientes_cpf = '{cpf}' AND instituicoes_cnpj ='{cnpj}');")
    
    dados = {"dados":{}}
    medicos = bd_consulta(f"SELECT medicos.* FROM medicos JOIN pacientes ON pacientes.medico_responsavel = medicos.crm WHERE pacientes.cpf = '{cpf}';", True)   
    pacientes = bd_consulta(f"SELECT * FROM pacientes WHERE cpf = '{cpf}';", True)
    planos = bd_consulta(f"SELECT pacote_do_plano, regiao, id_cliente FROM planos WHERE id_cliente = '{cpf}';", True)
    consultas = bd_consulta(f"SELECT data, id_paciente, id_medico FROM consultas WHERE id_paciente = '{cpf}';", True)
    cirurgias = bd_consulta(f"SELECT data, id_paciente, id_medico FROM cirurgias WHERE id_paciente = '{cpf}';", True)
    dados["dados"] = {
        "medicos": medicos,
        "pacientes": pacientes,
        "planos": planos,
        "consultas": consultas,
        "cirurgias": cirurgias
    }
    return jsonify(dados)

if __name__ == "__main__":
    app.run(host= "0.0.0.0", port=5000)
    
