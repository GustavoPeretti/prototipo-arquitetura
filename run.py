import os
import threading

os.system('start chrome http://localhost:5002/')
os.system('start chrome http://localhost:5005/')
os.system('start chrome http://localhost:5003/')

threading.Thread(target=lambda: os.system(r'python modelo-clinica\app.py')).start()
threading.Thread(target=lambda: os.system(r'python modelo-usuario\app.py')).start()
threading.Thread(target=lambda: os.system(r'python servidor-central\clinica\app.py')).start()
threading.Thread(target=lambda: os.system(r'python servidor-central\paciente\app.py')).start()
threading.Thread(target=lambda: os.system(r'python servidor-central\historico\app.py')).start()

