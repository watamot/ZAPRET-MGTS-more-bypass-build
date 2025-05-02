@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
call service_status.bat zapret
call check_updates.bat soft
echo:

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"

start "zapret: general" /min "%BIN%winws.exe" --wf-tcp=80,8393-8400,2099,443,5222,5223,5228,5795-5847 --wf-udp=443,5222,5223,5228,5795-5847,50000-50100,9000-9002 ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split2 --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake,split2 --new ^
--filter-l3=ipv4 --filter-tcp=443 --dpi-desync=fake,split2 ^
--filter-tcp=443 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --dpi-desync-repeats=6 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-udp=443 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-udp=5000-5500 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --new ^
--filter-tcp=2099 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --new ^
--filter-tcp=5222 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --new ^
--filter-tcp=5223 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --new ^
--filter-udp=80,443,5222,5223,5228,5795-5847 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --new ^
--filter-udp=9200-9300 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=443,5222-5228,9000-9002 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --new ^
--filter-udp=3478-3479,9000-9002 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake --new ^