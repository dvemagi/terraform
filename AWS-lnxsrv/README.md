# Terraform per creare un server Amazon Linux 2

Utilizza una subnet esistente e crea una istanza   

## Variabili da inserire in terraform.tfvars

**region** Region AWS in cui effetuare il deploy  
**nome** nome dell'istanza  
**app** Valore del tag app   
**tipo** tipo di istanza  
**keyname** nome del keypair da usare per l'autenticazionee
**subnet** id della subnet in cui effettuare il deploy  
**root_size** Dimensione in GB del disco di root  
