/*
	Calculer les primes des employes en fonction de leur rank en matiere de CA sur une annee

	Afficher les deux meilleurs employes pour chaque mois de 2012
	| Mois | IdEmploye |Nom				    | CA     | Rank |

	-- Performance des employes sur le mois de janvier + rank 
	| 1    | 2         | Dominique			| 100000 | 1    |
	| 1    | 4         | Roger  			|  99000 | 2    |
	| 1    | 3         | Jacques			|  90000 | 3    |
	| 1    | 8         | Paul  			    |  88000 | 4    |
	
	
	| 2    | 2         | Dominique			| 110999 | 1    |
	| 2    | 7         | Pierre  			| 110100 | 2    |
	| 3    | 8         | Paul			    | 110999 | 1    |
	| 3    | 3         | Jacques  			|  90000 | 2    |

	1) Tables => Employes + Commandes + DetailsCommandes
	2) Mois => Generer 1 à 12
	3) Jointure
	4) Group by
	5) Rank
	6) Filtre 
*/