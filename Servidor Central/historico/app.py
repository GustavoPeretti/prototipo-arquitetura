from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql

def bd_consulta(instrucao, dict_mode=False):
    conexao = pymysql.connect(db="hospital", user="root", password="Lapis1895#")
    if dict_mode:
        cursor = conexao.cursor(pymysql.cursors.DictCursor)
    else:
        cursor = conexao.cursor()
    cursor.execute(instrucao)
    resultado = None
    try: resultado = cursor.fetchall()
    except: pass
    conexao.commit()
    conexao.close()
    return resultado

app = Flask(__name__)
CORS(app)

@app.route('/consultar')
def consultar():
    return jsonify(bd_consulta(f"SELECT * FROM historico", dict_mode=True))

if __name__ == "__main__":
    app.run(debug=True, host= "0.0.0.0", port=5005)
    
