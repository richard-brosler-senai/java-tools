import questionary, re, requests, subprocess, os
from click import clear
from urllib.request import urlopen
from dotenv import load_dotenv
from platform import node
load_dotenv(override=True)
"""
Programa para apoiar os alunos no curso de Java para clonar seu repositório
"""
def validar_email_robusto(texto):
    padrao = r'^[\w\.-]+@[\w\.-]+\.\w{2,}$'
    return re.match(padrao, texto) is not None
    
def menu():
    chave = os.environ.get('CHAVEAPP')
    senha = os.environ.get('SENHAAPP')
    turma = "n25-java2-01"
    dirgit= f"{os.environ.get('APPDATA')}\\..\\Local\\Programs\\Git"
    if not os.path.exists(dirgit):
        dirgit = f"{os.environ.get('ProgramFiles')}\\git"
        if not os.path.exists(dirgit):
            dirgit = "D:\\Program Files\\git"
    # Verificando se o diretório existe
    diretorio = f"{os.environ.get('USERPROFILE')}\\Documents\\{turma}"
    confirmar = os.path.isdir(diretorio)
    # Se não existir, clonando o repositório
    while not confirmar:
        clear()
        email = questionary.text("Qual é o seu E-mail?", validate=lambda text: True if validar_email_robusto(text) else "E-mail está em formato inválido!.").ask()
        nome = repositorio = ""
        url = f"https://senai701.brosler.pro.br/ws-patrimonio/api/diario-fic-email/{chave}?email={email}"
        resposta = requests.get(url, auth=('Senai', senha))
        if resposta.status_code == 200:
            nome = resposta.json().get('diario')['nome']
            repositorio = resposta.json().get('diario')['repositorio']
        nome = questionary.text("Informar seu nome: ",default=nome).ask()
        repositorio = questionary.text("Informar seu repositório do git: ",default=repositorio).ask()
        confirmar = questionary.confirm("As informações estão corretas?", default=False).ask()
        if confirmar:
            url = f"https://senai701.brosler.pro.br/ws-patrimonio/api/diario-fic/{chave}"
            ret = requests.post(url, json={
                "nome": nome,
                "repositorio": repositorio,
                "email": email,
                "maquina": node()
            }, headers={"Content-Type": "application/json"})
            # print(ret.json())
            # Configurando o git
            subprocess.run([f"{dirgit}\\bin\\git.exe", "config", "--global", "user.name", f'"{nome}"'])
            subprocess.run([f"{dirgit}\\bin\\git.exe", "config", "--global", "user.email", f'"{email}"'])
            # Clonando o repositório
            subprocess.run([f"{dirgit}\\bin\\git.exe", "clone", repositorio, diretorio])
    # Verificando se o arquivo subir.bat existe
    if not os.path.exists(diretorio + "\\subir.bat"):
        with urlopen("https://raw.githubusercontent.com/richard-brosler-senai/java-tools/refs/heads/master/subir2.bat") as response:
            conteudo = response.read().decode('utf-8')
            conteudo = conteudo.replace("\r\n", "\n")
            conteudo = conteudo.replace("\n", "\r\n")
            with open(diretorio + "\\subir.bat", "w", newline='',encoding='utf-8') as file:
                file.write(conteudo)
if __name__ == "__main__":
    menu()