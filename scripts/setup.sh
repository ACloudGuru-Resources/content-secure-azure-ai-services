#!/bin/sh
sudo apt-get clean
sudo rm -r /var/lib/apt/lists/*
sudo apt-get clean

sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update -y -o Acquire::Retries=3 | tee /tmp/update-output.txt && sudo apt-get install python3-pip -y

pip3 install azure-core==1.29.6
pip3 install azure-identity==1.10.0
pip3 install azure-keyvault-secrets==4.4.0
pip3 install azure-ai-textanalytics==5.3.0

cd /home/cloud_user/
git clone "https://github.com/ACloudGuru-Resources/content-secure-azure-ai-services.git"
mv "content-secure-azure-ai-services" "code"

sed -i "s,azurecognitiveservicesendpoint,$1,g" ./code/text_analytics.py
sed -i "s,azurecognitiveserviceskey,$2,g" ./code/text_analytics.py

git clone https://github.com/scopatz/nanorc.git /home/cloud_user/.nano
echo "include /home/cloud_user/.nano/*.nanorc" >> /home/cloud_user/.nanorc

sudo chown -R cloud_user /home/cloud_user/
