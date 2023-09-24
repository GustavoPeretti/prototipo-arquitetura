from flask import Flask, jsonify, render_template
from flask_cors import CORS
import pymysql

def bd_consulta(instrucao, dict_mode=False):
    conexao = pymysql.connect(db="hospital", user="root", password="")
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

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/consultar')
def consultar():
    return jsonify(bd_consulta(f"SELECT * FROM historico", dict_mode=True))

if __name__ == "__main__":
    app.run(host= "0.0.0.0", port=5005)
    