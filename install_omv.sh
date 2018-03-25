#!/bin/bash

# ========[ IMPORTANTE ]=====================================================
# Não instalar os pacotes do Apache, PHP ou MySQL antes pois dará conflito
# e a instalação não será possível
# ===========================================================================

# Cria o arquivo vazio para inserir a lista com os repositórios
#touch /etc/apt/source.list/omv.list < deb packages.openmediavault.org/public kralizec main
> /etc/apt/sources.list.d/openmediavault.list

echo deb http://packages.openmediavault.org/public erasmus main >> /etc/apt/sources.list.d/openmediavault.list
echo \# deb http://downloads.sourceforge.net/project/openmediavault/packages erasmus main >> /etc/apt/sources.list.d/openmediavault.list
echo \## Uncomment the following line to add software from the proposed repository. >> /etc/apt/sources.list.d/openmediavault.list
echo \# deb http://packages.openmediavault.org/public erasmus-proposed main >> /etc/apt/sources.list.d/openmediavault.list
echo \# deb http://downloads.sourceforge.net/project/openmediavault/packages erasmus-proposed main >> /etc/apt/sources.list.d/openmediavault.list
echo \#\# This software is not part of OpenMediaVault, but is offered by third-party >> /etc/apt/sources.list.d/openmediavault.list
echo \#\# developers as a service to OpenMediaVault users. >> /etc/apt/sources.list.d/openmediavault.list
echo \# deb http://packages.openmediavault.org/public erasmus partner >> /etc/apt/sources.list.d/openmediavault.list
echo \# deb http://downloads.sourceforge.net/project/openmediavault/packages erasmus partner >> /etc/apt/sources.list.d/openmediavault.list

export LANG=C
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=none

#apt-get update

apt-get install openmediavault-keyring

apt-get update

# Instala os pacotes compat�veis com o Allwiner A20 (Armbian)
apt-get --yes --force-yes --fix-missing --auto-remove --allow-unauthenticated \
  --show-upgraded --option Dpkg::Options::="--force-confdef" \
  --option DPkg::Options::="--force-confold" --no-install-recommends \
  install openmediavault

# Trecho copiado do forum:
# https://forum.openmediavault.org/index.php/Thread/12775-Install-OMV3-on-Cubox-i/
# Todos os créditos e meu agradecimento ao autor do tópico: votdev



# Update.

#apt-get update

# Install the OpenMediaVault repository key and Postfix.
#apt-get install openmediavault-keyring postfix

#** When the 'Postfix Configuration' dialogue is displayed choose No configuration. **

#Update again and install OpenMediaVault.

#apt-get update
#apt-get install openmediavault

# ** When the 'Configuring mdadm' dialogue is displayed enter none.
# Do you want to start MD arrays automatically? YES
# When the 'ProFTPD configuration' dialogue is displayed choose standalone. **

# Initialise OpenMediaVault and reboot.
#omv-initsystem

# Trecho copiado do forum:
# https://forum.openmediavault.org/index.php/Thread/5632-How-to-install-OpenMediavault-virtualmin-and-zoneminder-on-debian-7/
# Todos os créditos e meu agradecimento ao autor do tópico: m3lvm
