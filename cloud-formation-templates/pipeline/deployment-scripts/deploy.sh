#!/usr/bin/env bash

# Standard Fields
ApplicationName="sc-data-orch" #sc-data-orch-fed-developer
GitRepo="aws_rs_function_trigger_architecture" # Repo Name
CICDTemplate="cicd-pipeline-deploy.yml" # resources CFT relative path from script location
Region="us-east-1" # region
GitHubURL="https://github.com/abyayaPrasad/aws_rs_function_trigger_architecture" # Github url
KMSKey="" # KMS key arn - create KMS key add ARN here
BuildSpec="./cloud-formation-templates/pipeline/deployment-scripts/builspec-nonprod.yml" # Buildspec file name
ResourceTemplate="./cloud-formation-templates/pipeline/resources/lambda-function.yml" # Absolute path from repo
PreProdCICDBucket="" # Prod s3 bucket name
ProdCICDBucket=""
stage_name="dev" 


aws cloudformation deploy --no-verify-ssl --stack-name "${ApplicationName}-codebuild-promotion-${GitRepo}" --template-file ${CICDTemplate} --region ${Region} --role-arn arn:aws-us-gov:iam::279337964555:role/av-shoreline-cloudformation-promotion --parameter-overrides GitHubURL=${GitHubURL} KMSKey=${KMSKey} BuildSpec=${BuildSpec} Template=${ResourceTemplate} PreProdCICDBucket=${PreProdCICDBucket} ProdCICDBucket=${ProdCICDBucket} FileS3Prefix=${ApplicationName}-${GitRepo} Manifest=${Manifest}
