# Basic dev container for R

Before you run it, make a `.env` file with:

```env
WORKING_DIR="path/to/your/work-directory"
RENV_CACHE_PATH="path/to/your/local/renv/cache"
```

The renv cache of the container will be mounted on your local cache, in order to speed up (reuse and recycle) the installation of R packages.