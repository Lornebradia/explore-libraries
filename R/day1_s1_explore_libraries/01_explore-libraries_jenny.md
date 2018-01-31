    ## how jenny might do this in a first exploration
    ## purposely leaving a few things to change later!

Which libraries does R search for packages?

    .libPaths()

    ## [1] "/Library/Frameworks/R.framework/Versions/3.4/Resources/library"

    ## let's confirm the second element is, in fact, the default library
    .Library

    ## [1] "/Library/Frameworks/R.framework/Resources/library"

    library(fs)
    path_real(.Library)

    ## /Library/Frameworks/R.framework/Versions/3.4/Resources/library

Installed packages

    library(tidyverse)

    ## ── Attaching packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.8.0     ✔ stringr 1.2.0
    ## ✔ readr   1.1.1     ✔ forcats 0.2.0

    ## ── Conflicts ──────────────────────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

    ipt <- installed.packages() %>%
      as_tibble()

    ## how many packages?
    nrow(ipt)

    ## [1] 555

Exploring the packages

    ## count some things! inspiration
    ##   * tabulate by LibPath, Priority, or both
    ipt %>%
      count(LibPath, Priority)

    ## # A tibble: 3 x 3
    ##   LibPath                                                 Priority       n
    ##   <chr>                                                   <chr>      <int>
    ## 1 /Library/Frameworks/R.framework/Versions/3.4/Resources… base          14
    ## 2 /Library/Frameworks/R.framework/Versions/3.4/Resources… recommend…    15
    ## 3 /Library/Frameworks/R.framework/Versions/3.4/Resources… <NA>         526

    ##   * what proportion need compilation?
    ipt %>%
      count(NeedsCompilation) %>%
      mutate(prop = n / sum(n))

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   prop
    ##   <chr>            <int>  <dbl>
    ## 1 no                 296 0.533 
    ## 2 yes                229 0.413 
    ## 3 <NA>                30 0.0541

    ##   * how break down re: version of R they were built on
    ipt %>%
      count(Built) %>%
      mutate(prop = n / sum(n))

    ## # A tibble: 4 x 3
    ##   Built     n   prop
    ##   <chr> <int>  <dbl>
    ## 1 3.4.0   335 0.604 
    ## 2 3.4.1    93 0.168 
    ## 3 3.4.2    84 0.151 
    ## 4 3.4.3    43 0.0775

Reflections

    ## reflect on ^^ and make a few notes to yourself; inspiration
    ##   * does the number of base + recommended packages make sense to you?
    ##   * how does the result of .libPaths() relate to the result of .Library?

Going further

    ## if you have time to do more ...

    ## is every package in .Library either base or recommended?
    all_default_pkgs <- list.files(.Library)
    all_br_pkgs <- ipt %>%
      filter(Priority %in% c("base", "recommended")) %>%
      pull(Package)
    setdiff(all_default_pkgs, all_br_pkgs)

    ##   [1] "abind"                "acepack"              "acs"                 
    ##   [4] "ada"                  "ade4"                 "ape"                 
    ##   [7] "arm"                  "ash"                  "assertive"           
    ##  [10] "assertive.base"       "assertive.code"       "assertive.data"      
    ##  [13] "assertive.data.uk"    "assertive.data.us"    "assertive.datetimes" 
    ##  [16] "assertive.files"      "assertive.matrices"   "assertive.models"    
    ##  [19] "assertive.numbers"    "assertive.properties" "assertive.reflection"
    ##  [22] "assertive.sets"       "assertive.strings"    "assertive.types"     
    ##  [25] "assertthat"           "audio"                "audiolyzR"           
    ##  [28] "backports"            "base64enc"            "bayesplot"           
    ##  [31] "BB"                   "bdsmatrix"            "beepr"               
    ##  [34] "benchmarkme"          "benchmarkmeData"      "BH"                  
    ##  [37] "bibtex"               "biclust"              "biglm"               
    ##  [40] "bindr"                "bindrcpp"             "bit"                 
    ##  [43] "bit64"                "bitops"               "blob"                
    ##  [46] "blogdown"             "bmp"                  "bnlearn"             
    ##  [49] "bookdown"             "BradleyTerry2"        "brew"                
    ##  [52] "brglm"                "bridgesampling"       "brms"                
    ##  [55] "Brobdingnag"          "broom"                "BRRR"                
    ##  [58] "Cairo"                "callr"                "car"                 
    ##  [61] "caret"                "caTools"              "cats"                
    ##  [64] "cellranger"           "checkmate"            "choroplethr"         
    ##  [67] "choroplethrMaps"      "chron"                "classifly"           
    ##  [70] "classInt"             "cli"                  "clipr"               
    ##  [73] "clisymbols"           "coda"                 "coin"                
    ##  [76] "colorspace"           "colourpicker"         "commonmark"          
    ##  [79] "config"               "corrplot"             "covr"                
    ##  [82] "cowplot"              "crayon"               "crosstalk"           
    ##  [85] "curl"                 "CVST"                 "d3heatmap"           
    ##  [88] "daff"                 "data.table"           "DBI"                 
    ##  [91] "dbplyr"               "ddalpha"              "debugme"             
    ##  [94] "deldir"               "dendextend"           "DEoptimR"            
    ##  [97] "desc"                 "devtools"             "dfoptim"             
    ## [100] "DiagrammeR"           "dichromat"            "digest"              
    ## [103] "dimRed"               "diptest"              "dlm"                 
    ## [106] "doParallel"           "downloader"           "dplyr"               
    ## [109] "DRR"                  "dse"                  "DT"                  
    ## [112] "dtt"                  "dygraphs"             "e1071"               
    ## [115] "elasticnet"           "enc"                  "EvalEst"             
    ## [118] "evaluate"             "evd"                  "evtree"              
    ## [121] "expm"                 "expsmooth"            "extrafont"           
    ## [124] "extrafontdb"          "fastcluster"          "fastmatch"           
    ## [127] "ff"                   "ffbase"               "filehash"            
    ## [130] "flexclust"            "flexdashboard"        "flexmix"             
    ## [133] "fma"                  "forcats"              "foreach"             
    ## [136] "forecast"             "formatR"              "formattable"         
    ## [139] "Formula"              "fpc"                  "fpp"                 
    ## [142] "fracdiff"             "fs"                   "gam"                 
    ## [145] "gamm4"                "gbm"                  "gdalUtils"           
    ## [148] "gdata"                "gdtools"              "gender"              
    ## [151] "geojson"              "geojsonio"            "geojsonlint"         
    ## [154] "geosphere"            "getCompetitionData"   "getPass"             
    ## [157] "GGally"               "ggalt"                "ggdendro"            
    ## [160] "ggforce"              "ggfortify"            "ggiraph"             
    ## [163] "ggmap"                "ggplot2"              "ggrepel"             
    ## [166] "ggthemes"             "ggvis"                "gh"                  
    ## [169] "gistr"                "git2r"                "glmnet"              
    ## [172] "glue"                 "gmodels"              "gmp"                 
    ## [175] "goftest"              "googlesheets"         "googleVis"           
    ## [178] "gower"                "GPArotation"          "gplots"              
    ## [181] "gridBase"             "gridExtra"            "gsubfn"              
    ## [184] "gtable"               "gtools"               "h2o"                 
    ## [187] "haven"                "here"                 "hexbin"              
    ## [190] "highcharter"          "highr"                "Hmisc"               
    ## [193] "hms"                  "hrbrthemes"           "HSAUR2"              
    ## [196] "HSAUR3"               "htmlTable"            "htmltools"           
    ## [199] "htmlwidgets"          "httpuv"               "httr"                
    ## [202] "igraph"               "imager"               "influenceR"          
    ## [205] "ini"                  "inline"               "ipred"               
    ## [208] "irlba"                "ISLR"                 "iterators"           
    ## [211] "itertools"            "janitor"              "jpeg"                
    ## [214] "jqr"                  "jsonlite"             "jsonvalidate"        
    ## [217] "kernlab"              "keyring"              "KFAS"                
    ## [220] "knitcitations"        "knitr"                "knitrBootstrap"      
    ## [223] "labeling"             "Lahman"               "LaplacesDemon"       
    ## [226] "lars"                 "latex2exp"            "latticeExtra"        
    ## [229] "lava"                 "lavaan"               "lazyeval"            
    ## [232] "leaflet"              "leaps"                "LearnBayes"          
    ## [235] "lfe"                  "lme4"                 "lmtest"              
    ## [238] "loo"                  "lubridate"            "magick"              
    ## [241] "magrittr"             "manipulate"           "mapproj"             
    ## [244] "maps"                 "maptools"             "maptree"             
    ## [247] "mapview"              "markdown"             "MARSS"               
    ## [250] "MatrixModels"         "matrixStats"          "mclust"              
    ## [253] "meifly"               "meme"                 "memisc"              
    ## [256] "memoise"              "MEMSS"                "metricsgraphics"     
    ## [259] "microbenchmark"       "mime"                 "miniUI"              
    ## [262] "minqa"                "mlmRev"               "mnormt"              
    ## [265] "modeest"              "ModelMetrics"         "modelr"              
    ## [268] "modeltools"           "moments"              "MSBVAR"              
    ## [271] "multcomp"             "munsell"              "mvtnorm"             
    ## [274] "networkD3"            "Nippon"               "nloptr"              
    ## [277] "NLP"                  "NMF"                  "numDeriv"            
    ## [280] "nycflights13"         "odbc"                 "officer"             
    ## [283] "openNLP"              "openNLPdata"          "openssl"             
    ## [286] "optextras"            "optimx"               "osmar"               
    ## [289] "packrat"              "pacman"               "pander"              
    ## [292] "papeR"                "parsedate"            "partykit"            
    ## [295] "pbivnorm"             "pbkrtest"             "pdist"               
    ## [298] "PerformanceAnalytics" "pillar"               "pingr"               
    ## [301] "pkgconfig"            "pkgmaker"             "PKI"                 
    ## [304] "PKPDmodels"           "plm"                  "plogr"               
    ## [307] "plotly"               "plotrix"              "plyr"                
    ## [310] "png"                  "polyclip"             "prabclus"            
    ## [313] "praise"               "prediction"           "prettyR"             
    ## [316] "prettyunits"          "pROC"                 "processx"            
    ## [319] "prodlim"              "profileModel"         "profvis"             
    ## [322] "progress"             "proj4"                "proto"               
    ## [325] "protolite"            "pryr"                 "psych"               
    ## [328] "purrr"                "qdap"                 "qdapDictionaries"    
    ## [331] "qdapRegex"            "qdapTools"            "quadprog"            
    ## [334] "quantmod"             "quantreg"             "qvcalc"              
    ## [337] "R.cache"              "R.matlab"             "R.methodsS3"         
    ## [340] "R.oo"                 "R.rsp"                "R.utils"             
    ## [343] "R6"                   "RANN"                 "rappdirs"            
    ## [346] "raster"               "rbokeh"               "Rborist"             
    ## [349] "Rcgmin"               "Rclusterpp"           "RColorBrewer"        
    ## [352] "Rcpp"                 "RcppArmadillo"        "RcppEigen"           
    ## [355] "RcppRoll"             "RCurl"                "rdrop2"              
    ## [358] "readbitmap"           "readr"                "readxl"              
    ## [361] "recipes"              "RecordLinkage"        "RefManageR"          
    ## [364] "regexPipes"           "registry"             "rematch"             
    ## [367] "rematch2"             "repmis"               "ReporteRs"           
    ## [370] "ReporteRsjars"        "reports"              "repr"                
    ## [373] "reprex"               "reshape"              "reshape2"            
    ## [376] "reticulate"           "revealjs"             "rex"                 
    ## [379] "Rfacebook"            "rfoaas"               "rgdal"               
    ## [382] "rgeos"                "rgexf"                "rgl"                 
    ## [385] "RgoogleMaps"          "RGraphics"            "rhandsontable"       
    ## [388] "rJava"                "RJDBC"                "rjson"               
    ## [391] "RJSONIO"              "rlang"                "rlist"               
    ## [394] "rmapshaper"           "rmarkdown"            "RMySQL"              
    ## [397] "rngtools"             "robustbase"           "RocheTeradata"       
    ## [400] "ROCR"                 "Rook"                 "roxygen2"            
    ## [403] "rpart.plot"           "RPostgreSQL"          "rprojroot"           
    ## [406] "rPython"              "rsconnect"            "RSQLite"             
    ## [409] "rstan"                "rstanarm"             "rstantools"          
    ## [412] "rstudioapi"           "rticles"              "Rttf2pt1"            
    ## [415] "rversions"            "rvest"                "rvg"                 
    ## [418] "Rvmmin"               "RWDSverse"            "RWeka"               
    ## [421] "RWekajars"            "RWiener"              "sandwich"            
    ## [424] "satellite"            "scales"               "selectr"             
    ## [427] "servr"                "setRNG"               "sf"                  
    ## [430] "sfsmisc"              "shiny"                "shinyAce"            
    ## [433] "shinyBS"              "shinycssloaders"      "shinydashboard"      
    ## [436] "shinyjs"              "shinysense"           "shinystan"           
    ## [439] "shinytest"            "shinythemes"          "showimage"           
    ## [442] "signal"               "sjlabelled"           "sjmisc"              
    ## [445] "slam"                 "snakecase"            "snow"                
    ## [448] "SnowballC"            "sourcetools"          "sp"                  
    ## [451] "sparkline"            "sparklyr"             "SparseM"             
    ## [454] "spatstat"             "spatstat.data"        "spatstat.utils"      
    ## [457] "spdep"                "sqldf"                "srvyr"               
    ## [460] "StanHeaders"          "statmod"              "stringdist"          
    ## [463] "stringi"              "stringr"              "styler"              
    ## [466] "survey"               "svglite"              "svUnit"              
    ## [469] "swirl"                "syuzhet"              "tensor"              
    ## [472] "testit"               "testthat"             "tfplot"              
    ## [475] "tframe"               "TH.data"              "threejs"             
    ## [478] "tibble"               "tidyr"                "tidyselect"          
    ## [481] "tidyverse"            "tigris"               "tikzDevice"          
    ## [484] "timeDate"             "tm"                   "translations"        
    ## [487] "tree"                 "treemap"              "trimcluster"         
    ## [490] "truncnorm"            "tseries"              "tsfa"                
    ## [493] "TTR"                  "tufte"                "tuneR"               
    ## [496] "tweenr"               "ucminf"               "udunits2"            
    ## [499] "units"                "usethis"              "utf8"                
    ## [502] "uuid"                 "V8"                   "venneuler"           
    ## [505] "viridis"              "viridisLite"          "visNetwork"          
    ## [508] "WDI"                  "webdriver"            "webshot"             
    ## [511] "whisker"              "withr"                "wordcloud"           
    ## [514] "xgboost"              "xkcd"                 "xlsx"                
    ## [517] "xlsxjars"             "XML"                  "xml2"                
    ## [520] "XR"                   "XRJulia"              "XRPython"            
    ## [523] "xtable"               "xts"                  "yaml"                
    ## [526] "zip"                  "zoo"

    ## study package naming style (all lower case, contains '.', etc

    ## use `fields` argument to installed.packages() to get more info and use it!
    ipt2 <- installed.packages(fields = "URL") %>%
      as_tibble()
    ipt2 %>%
      mutate(github = grepl("github", URL)) %>%
      count(github) %>%
      mutate(prop = n / sum(n))

    ## # A tibble: 2 x 3
    ##   github     n  prop
    ##   <lgl>  <int> <dbl>
    ## 1 F        316 0.569
    ## 2 T        239 0.431
