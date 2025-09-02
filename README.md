# Predicted climate-driven changes in zoonotic risk of arenaviral hemorrhagic fevers in South America

## Author list

### Pranav S. Kulkarni (1), Nuri Y. Flores-Perez (1), Andie H. Jian (1), Brian H. Bird (2), Christine K. Johnson (2), Marcela Uhart (2),(3), Pranav S. Pandit (1).
 - (1) Department of Population Health and Reproduction, School of Veterinary Medicine, University of California, Davis
 - (2) One Health Institute, School of Veterinary Medicine, University of California, Davis
 - (3) Karen C. Drayer Wildlife Center, School of Veterinary Medicine, University of California, Davis


## Description

This repository contains the source code and examples of the analyses conducted for manuscript of Kulkarni et al.

## Abstract
The long-term impacts of climate change on the risk of zoonotic disease outbreaks such as New World arenaviral hemorrhagic fevers are poorly understood and understudied. Endemic areas and their surrounding regions are expected to undergo significant changes in both climate patterns and anthropogenic activities. Through this study we aimed to advance insight into the impact of climate change on the spillover risks of neglected high-impact zoonotic diseases such as New World Arenaviruses (NWAs) in South America. A robust predictive modeling framework that integrated force-of-infection models with comprehensive species distribution algorithms was developed for understanding the effects of climate change on zoonotic disease risk.
We predicted a substantial increase in the risk of NWA spillover from known rodent reservoirs to humans in the next two decades. Risk was predicted to increase with  climate change and related anthropogenic factors regardless of the severity of the projected climate change scenario modeled. For all NWAs studied, reservoir habitats were predicted to spread out in the future, increasing the chance of human-rodent interactions and consequently the spillover of NWA infections. Depending on the reservoir species, habitat changes were found to be sensitive to the long-term changes in varying climate and land-use features. 

## Keywords
Mammarenavirus, rodent reservoirs, species distribution, spillover, machine learning


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
