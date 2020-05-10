# Terraform per creare un server windows 2016

Utilizza una subnet esistente e crea una istanza con una password data cambiando il nome windows.  
Il server deve eseguire un reboot dopo cambiato il nome per cui attendere 5 minuti dopo il deploy   


## Variabili da inserire in terraform.tfvars

**region** Region AWS in cui effetuare il deploy  
**nome** nome dell'istanza  
**app** Valore del tag app   
**tipo** tipo di istanza  
**password** password peer l'utente administrator da inserire  
**subnet** id della subnet in cui effettuare il deploy  
**root_size** Dimensione in GB del disco di root  
