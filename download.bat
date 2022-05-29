@echo off

:start

cls

set /p link="Link: "

echo.

youtube-dl -f bestaudio[ext=m4a] --output "%%(artist)s - %%(title)s.%%(ext)s" --write-thumbnail --add-metadata --postprocessor-args "-id3v2_version 3" %link%

for %%a in (*.webp) do ren "%%a" "*.jpg"

for %%a in (*.jpg) do start imagemagick/convert.exe command "%%a" -crop 720x720+280+0 coverart.jpg

echo.

pause

for %%a in (*.m4a) do AtomicParsley "%%a" --artwork coverart.jpg --overWrite

for %%a in (*.m4a) do move "%%a" final/

del /s /q /f *.jpg

goto start