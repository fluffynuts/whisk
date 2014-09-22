@echo off
if "%1" EQU "" goto usage
set MYAPP_Folder=%1
goto app
:usage
echo ** Please provide the name for the new application folder.    **
echo **  This can be supplied as a parameter to this command file. **
echo **  eg:    NewWebStarterKitApp MyAppFolder                    **
set /P MYAPP_Folder=Folder Name: 
:app
SET BASE_FOLDER=%CD%
mkdir %MYAPP_Folder%
cd %MYAPP_Folder%
SET MYAPP_FOLDER=%CD%
cd %BASE_FOLDER%
cd web-starter-kit
IF %ERRORLEVEL% NEQ 0 (
    git clone https://github.com/google/web-starter-kit.git web-starter-kit
    cd web-starter-kit
)
SET WSK_FOLDER=%CD%
:copy_WSK_to_folder
git archive master --format zip > %TEMP%\wsk.zip
cd %MYAPP_Folder%
mkdir source
cd source
unzip %TEMP%\wsk.zip
del %TEMP%\wsk.zip
echo ** Copied web starter kit into folder: %MYAPP_Folder%
:install_deps
echo *** Installing dependencies... ***
copy %BASE_FOLDER%\package.json
call npm install
:create_cordova_app
echo *** Create the cordova app... ***
mkdir dist
color 17
SET /P APP_NAME=Provide your app name: 
SET /P APP_ID=Provide your app id (eg. 'com.yourapp.id'): 
color 07
call cordova create dist %APP_ID% %APP_NAME%
:end
echo Done!
color 17
pause
color 07