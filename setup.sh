cat << "EOF"
  ______   __     __  ______  _______   __           
 /      \ |  \   |  \|      \|       \ |  \          
|  $$$$$$\| $$   | $$ \$$$$$$| $$$$$$$\| $$  _______ 
| $$  | $$| $$   | $$  | $$  | $$  | $$ \$  /       \
| $$  | $$ \$$\ /  $$  | $$  | $$  | $$    |  $$$$$$$
| $$  | $$  \$$\  $$   | $$  | $$  | $$     \$$    \ 
| $$__/ $$   \$$ $$   _| $$_ | $$__/ $$     _\$$$$$$\
 \$$    $$    \$$$   |   $$ \| $$    $$    |       $$
  \$$$$$$      \$     \$$$$$$ \$$$$$$$      \$$$$$$$ 
 __        __                                        
|  \      |  \                                       
| $$       \$$ _______   __    __  __    __          
| $$      |  \|       \ |  \  |  \|  \  /  \         
| $$      | $$| $$$$$$$\| $$  | $$ \$$\/  $$         
| $$      | $$| $$  | $$| $$  | $$  >$$  $$          
| $$_____ | $$| $$  | $$| $$__/ $$ /  $$$$\          
| $$     \| $$| $$  | $$ \$$    $$|  $$ \$$\         
 \$$$$$$$$ \$$ \$$   \$$  \$$$$$$  \$$   \$$         
 __       __  __              __                     
|  \     /  \|  \            |  \                    
| $$\   /  $$ \$$ _______   _| $$_                   
| $$$\ /  $$$|  \|       \ |   $$ \                  
| $$$$\  $$$$| $$| $$$$$$$\ \$$$$$$                  
| $$\$$ $$ $$| $$| $$  | $$  | $$ __                 
| $$ \$$$| $$| $$| $$  | $$  | $$|  \                
| $$  \$ | $$| $$| $$  | $$   \$$  $$                
 \$$      \$$ \$$ \$$   \$$    \$$$$                 
  ______               __                            
 /      \             |  \                           
|  $$$$$$\  ______   _| $$_    __    __   ______     
| $$___\$$ /      \ |   $$ \  |  \  |  \ /      \    
 \$$    \ |  $$$$$$\ \$$$$$$  | $$  | $$|  $$$$$$\   
 _\$$$$$$\| $$    $$  | $$ __ | $$  | $$| $$  | $$   
|  \__| $$| $$$$$$$$  | $$|  \| $$__/ $$| $$__/ $$   
 \$$    $$ \$$     \   \$$  $$ \$$    $$| $$    $$   
  \$$$$$$   \$$$$$$$    \$$$$   \$$$$$$ | $$$$$$$    
                                        | $$         
                                        | $$         
                                         \$$         
EOF

# text colors
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN} Step 1: Updating advanced package tool (apt)${NC}"

apt update
apt upgrade

echo -e "${CYAN} Step 2: Installing ansible${NC}"

apt install software-properties-common -y
sudo add-apt-repository --yes ppa:ansible/ansible
apt install ansible -y

echo -e "${CYAN} Step 3: Installing git${NC}"

echo Install git
apt install git-all -y

echo -e "${CYAN} Step 4: Running playbook using ansible-pull${NC}"

ansible-pull -U https://github.com/davidzenisu/devops-mint.git playbook.yml

if [ $? -ne 0 ]; then
    echo echo -e "${RED} Ansible Playbook failed! Please consult the log for additional infos.${NC}"
    exit 1
fi

echo -e "${CYAN} Step 5: Refreshing docker group to avoid restart${NC}"

newgrp docker

echo -e "${CYAN}"
cat << "EOF"
  ______   __    __   ______    ______   ________   ______    ______  
 /      \ |  \  |  \ /      \  /      \ |        \ /      \  /      \ 
|  $$$$$$\| $$  | $$|  $$$$$$\|  $$$$$$\| $$$$$$$$|  $$$$$$\|  $$$$$$\
| $$___\$$| $$  | $$| $$   \$$| $$   \$$| $$__    | $$___\$$| $$___\$$
 \$$    \ | $$  | $$| $$      | $$      | $$  \    \$$    \  \$$    \ 
 _\$$$$$$\| $$  | $$| $$   __ | $$   __ | $$$$$    _\$$$$$$\ _\$$$$$$\
|  \__| $$| $$__/ $$| $$__/  \| $$__/  \| $$_____ |  \__| $$|  \__| $$
 \$$    $$ \$$    $$ \$$    $$ \$$    $$| $$     \ \$$    $$ \$$    $$
  \$$$$$$   \$$$$$$   \$$$$$$   \$$$$$$  \$$$$$$$$  \$$$$$$   \$$$$$$        
EOF
echo -e "${NC}"
