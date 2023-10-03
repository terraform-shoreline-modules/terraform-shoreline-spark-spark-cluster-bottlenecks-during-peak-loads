resource "shoreline_notebook" "spark_cluster_bottlenecks_during_peak_loads" {
  name       = "spark_cluster_bottlenecks_during_peak_loads"
  data       = file("${path.module}/data/spark_cluster_bottlenecks_during_peak_loads.json")
  depends_on = [shoreline_action.invoke_check_cluster_status,shoreline_action.invoke_update_spark_config]
}

resource "shoreline_file" "check_cluster_status" {
  name             = "check_cluster_status"
  input_file       = "${path.module}/data/check_cluster_status.sh"
  md5              = filemd5("${path.module}/data/check_cluster_status.sh")
  description      = "Insufficient resources allocated to the Spark cluster, leading to bottlenecks during peak loads."
  destination_path = "/agent/scripts/check_cluster_status.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "update_spark_config" {
  name             = "update_spark_config"
  input_file       = "${path.module}/data/update_spark_config.sh"
  md5              = filemd5("${path.module}/data/update_spark_config.sh")
  description      = "Optimize the Spark cluster configuration by increasing the number of worker nodes and memory allocation per node to handle peak loads."
  destination_path = "/agent/scripts/update_spark_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_check_cluster_status" {
  name        = "invoke_check_cluster_status"
  description = "Insufficient resources allocated to the Spark cluster, leading to bottlenecks during peak loads."
  command     = "`chmod +x /agent/scripts/check_cluster_status.sh && /agent/scripts/check_cluster_status.sh`"
  params      = []
  file_deps   = ["check_cluster_status"]
  enabled     = true
  depends_on  = [shoreline_file.check_cluster_status]
}

resource "shoreline_action" "invoke_update_spark_config" {
  name        = "invoke_update_spark_config"
  description = "Optimize the Spark cluster configuration by increasing the number of worker nodes and memory allocation per node to handle peak loads."
  command     = "`chmod +x /agent/scripts/update_spark_config.sh && /agent/scripts/update_spark_config.sh`"
  params      = ["SPARK_CONFIG_FILE_PATH","MEMORY_ALLOCATION_PER_NODE","NUMBER_OF_WORKER_NODES"]
  file_deps   = ["update_spark_config"]
  enabled     = true
  depends_on  = [shoreline_file.update_spark_config]
}

