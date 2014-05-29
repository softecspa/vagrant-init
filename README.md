vagrant-init
============

install all necessary to run vagrant guest

## procedura su Windows

 * installare [Puppet](https://downloads.puppetlabs.com/windows/puppet-3.6.1.msi)
 * installare [Git per windows](https://github.com/msysgit/msysgit/releases/download/Git-1.9.2-preview20140411/Git-1.9.2-preview20140411.exe)
 * aprire un prompt **con i privilegi di amministratore**
 * dare i seguenti comandi:
    * *cd c:\*
    * *git clone --recurse https://github.com/softecspa/vagrant-init vagrant-init*
    * *cd vagrant-init*
    * *puppet apply init.pp --modulepath=modules*
 * Attendere finchè la procedura non sarà completata
 * chiudere il prompt

La procedura dovrebbe aver creato una directory in *c:\vagrant-lamp*. Questa directory contiene tutto il necessario per avviare e configurare la nostra macchina

### Avviare la macchina

 * aprire un prompt, stavolta **senza i privilegi di amministratore**
 * *cd c:\vagrant-lamp*
 * *vagrant up*

