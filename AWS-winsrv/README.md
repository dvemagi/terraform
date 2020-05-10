# Terraform per creare un server windows 2016

Utilizza una subnet esistente e crea una istanza con una password data cambiando il nome windows

## Variafili da inserire in terraform.tfvars

**nome** nome dell'istanza. Verrà usato per tag Name e app
**tipo** tipo di istanza 
**password** password peer l'utente administrator da inserire
**subnet** id della subnet in cui effettuare il deploy
