@echo off
setlocal enabledelayedexpansion

set "modname=##MOD_NAME##"
set "namespace=##MOD_NAMESPACE##"

echo Enter a Mod name and namespace. use the format ExampleMod for the name and Example.Mod for the namespace. 
echo Do not use spaces, numbers or special characters. The project might not load otherwise.
echo Enter the mod name(ex: ExampleMod):
set /p "replacename="
echo Enter the mod namespace(ex: Example.Mod):
set /p "replacenamespace="
move /y "%cd%\Assets\Scenes\ModNameScene.unity" "%cd%\Assets\Scenes\%replacename%Scene.unity"

call :process_file "%cd%\Assets\Scripts\ModName.asmdef.tmpl" "%cd%\Assets\Scripts\%replacename%.asmdef"
call :process_file "%cd%\Assets\Scripts\ModName.cs.tmpl" "%cd%\Assets\Scripts\%replacename%.cs"
call :process_file "%cd%\Assets\Scripts\patches\PrefabPatch.cs.tmpl" "%cd%\Assets\Scripts\patches\PrefabPatch.cs"
call :process_file "%cd%\Assets\About\About.xml.tmpl" "%cd%\Assets\About\About.xml"

echo Initialization complete!
del init.sh
del init.bat
endlocal
exit /b

:process_file
setlocal disabledelayedexpansion
set "input_file=%~1"
set "output_file=%~2"

if not exist "%input_file%" (
    echo File "%input_file%" not found!
    exit /b 1
)

(
    for /f "usebackq delims=" %%i in ("%input_file%") do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        set "line=!line:%modname%=%replacename%!"
        set "line=!line:%namespace%=%replacenamespace%!"
        echo.!line!
        endlocal
    )
) > "%output_file%"

del "%input_file%"
endlocal
exit /b