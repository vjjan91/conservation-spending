# Script that is used to post-processed-grants-for-analysis-unique-categories-only

# We take the data_bio dataframe to start this process
data.unique <- data_bio

#### Threats

#### >2 category grants (threat_other)

threat_other <- data.unique %>% 
  mutate(sum_threat = cat_threat_climate + cat_threat_energytransport + 
           cat_threat_habitat + cat_threat_inv_spec + cat_threat_overexp + 
           cat_threat_pollution) %>%
  filter(sum_threat >2)

#### Adding 2-threat categories and other

data.unique <- data.unique %>%
  mutate(cat_threat_climate_energytransport = 0,
         cat_threat_climate_habitat = 0,
         cat_threat_climate_inv_spec = 0,
         cat_threat_climate_overexp = 0,
         cat_threat_climate_pollution = 0,
         cat_threat_energytransport_habitat = 0,
         cat_threat_energytransport_inv_spec = 0,
         cat_threat_energytransport_overexp = 0,
         cat_threat_energytransport_pollution = 0,
         cat_threat_habitat_inv_spec = 0,
         cat_threat_habitat_overexp = 0,
         cat_threat_habitat_pollution = 0,
         cat_threat_inv_spec_overexp = 0,
         cat_threat_inv_spec_pollution = 0,
         cat_threat_overexp_pollution = 0,
         cat_threat_other = 0)

#### Filling Mulitple Threat cells ####

## Other Threats (>2 Categories)
for(i in 1:nrow(data.unique)){
  if(sum(data.unique[i,37:42]) > 2) {
    data.unique$cat_threat_other[i] = 1
    data.unique[i, 37:42] = 0
  }
}

## Climate + Energy/Transportation
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_climate[i]==1 & data.unique$cat_threat_energytransport[i]==1) {
    data.unique$cat_threat_climate_energytransport[i]=1}
  if(data.unique$cat_threat_climate_energytransport[i]==1) {
    data.unique$cat_threat_climate[i]=0
    data.unique$cat_threat_energytransport[i]=0
  }
}

## Climate + Habitat
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_climate[i]==1 & data.unique$cat_threat_habitat[i]==1) {
    data.unique$cat_threat_climate_habitat[i]=1}
  if(data.unique$cat_threat_climate_habitat[i]==1) {
    data.unique$cat_threat_climate[i]=0
    data.unique$cat_threat_habitat[i]=0
  }
}

## Climate + Invasive Species
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_climate[i]==1 & data.unique$cat_threat_inv_spec[i]==1) {
    data.unique$cat_threat_climate_inv_spec[i]=1}
  if(data.unique$cat_threat_climate_inv_spec[i]==1) {
    data.unique$cat_threat_climate[i]=0
    data.unique$cat_threat_inv_spec[i]=0
  }
}

## Climate + Overexploitation
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_climate[i]==1 & data.unique$cat_threat_overexp[i]==1) {
    data.unique$cat_threat_climate_overexp[i]=1}
  if(data.unique$cat_threat_climate_overexp[i]==1) {
    data.unique$cat_threat_climate[i]=0
    data.unique$cat_threat_overexp[i]=0
  }
}

## Climate + Pollution
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_climate[i]==1 & data.unique$cat_threat_pollution[i]==1) {
    data.unique$cat_threat_climate_pollution[i]=1}
  if(data.unique$cat_threat_climate_pollution[i]==1) {
    data.unique$cat_threat_climate[i]=0
    data.unique$cat_threat_pollution[i]=0
  }
}

## Energy/Transportation + Habitat
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_energytransport[i]==1 & data.unique$cat_threat_habitat[i]==1) {
    data.unique$cat_threat_energytransport_habitat[i]=1}
  if(data.unique$cat_threat_energytransport_habitat[i]==1) {
    data.unique$cat_threat_energytransport[i]=0
    data.unique$cat_threat_habitat[i]=0
  }
}

## Energy/Transportation + Invasive Species
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_energytransport[i]==1 & data.unique$cat_threat_inv_spec[i]==1) {
    data.unique$cat_threat_energytransport_inv_spec[i]=1}
  if(data.unique$cat_threat_energytransport_inv_spec[i]==1) {
    data.unique$cat_threat_energytransport[i]=0
    data.unique$cat_threat_inv_spec[i]=0
  }
}

## Energy/Transportation + Overexploitation
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_energytransport[i]==1 & data.unique$cat_threat_overexp[i]==1) {
    data.unique$cat_threat_energytransport_overexp[i]=1}
  if(data.unique$cat_threat_energytransport_overexp[i]==1) {
    data.unique$cat_threat_energytransport[i]=0
    data.unique$cat_threat_overexp[i]=0
  }
}

## Energy/Transportation + Pollution
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_energytransport[i]==1 & data.unique$cat_threat_pollution[i]==1) {
    data.unique$cat_threat_energytransport_pollution[i]=1}
  if(data.unique$cat_threat_energytransport_pollution[i]==1) {
    data.unique$cat_threat_energytransport[i]=0
    data.unique$cat_threat_pollution[i]=0
  }
}

## Habitat + Invasive Species
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_habitat[i]==1 & data.unique$cat_threat_inv_spec[i]==1) {
    data.unique$cat_threat_habitat_inv_spec[i]=1}
  if(data.unique$cat_threat_habitat_inv_spec[i]==1) {
    data.unique$cat_threat_habitat[i]=0
    data.unique$cat_threat_inv_spec[i]=0
  }
}

## Habitat + Overexploitation
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_habitat[i]==1 & data.unique$cat_threat_overexp[i]==1) {
    data.unique$cat_threat_habitat_overexp[i]=1}
  if(data.unique$cat_threat_habitat_overexp[i]==1) {
    data.unique$cat_threat_habitat[i]=0
    data.unique$cat_threat_overexp[i]=0
  }
}

## Habitat + Pollution
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_habitat[i]==1 & data.unique$cat_threat_pollution[i]==1) {
    data.unique$cat_threat_habitat_pollution[i]=1}
  if(data.unique$cat_threat_habitat_pollution[i]==1) {
    data.unique$cat_threat_habitat[i]=0
    data.unique$cat_threat_pollution[i]=0
  }
}

## Invasive Species + Overexploitation
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_inv_spec[i]==1 & data.unique$cat_threat_overexp[i]==1) {
    data.unique$cat_threat_inv_spec_overexp[i]=1}
  if(data.unique$cat_threat_inv_spec_overexp[i]==1) {
    data.unique$cat_threat_inv_spec[i]=0
    data.unique$cat_threat_overexp[i]=0
  }
}

## Invasive Species + Pollution
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_inv_spec[i]==1 & data.unique$cat_threat_pollution[i]==1) {
    data.unique$cat_threat_inv_spec_pollution[i]=1}
  if(data.unique$cat_threat_inv_spec_pollution[i]==1) {
    data.unique$cat_threat_inv_spec[i]=0
    data.unique$cat_threat_pollution[i]=0
  }
}

## Overexploitation + Pollution
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_threat_overexp[i]==1 & data.unique$cat_threat_pollution[i]==1) {
    data.unique$cat_threat_overexp_pollution[i]=1}
  if(data.unique$cat_threat_overexp_pollution[i]==1) {
    data.unique$cat_threat_overexp[i]=0
    data.unique$cat_threat_pollution[i]=0
  }
}

#### Habitat categories

hab <- data.unique[,c(1:10,22:28)]

# Marine-Terrestrial
for(i in 1:nrow(hab)){
  if(hab$cat_habitat_marine[i]==1 & hab$cat_habitat_terrestrial[i]==1) {
    hab$cat_habitat_MarineTerrestrial[i]=1}
  if(hab$cat_habitat_MarineTerrestrial[i] == 1) {
    hab$cat_habitat_marine[i]=0
    hab$cat_habitat_terrestrial[i]=0
  }
}

# Marine-Freshwater
for(i in 1:nrow(hab)){
  if(hab$cat_habitat_marine[i]==1 & hab$cat_habitat_freshwater[i]==1) {
    hab$cat_habitat_FreshwaterMarine[i]=1}
  if(hab$cat_habitat_FreshwaterMarine[i] == 1) {
    hab$cat_habitat_marine[i]=0
    hab$cat_habitat_freshwater[i]=0
  }
}

# Freshwater-Terrestrial  
for(i in 1:nrow(hab)){
  if(hab$cat_habitat_terrestrial[i]==1 & hab$cat_habitat_freshwater[i]==1) {
    hab$cat_habitat_FreshwaterTerrestrial[i]=1}
  if(hab$cat_habitat_FreshwaterTerrestrial[i] == 1) {
    hab$cat_habitat_terrestrial[i]=0
    hab$cat_habitat_freshwater[i]=0
  }
}

# Habitat other (>2 categories)
for(i in 1:nrow(hab)){
  if(sum(hab[i,c(11:15,17)]) > 1){
    hab$cat_habitat_other[i] = 1
    hab[i, c(11:15,17)] = 0
  }
}

# If hab_other, no other habitat classification
for(i in 1:nrow(hab)){
  if(hab$cat_habitat_other[i]==1) {
    hab[i,c(11:15,17)] = 0
  }
}  

### Join filtered habitat columns with original data
data.unique[,22:28] <- hab[,11:17]

#### Bio categories
data.unique <- data.unique %>%
  mutate(cat_bio_ecosys_species = 0)

for(i in 1:nrow(data.unique)){
  if(data.unique$cat_bio_ecosys[i]==1 & data.unique$cat_bio_species[i]==1) {
    data.unique$cat_bio_ecosys_species[i]=1
    data.unique$cat_bio_ecosys[i]=0
    data.unique$cat_bio_species[i]=0
  }
}

#### Action Categories
## Adding 2-action categories and other
data.unique <- data.unique %>%
  mutate(cat_act_area_comm = 0,
         cat_act_area_edu = 0,
         cat_act_area_funding = 0,
         cat_act_area_policy = 0,
         cat_act_area_research = 0,
         cat_act_area_restor = 0,
         cat_act_community_edu = 0,
         cat_act_community_funding = 0,
         cat_act_community_policy = 0,
         cat_act_community_research = 0,
         cat_act_community_restor = 0,
         cat_act_edu_funding = 0,
         cat_act_edu_policy = 0,
         cat_act_edu_research = 0,
         cat_act_edu_restor = 0,
         cat_act_funding_policy = 0,
         cat_act_funding_research = 0,
         cat_act_funding_restor = 0,
         cat_act_policy_research = 0,
         cat_act_policy_restor = 0,
         cat_act_research_restor = 0,
         cat_act_other = 0)

#### Filling Multiple Action cells ####

## Other Actions (>2 classifications)
for(i in 1:nrow(data.unique)) {
  if(sum(data.unique[i,11:17]) > 2) {
    data.unique$cat_act_other[i] = 1
    data.unique[i,11:17] = 0
  }
}

## Area + Community
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_area[i]==1 & data.unique$cat_act_community[i]==1) {
    data.unique$cat_act_area_comm[i]=1}
  if(data.unique$cat_act_area_comm[i]==1) {
    data.unique$cat_act_area[i]=0
    data.unique$cat_act_community[i]=0
  }
}

## Area + Education
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_area[i]==1 & data.unique$cat_act_edu[i]==1) {
    data.unique$cat_act_area_edu[i]=1}
  if(data.unique$cat_act_area_edu[i]==1) {
    data.unique$cat_act_area[i]=0
    data.unique$cat_act_edu[i]=0
  }
}

## Area + Funding
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_area[i]==1 & data.unique$cat_act_funding[i]==1) {
    data.unique$cat_act_area_funding[i]=1}
  if(data.unique$cat_act_area_funding[i]==1) {
    data.unique$cat_act_area[i]=0
    data.unique$cat_act_funding[i]=0
  }
}

## Area + Policy
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_area[i]==1 & data.unique$cat_act_policy[i]==1) {
    data.unique$cat_act_area_policy[i]=1}
  if(data.unique$cat_act_area_policy[i]==1) {
    data.unique$cat_act_area[i]=0
    data.unique$cat_act_policy[i]=0
  }
}

## Area + Research
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_area[i]==1 & data.unique$cat_act_research[i]==1) {
    data.unique$cat_act_area_research[i]=1}
  if(data.unique$cat_act_area_research[i]==1) {
    data.unique$cat_act_area[i]=0
    data.unique$cat_act_research[i]=0
  }
}

## Area + Restoration
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_area[i]==1 & data.unique$cat_act_restor[i]==1) {
    data.unique$cat_act_area_restor[i]=1}
  if(data.unique$cat_act_area_restor[i]==1) {
    data.unique$cat_act_area[i]=0
    data.unique$cat_act_restor[i]=0
  }
}

## Community + Education
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_community[i]==1 & data.unique$cat_act_edu[i]==1) {
    data.unique$cat_act_community_edu[i]=1}
  if(data.unique$cat_act_community_edu[i]==1) {
    data.unique$cat_act_community[i]=0
    data.unique$cat_act_edu[i]=0
  }
}

## Community + Funding
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_community[i]==1 & data.unique$cat_act_funding[i]==1) {
    data.unique$cat_act_community_funding[i]=1}
  if(data.unique$cat_act_community_funding[i]==1) {
    data.unique$cat_act_community[i]=0
    data.unique$cat_act_funding[i]=0
  }
}

## Community + Policy
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_community[i]==1 & data.unique$cat_act_policy[i]==1) {
    data.unique$cat_act_community_policy[i]=1}
  if(data.unique$cat_act_community_policy[i]==1) {
    data.unique$cat_act_community[i]=0
    data.unique$cat_act_policy[i]=0
  }
}

## Community + Research
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_community[i]==1 & data.unique$cat_act_research[i]==1) {
    data.unique$cat_act_community_research[i]=1}
  if(data.unique$cat_act_community_research[i]==1) {
    data.unique$cat_act_community[i]=0
    data.unique$cat_act_research[i]=0
  }
}

## Community + Restoration
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_community[i]==1 & data.unique$cat_act_restor[i]==1) {
    data.unique$cat_act_community_restor[i]=1}
  if(data.unique$cat_act_community_restor[i]==1) {
    data.unique$cat_act_community[i]=0
    data.unique$cat_act_restor[i]=0
  }
}

## Education + Funding
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_edu[i]==1 & data.unique$cat_act_funding[i]==1) {
    data.unique$cat_act_edu_funding[i]=1}
  if(data.unique$cat_act_edu_funding[i]==1) {
    data.unique$cat_act_edu[i]=0
    data.unique$cat_act_funding[i]=0
  }
}

## Education + Policy
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_edu[i]==1 & data.unique$cat_act_policy[i]==1) {
    data.unique$cat_act_edu_policy[i]=1}
  if(data.unique$cat_act_edu_policy[i]==1) {
    data.unique$cat_act_edu[i]=0
    data.unique$cat_act_policy[i]=0
  }
}

## Education + Research
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_edu[i]==1 & data.unique$cat_act_research[i]==1) {
    data.unique$cat_act_edu_research[i]=1}
  if(data.unique$cat_act_edu_research[i]==1) {
    data.unique$cat_act_edu[i]=0
    data.unique$cat_act_research[i]=0
  }
}

## Education + Restoration
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_edu[i]==1 & data.unique$cat_act_restor[i]==1) {
    data.unique$cat_act_edu_restor[i]=1}
  if(data.unique$cat_act_edu_restor[i]==1) {
    data.unique$cat_act_edu[i]=0
    data.unique$cat_act_restor[i]=0
  }
}

## Funding + Policy
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_funding[i]==1 & data.unique$cat_act_policy[i]==1) {
    data.unique$cat_act_funding_policy[i]=1}
  if(data.unique$cat_act_funding_policy[i]==1) {
    data.unique$cat_act_funding[i]=0
    data.unique$cat_act_policy[i]=0
  }
}

## Funding + Research
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_funding[i]==1 & data.unique$cat_act_research[i]==1) {
    data.unique$cat_act_funding_research[i]=1}
  if(data.unique$cat_act_funding_research[i]==1) {
    data.unique$cat_act_funding[i]=0
    data.unique$cat_act_research[i]=0
  }
}

## Funding + Restoration
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_funding[i]==1 & data.unique$cat_act_restor[i]==1) {
    data.unique$cat_act_funding_restor[i]=1}
  if(data.unique$cat_act_funding_restor[i]==1) {
    data.unique$cat_act_funding[i]=0
    data.unique$cat_act_restor[i]=0
  }
}

## Policy + Research
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_policy[i]==1 & data.unique$cat_act_research[i]==1) {
    data.unique$cat_act_policy_research[i]=1}
  if(data.unique$cat_act_policy_research[i]==1) {
    data.unique$cat_act_policy[i]=0
    data.unique$cat_act_research[i]=0
  }
}

## Policy + Restoration
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_policy[i]==1 & data.unique$cat_act_restor[i]==1) {
    data.unique$cat_act_policy_restor[i]=1}
  if(data.unique$cat_act_policy_restor[i]==1) {
    data.unique$cat_act_policy[i]=0
    data.unique$cat_act_restor[i]=0
  }
}

## Research + Restoration
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_act_research[i]==1 & data.unique$cat_act_restor[i]==1) {
    data.unique$cat_act_research_restor[i]=1}
  if(data.unique$cat_act_research_restor[i]==1) {
    data.unique$cat_act_research[i]=0
    data.unique$cat_act_restor[i]=0
  }
}

#### Taxa categories
## Adding 2-taxa categories and other
data.unique <- data.unique %>%
  mutate(cat_taxa_amphibian_bird = 0,
         cat_taxa_amphibian_fish = 0,
         cat_taxa_amphibian_invertebrate = 0,
         cat_taxa_amphibian_mammal = 0,
         cat_taxa_amphibian_plant = 0,
         cat_taxa_amphibian_reptile = 0,
         cat_taxa_bird_fish = 0,
         cat_taxa_bird_invertebrate = 0,
         cat_taxa_bird_mammal = 0,
         cat_taxa_bird_plant = 0,
         cat_taxa_bird_reptile = 0,
         cat_taxa_fish_invertebrate = 0,
         cat_taxa_fish_mammal = 0,
         cat_taxa_fish_plant = 0,
         cat_taxa_fish_reptile = 0,
         cat_taxa_invertebrate_mammal = 0,
         cat_taxa_invertebrate_plant = 0,
         cat_taxa_invertebrate_reptile = 0,
         cat_taxa_mammal_plant = 0,
         cat_taxa_mammal_reptile = 0,
         cat_taxa_plant_reptile = 0,
         cat_taxa_other = 0)

#### Filling Multiple Taxa cells ####

## Other Taxa (>2 classifications)
for(i in 1:nrow(data.unique)) {
  if(sum(data.unique[i,30:36]) > 2) {
    data.unique$cat_taxa_other[i] = 1
    data.unique[i,30:36] = 0
  }
}

## amphibian + bird
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_amphibian[i]==1 & data.unique$cat_taxa_bird[i]==1) {
    data.unique$cat_taxa_amphibian_bird[i]=1}
  if(data.unique$cat_taxa_amphibian_bird[i]==1) {
    data.unique$cat_taxa_amphibian[i]=0
    data.unique$cat_taxa_bird[i]=0
  }
}

## amphibian + fish
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_amphibian[i]==1 & data.unique$cat_taxa_fish[i]==1) {
    data.unique$cat_taxa_amphibian_fish[i]=1}
  if(data.unique$cat_taxa_amphibian_fish[i]==1) {
    data.unique$cat_taxa_amphibian[i]=0
    data.unique$cat_taxa_fish[i]=0
  }
}

## amphibian + invertebrate
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_amphibian[i]==1 & data.unique$cat_taxa_invertebrate[i]==1) {
    data.unique$cat_taxa_amphibian_invertebrate[i]=1}
  if(data.unique$cat_taxa_amphibian_invertebrate[i]==1) {
    data.unique$cat_taxa_amphibian[i]=0
    data.unique$cat_taxa_invertebrate[i]=0
  }
}

## amphibian + mammal
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_amphibian[i]==1 & data.unique$cat_taxa_mammal[i]==1) {
    data.unique$cat_taxa_amphibian_mammal[i]=1}
  if(data.unique$cat_taxa_amphibian_mammal[i]==1) {
    data.unique$cat_taxa_amphibian[i]=0
    data.unique$cat_taxa_mammal[i]=0
  }
}

## amphibian + plant
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_amphibian[i]==1 & data.unique$cat_taxa_plant[i]==1) {
    data.unique$cat_taxa_amphibian_plant[i]=1}
  if(data.unique$cat_taxa_amphibian_plant[i]==1) {
    data.unique$cat_taxa_amphibian[i]=0
    data.unique$cat_taxa_plant[i]=0
  }
}

## amphibian + reptile
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_amphibian[i]==1 & data.unique$cat_taxa_reptile[i]==1) {
    data.unique$cat_taxa_amphibian_reptile[i]=1}
  if(data.unique$cat_taxa_amphibian_reptile[i]==1) {
    data.unique$cat_taxa_amphibian[i]=0
    data.unique$cat_taxa_reptile[i]=0
  }
}

## bird + fish
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_bird[i]==1 & data.unique$cat_taxa_fish[i]==1) {
    data.unique$cat_taxa_bird_fish[i]=1}
  if(data.unique$cat_taxa_bird_fish[i]==1) {
    data.unique$cat_taxa_bird[i]=0
    data.unique$cat_taxa_fish[i]=0
  }
}

## bird + invertebrate
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_bird[i]==1 & data.unique$cat_taxa_invertebrate[i]==1) {
    data.unique$cat_taxa_bird_invertebrate[i]=1}
  if(data.unique$cat_taxa_bird_invertebrate[i]==1) {
    data.unique$cat_taxa_bird[i]=0
    data.unique$cat_taxa_invertebrate[i]=0
  }
}

## bird + mammal
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_bird[i]==1 & data.unique$cat_taxa_mammal[i]==1) {
    data.unique$cat_taxa_bird_mammal[i]=1}
  if(data.unique$cat_taxa_bird_mammal[i]==1) {
    data.unique$cat_taxa_bird[i]=0
    data.unique$cat_taxa_mammal[i]=0
  }
}

## bird + plant
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_bird[i]==1 & data.unique$cat_taxa_plant[i]==1) {
    data.unique$cat_taxa_bird_plant[i]=1}
  if(data.unique$cat_taxa_bird_plant[i]==1) {
    data.unique$cat_taxa_bird[i]=0
    data.unique$cat_taxa_plant[i]=0
  }
}

## bird + reptile
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_bird[i]==1 & data.unique$cat_taxa_reptile[i]==1) {
    data.unique$cat_taxa_bird_reptile[i]=1}
  if(data.unique$cat_taxa_bird_reptile[i]==1) {
    data.unique$cat_taxa_bird[i]=0
    data.unique$cat_taxa_reptile[i]=0
  }
}

## fish + invertebrate
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_fish[i]==1 & data.unique$cat_taxa_invertebrate[i]==1) {
    data.unique$cat_taxa_fish_invertebrate[i]=1}
  if(data.unique$cat_taxa_fish_invertebrate[i]==1) {
    data.unique$cat_taxa_fish[i]=0
    data.unique$cat_taxa_invertebrate[i]=0
  }
}

## fish + mammal
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_fish[i]==1 & data.unique$cat_taxa_mammal[i]==1) {
    data.unique$cat_taxa_fish_mammal[i]=1}
  if(data.unique$cat_taxa_fish_mammal[i]==1) {
    data.unique$cat_taxa_fish[i]=0
    data.unique$cat_taxa_mammal[i]=0
  }
}

## fish + plant
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_fish[i]==1 & data.unique$cat_taxa_plant[i]==1) {
    data.unique$cat_taxa_fish_plant[i]=1}
  if(data.unique$cat_taxa_fish_plant[i]==1) {
    data.unique$cat_taxa_fish[i]=0
    data.unique$cat_taxa_plant[i]=0
  }
}

## fish + reptile
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_fish[i]==1 & data.unique$cat_taxa_reptile[i]==1) {
    data.unique$cat_taxa_fish_reptile[i]=1}
  if(data.unique$cat_taxa_fish_reptile[i]==1) {
    data.unique$cat_taxa_fish[i]=0
    data.unique$cat_taxa_reptile[i]=0
  }
}

## invertebrate + mammal
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_invertebrate[i]==1 & data.unique$cat_taxa_mammal[i]==1) {
    data.unique$cat_taxa_invertebrate_mammal[i]=1}
  if(data.unique$cat_taxa_invertebrate_mammal[i]==1) {
    data.unique$cat_taxa_invertebrate[i]=0
    data.unique$cat_taxa_mammal[i]=0
  }
}

## invertebrate + plant
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_invertebrate[i]==1 & data.unique$cat_taxa_plant[i]==1) {
    data.unique$cat_taxa_invertebrate_plant[i]=1}
  if(data.unique$cat_taxa_invertebrate_plant[i]==1) {
    data.unique$cat_taxa_invertebrate[i]=0
    data.unique$cat_taxa_plant[i]=0
  }
}

## invertebrate + reptile
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_invertebrate[i]==1 & data.unique$cat_taxa_reptile[i]==1) {
    data.unique$cat_taxa_invertebrate_reptile[i]=1}
  if(data.unique$cat_taxa_invertebrate_reptile[i]==1) {
    data.unique$cat_taxa_invertebrate[i]=0
    data.unique$cat_taxa_reptile[i]=0
  }
}

## mammal + plant
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_mammal[i]==1 & data.unique$cat_taxa_plant[i]==1) {
    data.unique$cat_taxa_mammal_plant[i]=1}
  if(data.unique$cat_taxa_mammal_plant[i]==1) {
    data.unique$cat_taxa_mammal[i]=0
    data.unique$cat_taxa_plant[i]=0
  }
}

## mammal + reptile
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_mammal[i]==1 & data.unique$cat_taxa_reptile[i]==1) {
    data.unique$cat_taxa_mammal_reptile[i]=1}
  if(data.unique$cat_taxa_mammal_reptile[i]==1) {
    data.unique$cat_taxa_mammal[i]=0
    data.unique$cat_taxa_reptile[i]=0
  }
}

## plant + reptile
for(i in 1:nrow(data.unique)){
  if(data.unique$cat_taxa_plant[i]==1 & data.unique$cat_taxa_reptile[i]==1) {
    data.unique$cat_taxa_plant_reptile[i]=1}
  if(data.unique$cat_taxa_plant_reptile[i]==1) {
    data.unique$cat_taxa_plant[i]=0
    data.unique$cat_taxa_reptile[i]=0
  }
}

