@echo off
echo #### Let's start installing everything you need. Ready? ###
color 17
pause
color 07
echo *** 1) Package management for some useful tools: go get Chocolatey from https://chocolatey.org/
:install_chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
:begin_install_unzip
echo *** 2) you need some form of the commandline unzip to do a later step as prescribed...
color 17
CHOICE /T 60 /C IS /D I /M "[I]nstall or [S]kip"
IF %ERRORLEVEL% NEQ 1 goto endof_install_unzip
color 07
echo You have the choice to install just the unzip app, or gnuwin which includes unzip and more
echo (gnuwin takes much longer to install)
color 17
CHOICE /T 60 /C ZG /D Z /M "[Z]ip only, or [G]nuwin (contains unzip)"
IF %ERRORLEVEL% EQU 0 goto end
IF %ERRORLEVEL% EQU 1 goto install_unzip
IF %ERRORLEVEL% EQU 2 goto install_gnuwin
:install_unzip
color 07
choco install devbox-unzip
echo *** Please check for errors above... Retry if you had errors...
color 17
CHOICE /T 60 /C RC /D C /M "[R]etry or [C]ontinue"
IF %ERRORLEVEL% EQU 1 goto install_unzip
goto endof_install_unzip
:install_gnuwin
color 07
choco install gnuwin
:endof_install_unzip
color 07
:begin_install_conemu
echo *** 3) you're going to spend some time in a console. You might as well get ConEmu:
ECHO    (and start using it, of course! ConEmu is prettier, properly resizable and does tabbing.)
color 17
CHOICE /T 60 /C IS /D I /M "[I]nstall or [S]kip"
IF %ERRORLEVEL% NEQ 1 goto endof_install_conemu
color 07
choco install conemu
:endof_install_conemu
color 07
:begin_install_git
echo *** 4) you need git for this
where git
IF %ERRORLEVEL% EQU 0 goto alreadygot_git
echo (or go install SourceTree, set up and allow it to download git and add that git to your path)
color 17
CHOICE /T 60 /C IS /D I /M "[I]nstall or [S]kip"
IF %ERRORLEVEL% NEQ 1 goto endof_install_git
color 07
choco install git
goto
:alreadygot_git
echo ...Awesome! You already have it!
:endof_install_git
color 07
echo ### Install Web Starter Kit pre-requisites... Ready? ###
color 17
pause
color 07
echo 1) install pre-requisites as per https://developers.google.com/web/fundamentals/tools/setup/setup_kit 
:begin_install_nodejs
echo - install nodejs
where node
IF %ERRORLEVEL% EQU 0 echo ...Awesome! You already have it!
IF %ERRORLEVEL% EQU 1 choco install nodejs.install
:endof_install_nodejs
:begin_install_ruby
echo - install ruby
where ruby
IF %ERRORLEVEL% EQU 0 echo ...Awesome! You already have it!
IF %ERRORLEVEL% EQU 1 choco install ruby1.9
:endof_install_ruby
:begin_install_sass
echo - install sass
call gem install sass
:endof_install_sass
:begin_install_gulp
echo - install gulp
call npm install -g gulp
:endof_install_gulp
:begin_install_cordova
echo - install cordova
call npm install -g cordova
:endof_install_cordova
:begin_install_androidSDK
echo - for android, let's get the SDK now (you can carry on with the rest as this comes down)
where android.bat
IF %ERRORLEVEL% EQU 0 echo ...Awesome! You already have it!
IF %ERRORLEVEL% EQU 1 choco install android-sdk
:endof_install_androidSDK
echo - this puts the Android SDK under %LOCALAPPDATA%\Android\android-sdk
echo     - in there, you can find the SDK Manager and the AVD Manager
echo     - you will need to add the tools folder to your path! Don't use setx for this
echo     as it does the WRONG thing if your PATH variable is longer than 1024 chars ):
echo     - when the Android SDK is in your path, you should be able to run:
echo     > where android
echo     and actually get a path back, not a line starting with "INFO"
:end
echo ...Goodbye... I'll open conemu for you... because it's awesome!
color 17
pause
color 07
"%ProgramFiles%\ConEmu\ConEmu64.exe"