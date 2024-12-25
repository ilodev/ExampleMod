#!/bin/bash

modname="##MOD_NAME##"
namespace="##MOD_NAMESPACE##"

echo "Enter a Mod name and namespace. Use the format ExampleMod for the name and Example.Mod for the namespace."
echo "Do not use spaces, numbers, or special characters. The project might not be able to load otherwise."
read -p "Enter the mod name (ex: ExampleMod): " replacename
read -p "Enter the mod namespace (ex: Example.Mod): " replacenamespace

mv "Assets/Scenes/ModNameScene.unity" "Assets/Scenes/${replacename}Scene.unity"

input_file="Assets/Scripts/ModName.asmdef.tmpl"
output_file="Assets/Scripts/${replacename}.asmdef"

if [ ! -f "$input_file" ]; then
    echo "File $input_file not found!"
    exit 1
fi

while IFS= read -r line; do
    line="${line//$modname/$replacename}"
    line="${line//$namespace/$replacenamespace}"
    echo "$line"
done < "$input_file" > "$output_file"

rm "$input_file"

input_file="Assets/Scripts/ModName.cs.tmpl"
output_file="Assets/Scripts/${replacename}.cs"

if [ ! -f "$input_file" ]; then
    echo "File $input_file not found!"
    exit 1
fi

while IFS= read -r line; do
    line="${line//$modname/$replacename}"
    line="${line//$namespace/$replacenamespace}"
    echo "$line"
done < "$input_file" > "$output_file"

rm "$input_file"

input_file="Assets/Scripts/patches/PrefabPatch.cs.tmpl"
output_file="Assets/Scripts/patches/PrefabPatch.cs"

if [ ! -f "$input_file" ]; then
    echo "File $input_file not found!"
    exit 1
fi

while IFS= read -r line; do
    line="${line//$modname/$replacename}"
    line="${line//$namespace/$replacenamespace}"
    echo "$line"
done < "$input_file" > "$output_file"

rm "$input_file"

input_file="Assets/About/About.xml.tmpl"
output_file="Assets/About/About.xml"

if [ ! -f "$input_file" ]; then
    echo "File $input_file not found!"
    exit 1
fi

while IFS= read -r line; do
    line="${line//$modname/$replacename}"
    line="${line//$namespace/$replacenamespace}"
    echo "$line"
done < "$input_file" > "$output_file"

rm "$input_file"
rm "init.bat"

echo "Initialization complete!"
rm "$0"
