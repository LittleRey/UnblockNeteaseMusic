C_VER="v1.0.3"
mkdir /caddybin
cd /caddybin
CADDY_URL="https://github.com/caddyserver/caddy/releases/download/$C_VER/caddy_${C_VER}_linux_amd64.tar.gz"
echo ${CADDY_URL}
wget --no-check-certificate -qO 'caddy.tar.gz' ${CADDY_URL}
tar xvf caddy.tar.gz
rm -rf caddy.tar.gz
chmod +x caddy


cat <<-EOF > /caddybin/Caddyfile
http://0.0.0.0:${PORT}
{
    proxy / localhost:8080
}
EOF

cd /usr/src/app
node app.js -p 8080 -o qq kuwo kugou joox &
cd /caddybin
./caddy -conf="Caddyfile"
