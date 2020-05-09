# Terraform per la creazione di una VPC con 2 AZ solo pub

Terraform per la creazione di un VPC con due AZ  
Include:  
- VPC
- 2 Subnet (1 per AZ)
- 1 Internet Gateway
- 1 Route table Pubblica
- 1 NAT Gateway
- 1 EIP collegato al NAT Gateway

## Info per il deploy
Il cidr deve essere immesso con la netmask in bit  
Le subnet aumenteranno la maschera di 2 bit, usando le prime 2 classi.Il resto del vpc non verrà allocato  (quindi allocando solo la metà delle indirizzi disponibili nella VPN)

Es. **CIDR 172.31.0.0/20** (da 172.31.0.0 a 172.31.15.255)   
subnet pub 1 172.31.0.0/22 (da 172.31.0.0 a 172.31.3.255)  
subnet pub 1 172.31.4.0/22 (da 172.31.4.0 a 172.31.7.255)  
 
 
## Variabili Richieste da inserire in terraform.tfvars

**Env** nome del deploy che verrà usato per la VPC  
**CIDR** CIDR della VPC  
**region** region AWS dove effettuare il deploy  
