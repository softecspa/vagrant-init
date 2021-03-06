vagrant-init
============

install all necessary to run vagrant guest

## procedura su Windows

* installare [Puppet](https://downloads.puppetlabs.com/windows/puppet-latest.msi)
* installare [Git per windows](https://github.com/msysgit/msysgit/releases/) lanciando il setup con i seguenti parametri:

        /COMPONENTS="icons,icons\desktop,ext,ext\cheetah,assoc,assoc_sh,consolefont"
    (chiudere eventuali finestre di explorer se vengono segnalati errori)
* aprire un prompt di puppet **con i privilegi di amministratore**
    * start -> Programmi -> Puppet -> Start command prompt with puppet (tasto destro, esegui come amministratore)


* eseguire i seguenti comandi:


        cd c:\
        git clone --recurse https://github.com/softecspa/vagrant-init vagrant-init
        cd vagrant-init
        puppet apply init.pp --modulepath=modules

Attendere finchè la procedura non sarà completata e chiudere il prompt.


### Pulizia
Se tutti i passi precedenti sono stati eseguiti correttamente è possibile eliminare la directory *c:\vagrant-init*

## Procedura su Linux (Ubuntu)
La seguente procedura è testata su Ubuntu Lucid 12.04

### installazione puppet
Scarichiamo ed installiamo il deb di puppetlabs relativo alla nostra distribuzione ed installiamo. Questo configurerà i repository di cui abbiamo bisogno.

    wget https://apt.puppetlabs.com/puppetlabs-release-$REALEASE_NAME.deb
    sudo dpkg -i puppetlabs-release-$RELEASE_NAME.deb
    sudo apt-get update
    sudo apt-get install puppet

Ad esempio, su Ubuntu Precise 12.04

    wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
    sudo dpkg -i puppetlabs-release-precise.deb
    sudo apt-get update
    sudo apt-get install puppet

### Installazione di git
Semplicemente

    sudo apt-get install git-core

### Configurazione della macchina locale
    cd ~
    git clone https://github.com/softecspa/vagrant-init.git vagrant-init
    cd vagrant-init
    sed -e s/--USERNAME--/$(whoami)/ -i init.pp
    sudo puppet apply init.pp --modulepath=modules
