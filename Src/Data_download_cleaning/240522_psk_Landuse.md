---
title: "Download Land Use data"
author: "Pranav K."
output: 
  html_document:
    keep_md: true
---

# Download land use data from NASA [past]

Referenced from [Nuri's code](https://github.com/PanditPranav/Climate_Models_Arenaviruses/blob/nuri/src/data/230918-nf-predictors-LandUse.Rmd)


## cropland 

```r
gcrop <- nc_open("./data/input/raw/land use/LUHa_u2t1.v1_gcrop.nc4")
print(gcrop)
```

```
## File ./data/input/raw/land use/LUHa_u2t1.v1_gcrop.nc4 (NC_FORMAT_NETCDF4):
## 
##      1 variables (excluding dimension variables):
##         float prop_crop[lon,lat,time]   (Chunking: [720,360,1])  (Compression: shuffle,level 3)
##             units: percent
##             _FillValue: -9999
##             long_name: Proportion of landcover in crops
##             missing_value: -9999
## 
##      3 dimensions:
##         lat  Size:360 
##             units: degrees_north
##             long_name: Latitude
##             standard_name: latitude
##         lon  Size:720 
##             units: degrees_east
##             long_name: Longitude
##             standard_name: longitude
##         time  Size:306   *** is unlimited *** 
##             long_name: Time
##             standard_name: time
##             calendar: proleptic_gregorian
##             units: years since 1700-01-01 00:00:00
## 
##     6 global attributes:
##         institution: Oak Ridge National Laboratory (ORNL) Distributed Active Archive Center (DAAC)
##         references: Hurtt, G.C., L.P. Chini, S. Frolking, R. A. Betts, J. Feddema, G. Fischer, J. P. Fisk, K. Hibbard, R. A. Houghton, A. Janetos, C. D. Jones, G. Kindermann, T. Kinoshita, Kees Klein Goldewijk, K. Riahi, E. Shevliakova, S. Smith, E. Stehfest, A. Thomson, P. Thornton, D. P. van Vuuren, Y. P. Wang (2011) Harmonization of land-use scenarios for the period 1500–2100: 600 years of global gridded annual land-use transitions, wood harvest, and resulting secondary lands. Climatic change, 109:117-161. DOI 10.1007/s10584-011-0153-2
##         history: Mon Jul  7 15:52:34 2014: ncks -4 -L 3 gcrop_LUHa_u2t1.v1_.nc4 compressed/LUHa_u2t1.v1_gcrop.nc4
##         NCO: 4.3.7
##         title: Land Use Harmonization version 1, including urban land (LUHa_u2t1.v1)
##         source: Version 1 of Land-Use History A product, including land-use changes and transitions from/to urban land
```
## primary land 

```r
gothr <- nc_open("./data/input/raw/land use/LUHa_u2t1.v1_gothr.nc4")
print(gothr)
```

```
## File ./data/input/raw/land use/LUHa_u2t1.v1_gothr.nc4 (NC_FORMAT_NETCDF4):
## 
##      1 variables (excluding dimension variables):
##         float prop_primary[lon,lat,time]   (Chunking: [720,360,1])  (Compression: shuffle,level 3)
##             units: percent
##             _FillValue: -9999
##             long_name: Proportion of landcover in primary landcover
##             missing_value: -9999
## 
##      3 dimensions:
##         lat  Size:360 
##             units: degrees_north
##             long_name: Latitude
##             standard_name: latitude
##         lon  Size:720 
##             units: degrees_east
##             long_name: Longitude
##             standard_name: longitude
##         time  Size:306   *** is unlimited *** 
##             long_name: Time
##             standard_name: time
##             calendar: proleptic_gregorian
##             units: years since 1700-01-01 00:00:00
## 
##     6 global attributes:
##         institution: Oak Ridge National Laboratory (ORNL) Distributed Active Archive Center (DAAC)
##         references: Hurtt, G.C., L.P. Chini, S. Frolking, R. A. Betts, J. Feddema, G. Fischer, J. P. Fisk, K. Hibbard, R. A. Houghton, A. Janetos, C. D. Jones, G. Kindermann, T. Kinoshita, Kees Klein Goldewijk, K. Riahi, E. Shevliakova, S. Smith, E. Stehfest, A. Thomson, P. Thornton, D. P. van Vuuren, Y. P. Wang (2011) Harmonization of land-use scenarios for the period 1500–2100: 600 years of global gridded annual land-use transitions, wood harvest, and resulting secondary lands. Climatic change, 109:117-161. DOI 10.1007/s10584-011-0153-2
##         history: Tue Jul  8 10:34:57 2014: ncks -4 -L 3 gothr_LUHa_u2t1.v1_.nc4 compressed/LUHa_u2t1.v1_gothr.nc4
##         NCO: 4.3.7
##         title: Land Use Harmonization version 1, including urban land (LUHa_u2t1.v1)
##         source: Version 1 of Land-Use History A product, including land-use changes and transitions from/to urban land
```
## pasture

```r
gpast <- nc_open("./data/input/raw/land use/LUHa_u2t1.v1_gpast.nc4")
print(gpast)
```

```
## File ./data/input/raw/land use/LUHa_u2t1.v1_gpast.nc4 (NC_FORMAT_NETCDF4):
## 
##      1 variables (excluding dimension variables):
##         float prop_pasture[lon,lat,time]   (Chunking: [720,360,1])  (Compression: shuffle,level 3)
##             units: percent
##             _FillValue: -9999
##             long_name: Proportion of landcover in pasture
##             missing_value: -9999
## 
##      3 dimensions:
##         lat  Size:360 
##             units: degrees_north
##             long_name: Latitude
##             standard_name: latitude
##         lon  Size:720 
##             units: degrees_east
##             long_name: Longitude
##             standard_name: longitude
##         time  Size:306   *** is unlimited *** 
##             long_name: Time
##             standard_name: time
##             calendar: proleptic_gregorian
##             units: years since 1700-01-01 00:00:00
## 
##     6 global attributes:
##         institution: Oak Ridge National Laboratory (ORNL) Distributed Active Archive Center (DAAC)
##         references: Hurtt, G.C., L.P. Chini, S. Frolking, R. A. Betts, J. Feddema, G. Fischer, J. P. Fisk, K. Hibbard, R. A. Houghton, A. Janetos, C. D. Jones, G. Kindermann, T. Kinoshita, Kees Klein Goldewijk, K. Riahi, E. Shevliakova, S. Smith, E. Stehfest, A. Thomson, P. Thornton, D. P. van Vuuren, Y. P. Wang (2011) Harmonization of land-use scenarios for the period 1500–2100: 600 years of global gridded annual land-use transitions, wood harvest, and resulting secondary lands. Climatic change, 109:117-161. DOI 10.1007/s10584-011-0153-2
##         history: Tue Jul  8 10:35:45 2014: ncks -4 -L 3 gpast_LUHa_u2t1.v1_.nc4 compressed/LUHa_u2t1.v1_gpast.nc4
##         NCO: 4.3.7
##         title: Land Use Harmonization version 1, including urban land (LUHa_u2t1.v1)
##         source: Version 1 of Land-Use History A product, including land-use changes and transitions from/to urban land
```
## secondary land 

```r
gsecd<- nc_open("./data/input/raw/land use/LUHa_u2t1.v1_gsecd.nc4")
print(gsecd)
```

```
## File ./data/input/raw/land use/LUHa_u2t1.v1_gsecd.nc4 (NC_FORMAT_NETCDF4):
## 
##      1 variables (excluding dimension variables):
##         float prop_secd[lon,lat,time]   (Chunking: [720,360,1])  (Compression: shuffle,level 3)
##             units: percent
##             _FillValue: -9999
##             long_name: Proportion of landcover in secondary landcover
##             missing_value: -9999
## 
##      3 dimensions:
##         lat  Size:360 
##             units: degrees_north
##             long_name: Latitude
##             standard_name: latitude
##         lon  Size:720 
##             units: degrees_east
##             long_name: Longitude
##             standard_name: longitude
##         time  Size:306   *** is unlimited *** 
##             long_name: Time
##             standard_name: time
##             calendar: proleptic_gregorian
##             units: years since 1700-01-01 00:00:00
## 
##     6 global attributes:
##         institution: Oak Ridge National Laboratory (ORNL) Distributed Active Archive Center (DAAC)
##         references: Hurtt, G.C., L.P. Chini, S. Frolking, R. A. Betts, J. Feddema, G. Fischer, J. P. Fisk, K. Hibbard, R. A. Houghton, A. Janetos, C. D. Jones, G. Kindermann, T. Kinoshita, Kees Klein Goldewijk, K. Riahi, E. Shevliakova, S. Smith, E. Stehfest, A. Thomson, P. Thornton, D. P. van Vuuren, Y. P. Wang (2011) Harmonization of land-use scenarios for the period 1500–2100: 600 years of global gridded annual land-use transitions, wood harvest, and resulting secondary lands. Climatic change, 109:117-161. DOI 10.1007/s10584-011-0153-2
##         history: Tue Jul  8 10:38:56 2014: ncks -4 -L 3 gsecd_LUHa_u2t1.v1_.nc4 compressed/LUHa_u2t1.v1_gsecd.nc4
##         NCO: 4.3.7
##         title: Land Use Harmonization version 1, including urban land (LUHa_u2t1.v1)
##         source: Version 1 of Land-Use History A product, including land-use changes and transitions from/to urban land
```
## LUHa_t1.v1_gurbn.nc4 -> urban land

```r
gurbn <- nc_open("./data/input/raw/land use/LUHa_u2t1.v1_gurbn.nc4")
print(gurbn)
```

```
## File ./data/input/raw/land use/LUHa_u2t1.v1_gurbn.nc4 (NC_FORMAT_NETCDF4):
## 
##      1 variables (excluding dimension variables):
##         float prop_urbn[lon,lat,time]   (Chunking: [720,360,1])  (Compression: shuffle,level 3)
##             units: percent
##             _FillValue: -9999
##             long_name: Proportion of landcover in urban land
##             missing_value: -9999
## 
##      3 dimensions:
##         lat  Size:360 
##             units: degrees_north
##             long_name: Latitude
##             standard_name: latitude
##         lon  Size:720 
##             units: degrees_east
##             long_name: Longitude
##             standard_name: longitude
##         time  Size:306   *** is unlimited *** 
##             long_name: Time
##             standard_name: time
##             calendar: proleptic_gregorian
##             units: years since 1700-01-01 00:00:00
## 
##     6 global attributes:
##         institution: Oak Ridge National Laboratory (ORNL) Distributed Active Archive Center (DAAC)
##         references: Hurtt, G.C., L.P. Chini, S. Frolking, R. A. Betts, J. Feddema, G. Fischer, J. P. Fisk, K. Hibbard, R. A. Houghton, A. Janetos, C. D. Jones, G. Kindermann, T. Kinoshita, Kees Klein Goldewijk, K. Riahi, E. Shevliakova, S. Smith, E. Stehfest, A. Thomson, P. Thornton, D. P. van Vuuren, Y. P. Wang (2011) Harmonization of land-use scenarios for the period 1500–2100: 600 years of global gridded annual land-use transitions, wood harvest, and resulting secondary lands. Climatic change, 109:117-161. DOI 10.1007/s10584-011-0153-2
##         history: Tue Jul  8 10:43:24 2014: ncks -4 -L 3 gurbn_LUHa_u2t1.v1_.nc4 compressed/LUHa_u2t1.v1_gurbn.nc4
##         NCO: 4.3.7
##         title: Land Use Harmonization version 1, including urban land (LUHa_u2t1.v1)
##         source: Version 1 of Land-Use History A product, including land-use changes and transitions from/to urban land
```


```r
path = "./data/input/raw/land use"
nc <- list.files(path, full.names = T)
nc_list <- lapply(nc, function(x) nc_open(x))
names(nc_list) <- c("gcrop", "gothr", "gpast", "gsecd", "gurbn")
list2env(nc_list,.GlobalEnv)
```

```
## <environment: R_GlobalEnv>
```
## Get the latitude, longitude and time dimensions for all NCs


```r
c("gcrop", "gothr", "gpast", "gsecd", "gurbn")
```

```
## [1] "gcrop" "gothr" "gpast" "gsecd" "gurbn"
```

```r
lat_lon_t <- function(data) {
  lon <- ncvar_get(gcrop, "lon")
  lat <- ncvar_get(gcrop, "lat", verbose = F)
  t <- ncvar_get(gcrop, "time")
  return(list(lat = lat, lon = lon, t = t))
}
lat_lon_t_crop <- lat_lon_t(gcrop)
lat_lon_t_othr <- lat_lon_t(gothr)
lat_lon_t_urbn <- lat_lon_t(gurbn)
lat_lon_t_past <- lat_lon_t(gpast)
lat_lon_t_secd <- lat_lon_t(gsecd)

data.frame(time_code = lat_lon_t_crop[[3]], year = seq(1700, 2005,1))[c(1:5, 300:306),]
```

```
##     time_code year
## 1           0 1700
## 2           1 1701
## 3           2 1702
## 4           3 1703
## 5           4 1704
## 300       299 1999
## 301       300 2000
## 302       301 2001
## 303       302 2002
## 304       303 2003
## 305       304 2004
## 306       305 2005
```
## Read data from the gcrop variable and verify the dimensions of the array


```r
crop_array <- ncvar_get(gcrop, "prop_crop")
othr_array <- ncvar_get(gothr, "prop_primary")
urbn_array <- ncvar_get(gurbn, "prop_urbn")
past_array <- ncvar_get(gpast, "prop_pasture")
secd_array <- ncvar_get(gsecd, "prop_secd")
paste("max Dimensions: ")
```

```
## [1] "max Dimensions: "
```

```r
paste(c("lon = ", "lat = ", "year = "), dim(crop_array))
```

```
## [1] "lon =  720"  "lat =  360"  "year =  306"
```

## Replace missing values with "NA" for R compatibility


```r
crop_array[crop_array == ncatt_get(gcrop, "prop_crop", "_FillValue")$value] <- NA
othr_array[othr_array == ncatt_get(gothr, "prop_primary", "_FillValue")$value] <- NA
urbn_array[urbn_array == ncatt_get(gurbn, "prop_urbn", "_FillValue")$value] <- NA
past_array[past_array == ncatt_get(gpast, "prop_pasture", "_FillValue")$value] <- NA
secd_array[secd_array == ncatt_get(gsecd, "prop_secd", "_FillValue")$value] <- NA


length(secd_array[is.na(crop_array) == TRUE])
```

```
## [1] 0
```
## Year 2000 subset


```r
slice_2000 <- function(data, timecode) {
  return(data[,,timecode])
}

crop_2000 <- slice_2000(crop_array, timecode = 300)
othr_2000 <- slice_2000(othr_array, timecode = 300)
urbn_2000 <- slice_2000(urbn_array, timecode = 300)
past_2000 <- slice_2000(past_array, timecode = 300)
secd_2000 <- slice_2000(secd_array, timecode = 300)

head(which(crop_2000 > 0, arr.ind = T))
```

```
##      row col
## [1,] 529  34
## [2,] 639  36
## [3,] 642  36
## [4,] 570  38
## [5,] 562  39
## [6,] 615  39
```

```r
paste("max, min, mean =>",
  max(crop_2000), min(crop_2000), mean(crop_2000))
```

```
## [1] "max, min, mean => 1 0 0.0239931867719333"
```
## Make rasters


```r
r_crop <- raster(t(crop_2000),
                 xmn=min(lat_lon_t_crop$lon),
                 xmx=max(lat_lon_t_crop$lon),
                 ymn=min(lat_lon_t_crop$lat),
                 ymx=max(lat_lon_t_crop$lat), 
                 crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
raster::plot(r_crop)
```

![](Landuse_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

```r
r_othr <- raster(t(othr_2000),
                 xmn=min(lat_lon_t_othr$lon),
                 xmx=max(lat_lon_t_othr$lon),
                 ymn=min(lat_lon_t_othr$lat),
                 ymx=max(lat_lon_t_othr$lat), 
                 crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
raster::plot(r_othr)
```

![](Landuse_files/figure-html/unnamed-chunk-12-2.png)<!-- -->

```r
r_past <- raster(t(past_2000),
                 xmn=min(lat_lon_t_past$lon),
                 xmx=max(lat_lon_t_past$lon),
                 ymn=min(lat_lon_t_past$lat),
                 ymx=max(lat_lon_t_past$lat), 
                 crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
raster::plot(r_past)
```

![](Landuse_files/figure-html/unnamed-chunk-12-3.png)<!-- -->

```r
r_urbn <- raster(t(urbn_2000),
                 xmn=min(lat_lon_t_urbn$lon),
                 xmx=max(lat_lon_t_urbn$lon),
                 ymn=min(lat_lon_t_urbn$lat),
                 ymx=max(lat_lon_t_urbn$lat), 
                 crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
raster::plot(r_urbn)
```

![](Landuse_files/figure-html/unnamed-chunk-12-4.png)<!-- -->

```r
r_secd <- raster(t(secd_2000),
                 xmn=min(lat_lon_t_secd$lon),
                 xmx=max(lat_lon_t_secd$lon),
                 ymn=min(lat_lon_t_secd$lat),
                 ymx=max(lat_lon_t_secd$lat), 
                 crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))
raster::plot(r_secd)
```

![](Landuse_files/figure-html/unnamed-chunk-12-5.png)<!-- -->

```r
r_crop
```

```
## class      : RasterLayer 
## dimensions : 360, 720, 259200  (nrow, ncol, ncell)
## resolution : 0.4993056, 0.4986111  (x, y)
## extent     : -179.75, 179.75, -89.75, 89.75  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs 
## source     : memory
## names      : layer 
## values     : 0, 1  (min, max)
```

```r
r_othr
```

```
## class      : RasterLayer 
## dimensions : 360, 720, 259200  (nrow, ncol, ncell)
## resolution : 0.4993056, 0.4986111  (x, y)
## extent     : -179.75, 179.75, -89.75, 89.75  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs 
## source     : memory
## names      : layer 
## values     : 0, 1  (min, max)
```

```r
r_past
```

```
## class      : RasterLayer 
## dimensions : 360, 720, 259200  (nrow, ncol, ncell)
## resolution : 0.4993056, 0.4986111  (x, y)
## extent     : -179.75, 179.75, -89.75, 89.75  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs 
## source     : memory
## names      : layer 
## values     : 0, 1  (min, max)
```

```r
r_urbn
```

```
## class      : RasterLayer 
## dimensions : 360, 720, 259200  (nrow, ncol, ncell)
## resolution : 0.4993056, 0.4986111  (x, y)
## extent     : -179.75, 179.75, -89.75, 89.75  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs 
## source     : memory
## names      : layer 
## values     : 0, 0.779523  (min, max)
```

```r
r_secd
```

```
## class      : RasterLayer 
## dimensions : 360, 720, 259200  (nrow, ncol, ncell)
## resolution : 0.4993056, 0.4986111  (x, y)
## extent     : -179.75, 179.75, -89.75, 89.75  (xmin, xmax, ymin, ymax)
## crs        : +proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs 
## source     : memory
## names      : layer 
## values     : 0, 1  (min, max)
```
## Create landuse compiled data


```r
landuse <- stack(list(r_crop, r_othr, r_past, r_urbn, r_secd))
names(landuse) <- c("Cropland", "Primary land", "Pasture", "Secondary Land", "Urban Land")

raster::plot(landuse)
```

![](Landuse_files/figure-html/unnamed-chunk-14-1.png)<!-- -->


```r
landuse <- mosaic(r_crop, r_othr, r_past, r_urbn, r_secd, fun=sum)
raster::plot(landuse)
```

![](Landuse_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

## Save


```r
raster_list <- list(r_crop, r_othr, r_past, r_urbn, r_secd) 

output_folder <- "./data/input/processed/landuse" #output folder

# Loop through the list and write each raster to a GeoTIFF file
for (i in 1:length(raster_list)) {
  raster_object <- raster_list[[i]]
  filename <- file.path(output_folder, paste0("landuse_", i, ".tif"))
  writeRaster(raster_object, filename, "GTiff", overwrite = TRUE)
}
```

