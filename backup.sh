#!/bin/bash

aws configure set aws_access_key_id $S3_ACCESS_KEY_ID
aws configure set aws_secret_access_key $S3_SECRET_ACCESS_KEY
aws configure set default.region $S3_REGION
aws configure set region $S3_REGION --profile default

filename=`date +%Y-%m-%d_at_%H-%M-%S`_all.sql
pg_dumpall -h $PGHOST -p $PGPORT -U $PGUSER > $filename
tar -zcf $filename.tar.gz $filename
aws s3 cp $filename.tar.gz $S3_DESTINATION/$filename.tar.gz
