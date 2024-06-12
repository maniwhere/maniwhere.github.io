@echo off
setlocal enabledelayedexpansion

rem 遍历当前文件夹及其子文件夹中的所有 .mp4 文件
for /r %%i in (*.mp4) do (
    rem 获取文件名和目录
    set "input_file=%%i"
    set "output_file=%%i"

    rem 临时文件路径
    set "temp_file=%%~di%%~pi%%~ni_temp.mp4"

    rem 打印正在处理的文件路径
    echo Converting "!input_file!" to H.264 format...

    rem 使用 ffmpeg 转换为 H.264 编码格式并覆盖原文件
    ffmpeg -i "!input_file!" -c:v libx264 -y "!temp_file!"
    
    rem 检查转换是否成功
    if exist "!temp_file!" (
        move /Y "!temp_file!" "!output_file!"
        echo Conversion successful: "!output_file!"
    ) else (
        echo Conversion failed for: "!input_file!"
    )
)

endlocal
echo All conversions completed.
pause