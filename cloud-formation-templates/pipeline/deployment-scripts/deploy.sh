#!/usr/bin/env bash

# Standard Fields
ApplicationName="sc-data-orch" #sc-data-orch-fed-developer
GitRepo="cicd-cloud-aws" # Repo Name
CICDTemplate="cicd-pipeline-deploy.yml" # resources CFT relative path from script location
Region="us-west-2" # region
GitHubURL="https://github.com/abyayaPrasad/cicd-cloud-aws.git" # Github url
KMSKey="" # KMS key arn - create KMS key add ARN here
NonProdBuildSpec="./cloud-formation-templates/pipeline/deployment-scripts/builspec-nonprod.yml" # Buildspec file name
ResourceTemplate="./cloud-formation-templates/pipeline/resources/lambda-function.yml" # Absolute path from repo
PreProdCICDBucket="sc-data-orch-test-preprod" # Prod s3 bucket name
ProdCICDBucket="sc-data-orch-test-preprod"
stage_name="dev"


aws cloudformation deploy --no-verify-ssl --stack-name "${ApplicationName}-codebuild-promotion-${GitRepo}" --template-file ${CICDTemplate} --region ${Region} --role-arn arn:aws:iam::767400217432:role/sc-cloudformation-deploy-role --parameter-overrides GitHubURL=${GitHubURL} KMSKey=${KMSKey} NonProdBuildSpec=${NonProdBuildSpec} Template=${ResourceTemplate} PreProdCICDBucket=${PreProdCICDBucket} ProdCICDBucket=${ProdCICDBucket} FileS3Prefix=${ApplicationName}-${GitRepo} Manifest=${Manifest}
