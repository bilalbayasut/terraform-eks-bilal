This repo containing Terraform configuration files to provision an EKS cluster on AWS.

- create workspace by running `terraform workspace new staging` do the same for production
- populate appropriate variable files dependending on your environment (staging or production)

# update kubeconfig

put your cluster name and region
aws eks update-kubeconfig --name getting-started-eks --region ap-southeast-2
