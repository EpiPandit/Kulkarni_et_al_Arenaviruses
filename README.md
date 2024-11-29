# Climate-driven models for Changing risk of arenavirus spillover in South America

## Author list

### Kulkarni Pranav S., Flores Nuri Y., Uhart Marcy, Ross Carmen, Jian Andie H., Pandit Pranav S.

1.  Department of Population Health and Reproduction, School of Veterinary medicine, University of California, Davis
2.  Karen C. Drayer Wildlife Center, One Health Institute, School of Veterinary Medicine, University of California, Davis

## Description

This repository contains the source code and examples of the analyses conducted for manuscript of Kulkarni et al.

## Summary

New World Arenaviruses (NWA) cause viral hemorrhagic fever in humans, with high potential burden in terms of mortality and morbidity in susceptible populations. Primarily a spillover risk from rodent reservoirs to humans, the risk of infection is significantly affected by distribution of the rodent hosts and the movement patterns of humans. The aim of this study was to model the climate-change driven risk of zoonotic spillover of NWA by combining (i) species distribution modelling (SDM) of the rodent reservoir species (*Calomys musculinus, Zygodotomys brevicauda, Sigmodon alstoni, etc.*) with (ii) disease transmission modelling in humans. SDMs were developed using ensembles of four tree-based machine learning techniques trained on current bioclimatic, land use, vegetation and landscape data of the area under study. By combining the SDM with spatial information on the human population density of the area, current hotspots for potential outbreaks were identified. Shared Socioeconomic Pathways (SSP) of moderate and extremely negative type (SSP2.45 and SSP5.85 resp.) projections of climate change for years 2041 to 2060 were used as future scenarios for climate-change. Based on the two scenarios, predicted changes in the risk patterns and hotspots for zoonotic outbreaks were investigated. **SDMs of rodent reservoirs of Junin virus in Argentina, Machupo virus in Bolivia and Guanarito virus in Venezuela and Colombia** yielded high precision in predicting species habitats ranging from 83% to 91%. Our study provides valuable insights into potential shifts in rodenthabitat suitability and patterns. Using the patterns for species presence discerned from SDMs, the density dependent Force-Of-Infection (FOI) were calculated for each rodent reservoir of the three zoonotic arena viruses. The top 10% percentile of FOI distributions (termed potential hotspots for outbreaks; both current and predicted in the future) were investigated for their potential sensitvity to change in climate or environmental conditions.

The study demonstrated that the distributions of reservoir species and the susceptible human population are sensitive to the changes in the climactic conditions over time. The framework of the study has potential to serve as a climate-driven, predicted risk modelling tool for rodent-borne zoonotic outbreaks globally and to gain insights of their economic burden.

## Folder Structure

```         
├── .gitignore
├── CITATION.md
├── LICENSE.md
├── README.md
├── Data                <- Example project data
│   └── output          <- All created models before deploying/ finalizing
│   └── input            
├── Docs                <- Documentation notebook for users 
├── Manuscript          <- Manuscript source, e.g., LaTeX, pdf, docx, etc. 
└── Src/code            <- Source code for this project (.sh files, .R, .pynb, .py, etc.) 
    └── SDMs            <- Source code for training Species Distribution models
    └── FOI             <- Source code for Force-of-Infection calculation
    └── data_cleaning     <- Source code for data download, cleaning, etc.
    └── Tables_Figur.   <- Exploration and result oriented visualization

Note: There are more sub-folders which are not shown in the schema for the sake of brevity.
```
