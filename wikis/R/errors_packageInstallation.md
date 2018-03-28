# Troubleshooting errors for packages related to proper installation

## Error: (like)```the system can't move the file to the proper location:``

```
my.dir <- '~/my_R_libs' # for example
install.packages('car', lib=my.dir, destdir=my.dir)
library(car, lib=my.dir)
```
