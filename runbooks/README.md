# runbooks

## Summary

It finally happened. Someone on the team won the lottery, dropped a 👋 for the
team on Slack and took the first flight to Thailand. Some fragile aspect of our
infrastructure is failing and you need to repair it. Well, you're in the right
spot. Our runbooks will attempt to provide all the information you need to
rebuild or troubleshoot each aspect of our infrastructure.

## Table of contents

- [Summary](#summary)
- [Table of contents](#table-of-contents)
- [Infrastructure components](#infrastructure-components)
    - [Deployment pipelines](#deployment-pipeline)
        - [Pipeline architecture overview](#pipeline-architecture-overview)
        - [Receiving GitHub webhooks](#receiving-github-webhooks)
        - [CodePipeline](#codepipeline)
        - [Kubernetes deployments](#kubernetes-deployments)

## Infrastructure components

### Deployment pipeline

#### Pipeline architecture overview

The pipeline is broken up into two components. Our modified version of git2s3
and a separate CloudFormation stack that builds a CodePipeline for each project.

#### Receiving GitHub webhooks

The git2s3 CloudFormation stack will build the resources we need in AWS to
consume webhooks from GitHub.

#### CodePipeline

The CodePipelines will look for a specific object in the git2s3 S3 bucket to
start a build and pass a build artifact into CodeBuild.

#### Kubernetes deployments

Deployments need to use the `buildspec.yml` in the project source repository and
then reference information in AWS Parameter Store to successfully run `kubectl
apply` with a template that is rendered with Helm during the build.

