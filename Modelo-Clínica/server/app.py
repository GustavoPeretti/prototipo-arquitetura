from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

@app.route("/verificar-paciente", methods=["GET"])
def verificar_paciente():
    if not "cpf" in request.args:
        return jsonify({"erro": 'parametro(s) obrigatorio(s) nao informado(s)'})
    cpf = request.args.get("cpf")
    return jsonify(bool(requests.get(f"http://localhost:5000/verificar-paciente?cpf={cpf}").json())) 

@app.route("/consultar-dados", methods=["GET"])
def consultar_dados():
    if not all(x in request.args for x in ('cpf', 'cnpj', 'instituicao')):
        return jsonify({'erro': 'parametro(s) obrigatorio(s) nao informado(s)'})
    cpf = request.args.get("cpf")
    cnpj = request.args.get("cnpj")
    instituicao = request.args.get("instituicao")
    return jsonify(requests.get(f"http://10.0.26.217:5000/consultar-dados?cpf={cpf}&cnpj={cnpj}&instituicao={instituicao}").json())
    

if __name__ == "__main__":
    app.run(debug=True, host= "0.0.0.0", port=5002)
    