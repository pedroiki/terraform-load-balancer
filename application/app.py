import pymysql
from flask import Flask, render_template

# Crie uma instância do Flask
app = Flask(__name__)

# Configuração da conexão com o banco de dados
db = pymysql.connect(
    host='',  # Host onde o MariaDB está rodando
    user='admin',       # Nome de usuário do banco de dados
    password='',  # Senha do banco de dados
    database='nomes'   # Nome do banco de dados que você deseja conectar
)

# Rota para a página inicial
@app.route('/')
def index():
    return render_template('index.html', mensagem="")

# Rota para obter um nome aleatório
@app.route('/nome_aleatorio', methods=['POST'])
def nome_aleatorio():
    cursor = db.cursor()
    cursor.execute("SELECT Nome FROM Nomes ORDER BY RAND() LIMIT 1")
    nome_aleatorio = cursor.fetchone()[0]
    cursor.close()
    return nome_aleatorio

if __name__ == '__main__':
    app.run(debug=True)
