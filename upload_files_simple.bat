@echo off
echo ===========================================
echo Uploading files to Cloudflare R2
echo ===========================================

cd /d "C:\Users\user\Desktop\DBServer\TEST\EduMate"

echo.
echo Uploading lecture images...
for %%f in (src\main\webapp\resources\images\lecture\*.jpg) do (
    echo Uploading %%f...
    curl -X PUT "https://api.cloudflare.com/client/v4/accounts/YOUR_ACCOUNT_ID/r2/buckets/edumate-files/objects/lecture/images/%%~nxf" ^
    -H "Authorization: Bearer YOUR_API_TOKEN" ^
    -H "Content-Type: image/jpeg" ^
    --data-binary @"%%f"
)

echo.
echo Uploading video files...
for %%f in (src\main\webapp\resources\videos\lecture\*.mp4) do (
    echo Uploading %%f...
    curl -X PUT "https://api.cloudflare.com/client/v4/accounts/YOUR_ACCOUNT_ID/r2/buckets/edumate-files/objects/lecture/videos/%%~nxf" ^
    -H "Authorization: Bearer YOUR_API_TOKEN" ^
    -H "Content-Type: video/mp4" ^
    --data-binary @"%%f"
)

echo.
echo Upload completed!
pause