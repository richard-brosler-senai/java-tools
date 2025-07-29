@echo off
chcp 65001
REM Batch de apoio aos Alunos de Java Fundamentas - Senai Bauru
REM Author: Richard Brosler
REM Version: 2025-07-29
set turma=n25-java2-01
set dirgit=%APPDATA%\..\Local\Programs\Git
set /p comentario=Digite o comentário para fechar a versão de dados: 
cd %USERPROFILE%\Documents\%turma%\
echo Adicionando arquivos à versão...
"%dirgit%\bin\git.exe" add .
echo Fechando a versão...
"%dirgit%\bin\git.exe" commit -m "%comentario%"
echo Enviando para o servidor do GitHub...
echo Atenção à autenticação, será solicitado...
"%dirgit%\bin\git.exe" push
pause