bash

#!/bin/bash



# Set the Spark configuration variables

SPARK_WORKER_INSTANCES=${NUMBER_OF_WORKER_NODES}

SPARK_WORKER_MEMORY=${MEMORY_ALLOCATION_PER_NODE}



# Update the Spark configuration file

sudo sed -i "s/spark.worker.instances.*/spark.worker.instances $SPARK_WORKER_INSTANCES/" ${SPARK_CONFIG_FILE_PATH}

sudo sed -i "s/spark.worker.memory.*/spark.worker.memory $SPARK_WORKER_MEMORY/" ${SPARK_CONFIG_FILE_PATH}



# Restart the Spark cluster

sudo systemctl restart spark