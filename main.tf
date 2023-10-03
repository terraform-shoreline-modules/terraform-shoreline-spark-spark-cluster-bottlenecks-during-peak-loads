terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "spark_cluster_bottlenecks_during_peak_loads" {
  source    = "./modules/spark_cluster_bottlenecks_during_peak_loads"

  providers = {
    shoreline = shoreline
  }
}