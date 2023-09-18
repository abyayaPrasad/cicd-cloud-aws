#!/usr/bin/env bash

ApplicationName="sc-data-orch" #sc-data-orch-fed-developer
GitRepo="cicd-cloud-aws" # Repo Name
CICDTemplate="cicd-pipeline-deploy.yml" # resources CFT relative path from script location
Region="us-west-2" # region
GitHubURL="https://github.com/abyayaPrasad/cicd-cloud-aws.git" # Github url
KMSKey="arn:aws:kms:us-west-2:767400217432:key/372d5fd9-9f9b-413f-ac15-5323bf125931" # KMS key arn - create KMS key add ARN here
NonProdBuildSpec="sc-data-orch/iaac/codebuild/update-lambda-buildspec.yml" # Buildspec file name
PreProdCICDBucket="sc-data-orch-test-preprod" # Prod s3 bucket name
ProdCICDBucket="sc-data-orch-test-preprod"
StageNameNonProd="dev"
Manifest="requirements.txt"
LogBucket="sc-data-orch-logs-bucket"
LambdaRoleArn="arn:aws:iam::767400217432:role/sc-data-orch-lambda-execution-role"


if [ "$#" -eq 1 ]; then
    aws codebuild start-build --project-name "${ApplicationName}-${GitRepo}-cicd-pipeline" --region 'us-gov-east-1' --buildspec-override "${NonProdBuildSpec}" --environment-variables-override name='STAGE_NAME',value=${StageNameNonProd},type='PLAINTEXT' name='LOG_BUCKET',value=${LogBucket},type='PLAINTEXT' 
else
  echo "Must provide gossamer3 aws profile"
fi