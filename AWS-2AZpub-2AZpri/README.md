# Terraform per la creazione di una VPC con 2 AZ pub e priv

Terraform per la creazione di un VPC con due AZ  
Include:  
- VPC
- 2 Subnet Pubbliche(1 per AZ)
- 2 Subnet Private (1 per AZ)
- 1 Internet Gateway
- 1 Route table Pubblica
- 2 NAT Gateway (uno pere AZ)
- 2 EIP collegato al NAT Gateway

## Info per il deploy
Il cidr deve essere immesso con la netmask in bit  
Le subnet aumenteranno la maschera di 3 bit, usando le prime 4 classi. Prime due private, le seconde pubbliche. Il resto del vpc non verrà allocato  (quindi allocando solo la metà delle subnet possibili)

Es. **CIDR 172.31.0.0/20** (da 172.31.0.0 a 172.31.15.255)   
subnet pub 1 172.31.0.0/22 (da 172.31.0.0 a 172.31.1.255)  
subnet pub 1 172.31.2.0/22 (da 172.31.2.0 a 172.31.3.255)  
subnet pub 1 172.31.4.0/22 (da 172.31.4.0 a 172.31.5.255)   
subnet pub 1 172.31.6.0/22 (da 172.31.6.0 a 172.31.7.255)  
 
**Env** nome del deploy che verrà usato per la VPC  
**CIDR** CIDR della VPC
**region** region AWS dove effettuare il deploy

 
