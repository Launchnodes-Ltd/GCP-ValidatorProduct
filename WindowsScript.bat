@echo off

set /p pemFilePath=Enter .pem file path:
set /p zipFilePath=Enter Validator Key zip file path:
set /p instanceCredential=Enter public IPv4 and external DNS hostname:

icacls.exe "%pemFilePath%" /reset
icacls.exe "%pemFilePath%" /GRANT:R "%USERNAME%:(R)"
icacls.exe "%pemFilePath%" /inheritance:r


scp -i %pemFilePath% -r %zipFilePath% %instanceCredential%:/home



ssh -i %pemFilePath% %instanceCredential%