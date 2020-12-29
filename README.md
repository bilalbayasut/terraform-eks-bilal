This repo containing Terraform configuration files to provision an EKS cluster on AWS.

- create workspace by running `terraform workspace new staging` do the same for production
- populate appropriate variable files dependending on your environment (staging or production)

# update kubeconfig

put your cluster name and region (optional: this will be done automatically by terraform)
`aws eks update-kubeconfig --name getting-started-eks --region ap-southeast-2`

# note

if your kubernetes cluster create a service, it triggers classic load balancer on AWS and it's not mapped by terraform,
thus, this must be noted and deleted first manually (at least for now)

# creating IAM groups, users, group-policies
- Need to install Keybase in our local https://keybase.io/download
- need to create Keybase key by using `keybase pgp gen`
- then give the reference of this Keybase key in your terraform code `Keybase:username_of_keybase`
- Then `terraform apply --var-files=staging.env --auto-approve`
- Then we need to get the decrypted password `terraform output password | base64 --decode | keybase pgp decrypt`
- login as iam user and change your password, you should be able to logged in

# workarround for terraform destroy
1. Use target mode to destroy only the EKS cluster: terraform destroy -target module.eks
2. Subsequently, set the create_eks flag to false after the first step
3. Run an apply to clean up the old cluster configuration. terraform apply

or
terraform state rm module.eks.kubernetes_config_map.aws_auth
terraform destroy

## Load balancer
1. Create IAM OIDC provider
2. Download IAM policy for the AWS Load Balancer Controller
3. Create an IAM policy called AWSLoadBalancerControllerIAMPolicy
4. Create a IAM role and ServiceAccount for the Load Balancer controller, use the ARN from the step above
### Installing the chart
1. Add the EKS repository to Helm: `helm repo add eks https://aws.github.io/eks-charts`
2. Install the TargetGroupBinding CRDs: `kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master"`
3. Install the AWS Load Balancer controller, if using iamserviceaccount: 
    ```
    helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=<k8s-cluster-name> --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
    ```