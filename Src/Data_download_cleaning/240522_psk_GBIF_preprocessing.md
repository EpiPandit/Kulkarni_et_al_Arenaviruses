## What is this?

This file contains the code for preprocessing of the GBIF files. In this
file, the example of Venezuela is illustrated. The GBIF file relates to
species presence of *Zygodontomys brevicauda* and *Sigmodon alstoni*

The presence-only data is cropped to the rough coordinate extent of
Venezuela and layered on Bioclim data

The presence-only data is bound to randomly generated pseudo absences to
create the training dataset.

## Code

### Dependencies and libraries

Note: rgdal, maptools and wrld\_simpl do not work in R &gt; 3.3 as of
Oct 2023

    library(raster)
    # library(rgdal)
    library(dismo)
    # library(maptools)
    library(maps) # maptools replacement
    library("readxl")
    library(sf) # replacement of rgdal
    # data(wrld_simpl)

### User defined Functions

    process_gbif <- function(gbif_raw, countrycode, species, extent_vector) {
      gbif_raw <- gbif_raw[which(gbif_raw$countryCode == countrycode),]
    gbif_raw <- gbif_raw[which(gbif_raw$species == species),]
    gbif <- data.frame(matrix(ncol = 2, nrow = length(gbif_raw$decimalLongitude)))
    gbif[,1] <- gbif_raw$decimalLongitude
    gbif[,2] <- gbif_raw$decimalLatitude
    gbif <- unique(gbif) # xantusia without duplicates
    gbif <- gbif[complete.cases(gbif),] # remove na's
    colnames(gbif) <- c('lon','lat')

    e <- extent(extent_vector)
    gbif <- gbif[which(gbif$lon>=e[1] & gbif$lon<=e[2]),] # remove presences beyond extent
    gbif <- gbif[which(gbif$lat>=e[3] & gbif$lat<=e[4]),] # remove presences beyond extent

    return(list(gbif = gbif,gbif_raw = gbif_raw, e = e))
    }


    process_bioclim <- function(path_raw, variables, resolution, path_write) {
      bioclim.data <- getData(name = "worldclim",
                            var = variables,
                            res = resolution,
                            path = path_raw)
        bioclim.data <- crop(bioclim.data, e*1.25)  # crop to bg point extent
        # write rasters to /data folder
        for (i in c(1:19)){
          writeRaster(bioclim.data[[i]], paste(path_write, i, sep = ''),
                    format="ascii", overwrite=TRUE)
      }

      return(bioclim.data)
    }

    process_train <- function(gbif_data, coord_ref, ext_f, pseudo_abs_f, path_write, layer_name, driver_write) {
      presences = dim(gbif_data)[1]
      bg <- randomPoints(mask = coord_ref, n = presences*pseudo_abs_f, ext = e, extf = ext_f)
      colnames(bg) <- c('lon','lat')
      train <- rbind(gbif_data, bg)  # combine with presences
      pa_train <- c(rep(1, nrow(gbif_data)), rep(0, nrow(bg))) # col of ones and zeros
      train <- data.frame(cbind(CLASS=pa_train, train)) 

      crs <- crs(coord_ref)
      train <- train[sample(nrow(train)),]
      class.pa <- data.frame(train[,1])
      colnames(class.pa) <- 'CLASS'
      dataMap.gbif  <- SpatialPointsDataFrame(train[,c(2,3)], class.pa,
                                          proj4string =crs)

      st_write(as(dataMap.gbif, "sf"), path_write,layer_name, driver = driver_write, append = F)
      return(list(bg = bg, train = train, crs = crs, dataMap.gbif=dataMap.gbif))
    }

    # plot_processed <- function(coord_ref, title, gbif_data, path_write) {
    #   png(paste0(path_write, title, ".png"), width = 500, height = 500)
    #   plot(coord_ref, main = title)
    #   points(bg, col = "red", pch = 16, cex = 1)
    #   points(gbif_data, col = "black", pch = 16, cex = 1)
    #   map("world", add = T, col = "black", lwd = 2) #wrld_simpl replacement
    #   dev.off
    # }  

### example code Zygodontomys brevicauda

    gbif_raw <- read.csv("/Users/pranavkulkarni/SDM/main_repo/Climate_Models_Arenaviruses/Guan_SDM/data/input/raw/GBIF_Zygodontomys brevicauda_Sigmodon alstoni.csv")
    gbif_list <- process_gbif(gbif_raw = gbif_raw,
                              countrycode = "VE", 
                              species = "Zygodontomys brevicauda",
                              extent_vector = c(-74,-58, 0, 12)
                              )
    list2env(gbif_list, .GlobalEnv)

    ## <environment: R_GlobalEnv>

    rm(gbif_list)


    bioclim.data <- process_bioclim(path_raw = "./data/input/raw",
                                    variables = "bio",
                                    resolution = 2.5,
                                    path_write = "data/input/processed/bclim")

    ## Warning in getData(name = "worldclim", var = variables, res = resolution, : getData will be removed in a future version of raster
    ## . Please use the geodata package instead

    train_list <- process_train(gbif_data = gbif,
                                coord_ref = bioclim.data[[1]],
                                ext_f = 1.25,
                                pseudo_abs_f = 4,
                                path_write = "./data/input/processed",
                                layer_name = "zyg",
                                driver_write = "ESRI Shapefile")

    ## Deleting layer `zyg' using driver `ESRI Shapefile'
    ## Writing layer `zyg' to data source 
    ##   `./data/input/processed' using driver `ESRI Shapefile'
    ## Writing 315 features with 1 fields and geometry type Point.

    list2env(train_list, .GlobalEnv)

    ## <environment: R_GlobalEnv>

    rm(train_list)

    for (i in 1:4) {
    plot(bioclim.data[[i]], main=paste0('Bioclim- ', i))
    points(bg, col='red', pch = 16,cex=1)
    points(gbif, col='black', pch = 16,cex=1)
    map("world", add = T, col='black', lwd=3) #wrld_simpl replacement
    }

![](GBIF_preprocessing_files/figure-markdown_strict/unnamed-chunk-3-1.png)![](GBIF_preprocessing_files/figure-markdown_strict/unnamed-chunk-3-2.png)![](GBIF_preprocessing_files/figure-markdown_strict/unnamed-chunk-3-3.png)![](GBIF_preprocessing_files/figure-markdown_strict/unnamed-chunk-3-4.png)

    message("Also view the saved plot of bioclim with gbif in output folder")

    ## Also view the saved plot of bioclim with gbif in output folder

### example code Sigmodon alstoni

    gbif_raw <- read.csv("/Users/pranavkulkarni/SDM/main_repo/Climate_Models_Arenaviruses/Guan_SDM/data/input/raw/GBIF_Zygodontomys brevicauda_Sigmodon alstoni.csv")
    gbif_list <- process_gbif(gbif_raw = gbif_raw,
                              countrycode = "VE", 
                              species = "Sigmodon alstoni",
                              extent_vector = c(-74,-58, 0, 12)
                              )
    list2env(gbif_list, .GlobalEnv)

    ## <environment: R_GlobalEnv>

    rm(gbif_list)


    bioclim.data <- process_bioclim(path_raw = "./data/input/raw",
                                    variables = "bio",
                                    resolution = 2.5,
                                    path_write = "data/input/processed/bclim")

    ## Warning in getData(name = "worldclim", var = variables, res = resolution, : getData will be removed in a future version of raster
    ## . Please use the geodata package instead

    train_list <- process_train(gbif_data = gbif,
                                coord_ref = bioclim.data[[1]],
                                ext_f = 1.25,
                                pseudo_abs_f = 4,
                                path_write = "./data/input/processed",
                                layer_name = "sig",
                                driver_write = "ESRI Shapefile")

    ## Deleting layer `sig' using driver `ESRI Shapefile'
    ## Writing layer `sig' to data source 
    ##   `./data/input/processed' using driver `ESRI Shapefile'
    ## Writing 150 features with 1 fields and geometry type Point.

    list2env(train_list, .GlobalEnv)

    ## <environment: R_GlobalEnv>

    rm(train_list)

    for (i in 1:4) {
    plot(bioclim.data[[i]], main=paste0('Bioclim ', i))
    points(bg, col='red', pch = 16,cex=1)
    points(gbif, col='black', pch = 16,cex=1)
    map("world", add = T, col='black', lwd=3) #wrld_simpl replacement
    }

![](GBIF_preprocessing_files/figure-markdown_strict/unnamed-chunk-4-1.png)![](GBIF_preprocessing_files/figure-markdown_strict/unnamed-chunk-4-2.png)![](GBIF_preprocessing_files/figure-markdown_strict/unnamed-chunk-4-3.png)![](GBIF_preprocessing_files/figure-markdown_strict/unnamed-chunk-4-4.png)

    message("Also view the saved plot of bioclim with gbif in output folder")

    ## Also view the saved plot of bioclim with gbif in output folder
