@echo off
setlocal enabledelayedexpansion

set "modname=##MOD_NAME##"
set "namespace=##MOD_NAMESPACE##"

echo Enter a Mod name and namespace. use the format ExampleMod for the name and Example.Mod for the namespace. 
echo Do not use spaces, numbers or special characters. The project might load be able to load otherwise.
echo Enter the mod name(ex: ExampleMod):
set /p "replacename="
echo Enter the mod namespace(ex: Example.Mod):
set /p "replacenamespace="
move /y "%cd%\Assets\Scenes\ModNameScene.unity" "%cd%\Assets\Scenes\%replacename%Scene.unity"

set "input_file=%cd%\Assets\Scripts\ModName.asmdef.tmpl"
set "output_file=%cd%\Assets\Scripts\%replacename%.asmdef"

if not exist "%input_file%" (
    echo File "%input_file%" not found!
    exit /b 1
)

(for /f "usebackq delims=" %%i in ("%input_file%") do (
    set "line=%%i"
    set "line=!line:%modname%=%replacename%!"
    set "line=!line:%namespace%=%replacenamespace%!"
    echo !line!
)) > "%output_file%"

del "%input_file%"



set "input_file=%cd%\Assets\Scripts\ModName.cs.tmpl"
set "output_file=%cd%\Assets\Scripts\%replacename%.cs"

if not exist "%input_file%" (
    echo File "%input_file%" not found!
    exit /b 1
)

(for /f "usebackq delims=" %%i in ("%input_file%") do (
    set "line=%%i"
    set "line=!line:%modname%=%replacename%!"
    set "line=!line:%namespace%=%replacenamespace%!"
    echo !line!
)) > "%output_file%"

del "%input_file%"


set "input_file=%cd%\Assets\Scripts\patches\PrefabPatch.cs.tmpl"
set "output_file=%cd%\Assets\Scripts\patches\PrefabPatch.cs"

if not exist "%input_file%" (
    echo File "%input_file%" not found!
    exit /b 1
)

(for /f "usebackq delims=" %%i in ("%input_file%") do (
    set "line=%%i"
    set "line=!line:%modname%=%replacename%!"
    set "line=!line:%namespace%=%replacenamespace%!"
    echo !line!
)) > "%output_file%"

del "%input_file%"


set "input_file=%cd%\Assets\About\About.xml.tmpl"
set "output_file=%cd%\Assets\About\About.xml"

if not exist "%input_file%" (
    echo File "%input_file%" not found!
    exit /b 1
)

(for /f "usebackq delims=" %%i in ("%input_file%") do (
    set "line=%%i"
    set "line=!line:%modname%=%replacename%!"
    set "line=!line:%namespace%=%replacenamespace%!"
    echo !line!
)) > "%output_file%"

del "%input_file%"

echo Initialization complete!
del init.sh
del init.bat
endlocal