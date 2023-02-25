cd /tmp
rm -rf nuveke
git clone --depth 1 --branch main https://github.com/roj1512/nuveke
cd nuveke
docker volume create nuveke-builder
docker compose build
docker compose up -d
docker compose cp builder:/app/nuveke nuveke
docker compose stop
mv nuveke /usr/bin
chmod +x /usr/bin/nuveke
echo "{}" > /etc/nuveke.json
echo "[Service]\nExecStart=/usr/bin/nuveke\n\n[Install]\nWantedBy=multi-user.target\n" > /etc/systemd/system/nuveke.service
systemctl daemon-reload
systemctl enable --now nuveke
