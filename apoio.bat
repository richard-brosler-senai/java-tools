@echo off
chcp 65001
REM Batch de apoio aos Alunos de Java Fundamentas - Senai Bauru
REM Author: Richard Brosler
REM Version: 2025-05-20
set dirgit=%APPDATA%\..\Local\Programs\Git
set turma=n25-java1-01
set chave=5146767e-e885-4436-a7e8-1af5593aa772
echo Abrindo as páginas para o uso diário...
start "" chrome.exe "https://github.com/richard-brosler-senai/java-tools" "https://github.com" "https://academy.oracle.com/" ""
if exist %USERPROFILE%\Documents\%turma%\ goto fim
:inicio
echo Vamos configurar o Git nesse momento...
echo .
set /p username=Digite seu Nome: 
set /p email=Digite seu E-mail de conta do github: 
set /p endereco=Digite seu endereço do repositório do github: 
echo .
echo Seu username é %username%
echo Seu e-mail utilizado no github é %email%
echo Seu repositório do github é %endereco%
echo .
echo Essas informações estão corretas?
set /p confirma=Tecle S para SIM ou qualquer outra tecla para Não: 
if NOT "%confirma%" == "S" goto inicio
curl -s -X POST -H "Content-type: application/json" --data "{\"nome\": \"%username%\", \"email\": \"%email%\", \"repositorio\": \"%endereco%\"}" https://senai701.brosler.pro.br/ws-patrimonio/api/diario-fic/%chave%
echo Executando comandos do git...
"%dirgit%\bin\git.exe" config --global user.name "%username%"
"%dirgit%\bin\git.exe" config --global user.email "%email%"
echo Posicionando no diretório de documentos...
cd %USERPROFILE%\Documents\
echo Clonando o repositório remoto...
"%dirgit%\bin\git.exe" clone %endereco% %turma%
:fim
if NOT exist %USERPROFILE%\Documents\%turma%\subir.bat (
curl -s -o %USERPROFILE%\Documents\%turma%\subir.bat https://raw.githubusercontent.com/richard-brosler-senai/java-tools/refs/heads/master/subir.bat
powershell -Command "(Get-Content -Raw -Path %USERPROFILE%\Documents\%turma%\subir.bat) -replace '\n',\"`r`n\" | Set-Content -NoNewline %USERPROFILE%\Documents\%turma%\subir.bat"
)
echo Abrindo o git-bash no diretório do projeto...
start "" "%dirgit%\git-bash.exe" "--cd=%USERPROFILE%\Documents\%turma%\."