@echo off
setlocal enabledelayedexpansion
color a

REM --- Tao duong dan file log truoc khi goi ham log ---
set "datetime=%date:~6,4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "datetime=%datetime: =0%"
set "logpath=%~dp0logs"
set "LOGFILE=%logpath%\conversion_log_%datetime%.txt"

REM Tao thu muc logs neu chua ton tai
if not exist "%logpath%" (
    mkdir "%logpath%" 2>nul
    if errorlevel 1 (
        echo Khong the tao thu muc logs. Vui long kiem tra quyen truy cap.
        pause
        exit /b 1
    )
)

REM --- Ham log da cai tien ---
:log
setlocal
if "%~1"=="." (
    echo.
    echo.>>"%LOGFILE%"
) else (
    echo %*
    echo %*>>"%LOGFILE%"
)
endlocal
exit /b

REM --- Bat dau chuong trinh ---
call :log ================================================
call :log == CHUONG TRINH CHUYEN DOI FILE VOI PANDOC ==
call :log ================================================
call :log.

REM Kiem tra Pandoc da duoc cai dat chua
where pandoc >nul 2>nul
if errorlevel 1 (
    call :log [LOI] Khong tim thay Pandoc. Vui long cai dat Pandoc truoc khi chay chuong trinh.
    call :log Tham khao: https://pandoc.org/installing.html
    pause
    exit /b 1
)

REM Yeu cau 1: Nhap duong dan thu muc nguon
:input_source_folder
call :log.
set "source_folder_path="
set /p "source_folder_path=Nhap duong dan den thu muc chua file can chuyen doi: "
call :log Duong dan nguon da nhap: "%source_folder_path%"

REM Kiem tra nguoi dung co nhap khong
if not defined source_folder_path (
    call :log [LOI] Ban chua nhap duong dan. Vui long nhap lai.
    goto input_source_folder
)

REM Loai bo dau ngoac kep thua
if "%source_folder_path:~0,1%"=="""" if "%source_folder_path:~-1%"=="""" (
    set "source_folder_path=%source_folder_path:~1,-1%"
)

REM Kiem tra thu muc nguon ton tai
if not exist "%source_folder_path%" (
    call :log [LOI] Thu muc nguon khong ton tai. Vui long nhap lai.
    goto input_source_folder
)

REM Kiem tra co phai la thu muc
if not exist "%source_folder_path%\*" (
    call :log [LOI] Duong dan khong phai la thu muc. Vui long nhap lai.
    goto input_source_folder
)

REM Dam bao duong dan ket thuc bang "\"
if not "%source_folder_path:~-1%"=="\" set "source_folder_path=%source_folder_path%\"

REM Yeu cau 2: Nhap duong dan thu muc dich
:input_destination_folder
call :log.
set "destination_folder_path="
set /p "destination_folder_path=Nhap duong dan thu muc de luu file da chuyen doi (Enter = thu muc hien tai): "
call :log Duong dan dich da nhap: "%destination_folder_path%"

if not defined destination_folder_path (
    set "destination_folder_path=%~dp0"
    call :log Se luu vao thu muc mac dinh: "%destination_folder_path%"
) else (
    if "%destination_folder_path:~0,1%"=="""" if "%destination_folder_path:~-1%"=="""" (
        set "destination_folder_path=%destination_folder_path:~1,-1%"
    )
    
    if not exist "%destination_folder_path%" (
        call :log Thu muc dich khong ton tai
        set /p "create_dest_folder=Tao thu muc moi? (Y/N): "
        if /i "!create_dest_folder!"=="Y" (
            mkdir "%destination_folder_path%" 2>nul
            if errorlevel 1 (
                call :log [LOI] Khong the tao thu muc. Kiem tra lai quyen va duong dan.
                goto input_destination_folder
            )
            call :log Da tao thu muc: "%destination_folder_path%"
        ) else (
            goto input_destination_folder
        )
    )
)

REM Dam bao duong dan dich ket thuc bang "\"
if not "%destination_folder_path:~-1%"=="\" set "destination_folder_path=%destination_folder_path%\"

REM Yeu cau 3: Chon kieu chuyen doi
call :log.
call :log Chon kieu chuyen doi:
call :log   1. Tat ca cac file
call :log   2. Chi file co duoi cu the (.md, .txt, ...)
set /p "choice=Lua chon (1/2): "
call :log Lua chon: %choice%

set "file_extensions="
if "%choice%"=="2" (
    set /p "file_extensions=Nhap cac duoi file (cach nhau bang dau phay, vi du: .md,.txt): "
    if not defined file_extensions (
        call :log [LOI] Chua nhap duoi file
        goto input_source_folder
    )
    call :log Cac duoi file se xu ly: %file_extensions%
) else if "%choice%" NEQ "1" (
    call :log [LOI] Lua chon khong hop le
    goto input_source_folder
)

REM Yeu cau 4: Chon dinh dang dau ra
call :log.
call :log Chon dinh dang dau ra:
call :log   1. PDF
call :log   2. DOCX
set /p "output_choice=Lua chon (1/2): "
call :log Lua chon dinh dang: %output_choice%

if "%output_choice%"=="1" (
    set "output_extension=.pdf"
) else if "%output_choice%"=="2" (
    set "output_extension=.docx"
) else (
    call :log [LOI] Lua chon khong hop le
    goto input_source_folder
)

REM Bat dau chuyen doi
call :log.
call :log ================================================
call :log BAT DAU CHUYEN DOI...
call :log Thu muc nguon: %source_folder_path%
call :log Thu muc dich: %destination_folder_path%
if "%choice%"=="2" call :log Xu ly cac file: %file_extensions%
call :log Dinh dang dau ra: %output_extension%
call :log ================================================

set "files_converted=0"
set "files_skipped=0"
set "files_failed=0"

if "%choice%"=="1" (
    REM Chuyen tat ca file
    for %%f in ("%source_folder_path%*.*") do (
        call :log Dang xu ly: "%%~nxf"
        pandoc "%%f" -s -o "%destination_folder_path%%%~nf%output_extension%"
        if !errorlevel! equ 0 (
            call :log   =^> OK: "%%~nf%output_extension%"
            set /a files_converted+=1
        ) else (
            call :log   =^> LOI: Ma loi !errorlevel!
            set /a files_failed+=1
        )
    )
) else (
    REM Chuyen theo duoi file
    for %%f in ("%source_folder_path%*.*") do (
        set "process_file=false"
        for %%e in (%file_extensions:,= %) do (
            if /i "%%~xf"=="%%e" set "process_file=true"
        )
        if "!process_file!"=="true" (
            call :log Dang xu ly: "%%~nxf"
            pandoc "%%f" -s -o "%destination_folder_path%%%~nf%output_extension%"
            if !errorlevel! equ 0 (
                call :log   =^> OK: "%%~nf%output_extension%"
                set /a files_converted+=1
            ) else (
                call :log   =^> LOI: Ma loi !errorlevel!
                set /a files_failed+=1
            )
        ) else (
            set /a files_skipped+=1
        )
    )
)

REM Bao cao ket qua
call :log.
call :log ================================================
call :log KET QUA CHUYEN DOI
call :log ================================================
call :log Thanh cong: %files_converted% file
call :log That bai: %files_failed% file
call :log Bo qua: %files_skipped% file
call :log Thu muc chua file ket qua: "%destination_folder_path%"
call :log File log: "%LOGFILE%"

call :log.
call :log Nhan phim bat ky de thoat...
pause > nul
endlocal
exit /b