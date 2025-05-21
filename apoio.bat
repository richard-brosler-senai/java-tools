@echo off
chcp 65001
REM Batch de apoio aos Alunos de Java Fundamentas - Senai Bauru
REM Author: Richard Brosler
REM Version: 2025-05-20
REM set dirgit=%APPDATA%\..\Local\Programs\Git
set dirgit=D:\Program Files\Git
set turma=n25-java1-01
if exist %USERPROFILE%\Documents\%turma%\ goto fim
:inicio
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
"%dirgit%\bin\git.exe" config --global user.name "%username%"
"%dirgit%\bin\git.exe" config --global user.email "%email%"
cd %USERPROFILE%\Documents\
"%dirgit%\bin\git.exe" clone %endereco% %turma%
:fim
start "" chrome.exe "https://github.com/richard-brosler-senai/java-tools" "https://github.com" "https://academy.oracle.com/"
call "%dirgit%\git-bash.exe" "--cd=%USERPROFILE%\Documents\%turma%\."