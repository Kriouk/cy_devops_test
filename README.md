# Cycloid DevOps Test
Setup a wordpress container on an ECS cluster.

## Disclaimer

First of all, I want to be transparent about the conditions for carrying out this test:

1. Until now, I had no knowledge of Packer
2. Some knowledge of AWS, but very basic
3. Ditto for Terraform
4. For the Terraform part, I was inspired by the examples offered by AWS

I therefore want to clarify (spoiler alert) **that this project could not be completed in its entirety** (and that it is even quite frustrating). I am then taker of correction(s), good practice(s) and feedback if possible.

## What you have done ?

I carried out this project starting from a CI/CD logic with the use of GitHub Actions. Familiar with GitLab, I told myself that this project is also a good challenge to test more Actions. Yes, I like to add one or more additional objectives :stuck_out_tongue:

Thus, the different GitHub WorkFlows perform the following actions *(without puns)*:

### AWS_Infra (automatic trigger on changes in the terraform folder)

Creates the target AWS infrastructure using Terraform and a single Actions job:

1. Creating an image repository through Amazon ECR
2. Creation of an RDS database under MySQL
3. Create a VPC containing
   1. 3 AZs
   2. 3 private subnets for EC2 instances of the ECS cluster
   3. 3 public subnets for the LoadBalancing part (ELB / ALB?)
   4. 3 subnets for the RDS database
4. Creation of a security group for the database

### Wordpress (automatic trigger on changes in the ansible/packer folders)

2 Actions specific jobs to Wordpress:

1. Creation of the Wordpress image (partial) with Packer & Ansible
2. Push the image to the GitHub repository
3. Image push on the ECR instance created by the previous workflow

The beautiful mermaid diagram below sums it up nicely.

[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggTFJcbnN1YmdyYXBoIHdfc1tXb3JrZmxvd3MgU2NoZW1hXVxuXG4gICAgR0lUSFVCKEdpdEh1YiBSZXBvc2l0b3J5KVxuXG4gICAgc3ViZ3JhcGggZ19hW0dpdEh1YiBBY3Rpb25zXVxuICAgICAgICBBV1NfSW5mcmFbQVdTX0luZnJhXTo6OkdBXG4gICAgICAgIHdvcmRwcmVzc1t3b3JkcHJlc3NdOjo6R0FcbiAgICAgICAgbnVrZVtudWtlXTo6OkdBXG4gICAgZW5kXG4gICAgc3ViZ3JhcGggYXdzX3JbQVdTXVxuICAgICAgICBFQ1IoRUNSKTo6OkFXU1xuICAgICAgICBSRFMoUkRTKTo6OkFXU1xuICAgICAgICBWUEMoVlBDL1NHKTo6OkFXU1xuICAgICAgICBTMyhTMylcbiAgICBlbmRcblxuICAgIEFXU19JbmZyYSAtLT58Q3JlYXRlfCBSRFMgJiBWUEMgJiBFQ1JcbiAgICBBV1NfSW5mcmEgLS0tfFRlcnJhZm9ybSBzdGF0ZXwgUzNcbiAgICB3b3JkcHJlc3MtLT58QnVpbGQgRG9ja2VyIEltYWdlIGFuZCBwdXNoIHRvfCBFQ1IgJiBHSVRIVUJcbiAgICBudWtlIC0tPnxEZXN0cm95IHwgRUNSICYgVlBDICYgUkRTXG5lbmRcblxubGlua1N0eWxlIDAgc3Ryb2tlOiM3ZWU3YTZcbmxpbmtTdHlsZSAxIHN0cm9rZTojN2VlN2E2XG5saW5rU3R5bGUgMiBzdHJva2U6IzdlZTdhNlxubGlua1N0eWxlIDUgc3Ryb2tlOiMzM2E0ZWFcbmxpbmtTdHlsZSA0IHN0cm9rZTojMzNhNGVhXG5saW5rU3R5bGUgMyBzdHJva2U6IzMzYTRlYVxubGlua1N0eWxlIDYgc3Ryb2tlOiNmNjYsZmlsbDpub25lLHN0cm9rZS1kYXNoYXJyYXk6M1xubGlua1N0eWxlIDcgc3Ryb2tlOiNmNjYsZmlsbDpub25lLHN0cm9rZS1kYXNoYXJyYXk6M1xubGlua1N0eWxlIDggc3Ryb2tlOiNmNjYsZmlsbDpub25lLHN0cm9rZS1kYXNoYXJyYXk6M1xuXG5jbGFzc0RlZiBHQSBmaWxsOiM2ZmEsc3Ryb2tlOiMzMzMsc3Ryb2tlLXdpZHRoOjFweFxuY2xhc3NEZWYgQVdTIGZpbGw6I2NiZixzdHJva2U6IzMzMyxzdHJva2Utd2lkdGg6MXB4XG5cbnN0eWxlIGdfYSBmaWxsOiNjNWU1Zjksc3Ryb2tlOiNmNjYsc3Ryb2tlLXdpZHRoOjJweCxjb2xvcjojZmZmLHN0cm9rZS1kYXNoYXJyYXk6IDUsIDVcbnN0eWxlIGF3c19yIGZpbGw6I2ZmZGY2MyxzdHJva2U6I2Y2NixzdHJva2Utd2lkdGg6MnB4LGNvbG9yOiNmZmYsc3Ryb2tlLWRhc2hhcnJheTogNSwgNVxuXG5zdHlsZSB3X3MgZmlsbDojZmZmLHN0cm9rZTojZjY2LHN0cm9rZS13aWR0aDoycHgsY29sb3I6I2Y2NixzdHJva2UtZGFzaGFycmF5OiAzLCAzIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)](https://mermaid-js.github.io/mermaid-live-editor/#/edit/eyJjb2RlIjoiZ3JhcGggTFJcbnN1YmdyYXBoIHdfc1tXb3JrZmxvd3MgU2NoZW1hXVxuXG4gICAgR0lUSFVCKEdpdEh1YiBSZXBvc2l0b3J5KVxuXG4gICAgc3ViZ3JhcGggZ19hW0dpdEh1YiBBY3Rpb25zXVxuICAgICAgICBBV1NfSW5mcmFbQVdTX0luZnJhXTo6OkdBXG4gICAgICAgIHdvcmRwcmVzc1t3b3JkcHJlc3NdOjo6R0FcbiAgICAgICAgbnVrZVtudWtlXTo6OkdBXG4gICAgZW5kXG4gICAgc3ViZ3JhcGggYXdzX3JbQVdTXVxuICAgICAgICBFQ1IoRUNSKTo6OkFXU1xuICAgICAgICBSRFMoUkRTKTo6OkFXU1xuICAgICAgICBWUEMoVlBDL1NHKTo6OkFXU1xuICAgICAgICBTMyhTMylcbiAgICBlbmRcblxuICAgIEFXU19JbmZyYSAtLT58Q3JlYXRlfCBSRFMgJiBWUEMgJiBFQ1JcbiAgICBBV1NfSW5mcmEgLS0tfFRlcnJhZm9ybSBzdGF0ZXwgUzNcbiAgICB3b3JkcHJlc3MtLT58QnVpbGQgRG9ja2VyIEltYWdlIGFuZCBwdXNoIHRvfCBFQ1IgJiBHSVRIVUJcbiAgICBudWtlIC0tPnxEZXN0cm95IHwgRUNSICYgVlBDICYgUkRTXG5lbmRcblxubGlua1N0eWxlIDAgc3Ryb2tlOiM3ZWU3YTZcbmxpbmtTdHlsZSAxIHN0cm9rZTojN2VlN2E2XG5saW5rU3R5bGUgMiBzdHJva2U6IzdlZTdhNlxubGlua1N0eWxlIDUgc3Ryb2tlOiMzM2E0ZWFcbmxpbmtTdHlsZSA0IHN0cm9rZTojMzNhNGVhXG5saW5rU3R5bGUgMyBzdHJva2U6IzMzYTRlYVxubGlua1N0eWxlIDYgc3Ryb2tlOiNmNjYsZmlsbDpub25lLHN0cm9rZS1kYXNoYXJyYXk6M1xubGlua1N0eWxlIDcgc3Ryb2tlOiNmNjYsZmlsbDpub25lLHN0cm9rZS1kYXNoYXJyYXk6M1xubGlua1N0eWxlIDggc3Ryb2tlOiNmNjYsZmlsbDpub25lLHN0cm9rZS1kYXNoYXJyYXk6M1xuXG5jbGFzc0RlZiBHQSBmaWxsOiM2ZmEsc3Ryb2tlOiMzMzMsc3Ryb2tlLXdpZHRoOjFweFxuY2xhc3NEZWYgQVdTIGZpbGw6I2NiZixzdHJva2U6IzMzMyxzdHJva2Utd2lkdGg6MXB4XG5cbnN0eWxlIGdfYSBmaWxsOiNjNWU1Zjksc3Ryb2tlOiNmNjYsc3Ryb2tlLXdpZHRoOjJweCxjb2xvcjojZmZmLHN0cm9rZS1kYXNoYXJyYXk6IDUsIDVcbnN0eWxlIGF3c19yIGZpbGw6I2ZmZGY2MyxzdHJva2U6I2Y2NixzdHJva2Utd2lkdGg6MnB4LGNvbG9yOiNmZmYsc3Ryb2tlLWRhc2hhcnJheTogNSwgNVxuXG5zdHlsZSB3X3MgZmlsbDojZmZmLHN0cm9rZTojZjY2LHN0cm9rZS13aWR0aDoycHgsY29sb3I6I2Y2NixzdHJva2UtZGFzaGFycmF5OiAzLCAzIiwibWVybWFpZCI6eyJ0aGVtZSI6ImRlZmF1bHQifSwidXBkYXRlRWRpdG9yIjpmYWxzZX0)

## How did you run your project ?

The idea is to simply create a fork of this project, fill in the necessary secrets, perform a few more small manipulations on GitHub & AWS and voila. Simple, isn't it?

Let's go into detail:

1. Activate the use of the GitHub Container Registry on [your GitHub profile](https://docs.github.com/en/packages/guides/enabling-improved-container-support#enabling-github-container-registry-for-your-personal-account)
2. Choose a region that can accommodate the AWS infrastructure items discussed above. Here eu-west-3. :warning: To remain consistent with the configuration of this project, please choose a region with 3 availability zones
3. Create an S3 bucket that can accommodate the Terraform state file (and enable versioning preferably)
4. Fork the project
5. Create the following Actions secrets (you can modify the values except when specified otherwise), in the "Settings" tab of the GitHub project then in "Secrets". Here a list of the secrets needed.
   1. **AWS_ACCESS_KEY** : ***
   2. **AWS_SECRET_KEY** : ***
   3. **AWS_REGION** : chosen value "eu-west-3"
   4. **ECR_REPOSITORY** : chosen value "wordpress"
   5. **REGISTRY_URL** : here we are targeting the GitHub registry first so please fill in **ghcr.io**
   6. **DOCKER_IMAGE_NAME** : name of the image stored on GitHub/ECR, chosen value "wordpress-image"
   7. **S3_BUCKET_NAME** : name of the bucket created just before, chosen value"cy-tf-state-bucket"
   8. **RDS_NAME** : enough speaking, chosen value "testingdb"
   9. **RDS_USER** : RDS database username, here "toto"
   10. **RDS_PASS** : password (> 8 characters)

Then you can start the "AWS_Infra" workflow by adding a file to the terraform folder from GitHub. Ditto for the "Wordpress" workflow by adding / modifying a file in the packer or ansible folder.

Finally, to delete the infrastructure created by "AWS_Infra", you can manually launch the "nuke" / "Deleting the Infrastructure" Workflow manually from the Actions tab of the project. Don't forget to select the target branch when you click on "Run workflow"

## What are the components interacting with each other ?

To date, only GitHub interacts quite favorably with AWS. The use of the Wordpress workflow and the generation of the image (although very incomplete in its configuration) is correctly carried out by the use of Packer/Ansible then pushed on GitHub and the ECR repository. I also find the idea of linking the Wordpress image to the project repository interesting in order to, why not, keep a certain distance with ECR, have test images that can be used by other cloud providers/environments, etc.

Then, the **AWS_Infra** workflow does not go very far by creating "only" the RDS database of type MySQL, and a VPC (+ security group dedicated to RDS) with just what is needed for the ECS part (ECS on Fargate). These are the limits of my knowledge accumulated after a very rewarding week (and high dose of coffee). I could have "taken" a little more inspiration from the AWS examples, but I hate not knowing exactly what I'm doing :)

## What problems did you encounter ?

In fact. A lot... Partly because I persisted in running this project in CI/CD and also, in particular because of my lack of experience on some target technologies. But I did not give up so far ! :muscle:

1. [Packer and Docker (issue #7)](https://github.com/ChamMach/cy_devops_test/issues/7)
2. "Basic" problems with Terraform: Terraform state & S3 backend, passage of variables between modules ...
3. Create the S3 bucket automatically and use it so that it can contain the terraform state file. Unfortunately, I did not pass this step. Hence the fact that you have to create the bucket manually.
4. The AWS network part. Originally from a system/network study and having already worked (more or less) with AWS/Azure, I understand some principles and solutions available (VPC, LB, AZs, SG, HA etc.). However I had no time to go in depth to learn what I was missing and come up with something "production ready". This is one of the biggest lack of this rendering in my opinion

## How would you have done things to have the best HA/automated architecture ?

While I'm not yet familiar with *all* the intricacies of AWS, I think the following options may be considered.

### Automation

Further improve the CI / CD with test jobs, image scanning and vulnerability ([with Trivy for example](https://github.com/marketplace/actions/aqua-security-trivy) etc. Then why not increase the use of Ansible (use of Jinja templates, handlers ...) for the generation of the image and the execution of tests. Do not forget Terraform too, which must surely be improved to be reusable for example .

### HA

[Make RDS Database resilient with Amazon Aurora or Multi-AZ/ Multi-Region Deployment](https://aws.amazon.com/fr/rds/features/multi-az/)

For the ECS part, why not use more [Fargate](https://docs.aws.amazon.com/fr_fr/AmazonECS/latest/developerguide/AWS_Fargate.html) which seems to ensure a certain high availability of ECS tasks and a simpler infrastructure administration.


## Share with us any ideas you have in mind to improve this kind of infrastructure.

Make Wordpress containers created on ECS as *stateless* as possible, for example by [using Amazon EFS](https://aws.amazon.com/en/blogs/storage/optimizing-wordpress-performance-with-amazon-efs/)

**Improve the network part:**

- NAT Gateway for internet access
- ELB / ALB? for the HA/scalability of the ECS part
- Give a DNS name to the RDS instance, making it easier to configure the Wordpress image
- Surely other things that escape me for the moment

And, in bulk:

- Use a certificate to access the Wordpress site in HTTPS
- Improve performance on the PHP side using OPcache and other tips
- Activate Cloudwatch & Cloudwatch Logs to have metrics / logs from Wordpress, RDS database etc.
- Do not use the latest versions of images, be in a perspective of mastering the lifecycle of the infrastructure/web application
- Monitoring and analysis with Grafana and/or Elastic
- Using a Vault
- Reduction of the size of the Wordpress image and [compliance with best practices in the creation of containers, use of a registry and public images ...](https://cloud.google.com/solutions/best-practices-for-building-containers?hl=fr)

## Tomorrow we want to put this project in production. What would be your advice and choices to achieve that ?

This is where my little experience will perhaps be felt the most. But in my opinion it is necessary to ensure that the infrastructure is resilient, secure, efficient and meets bests practices. For example: [the 12 factors](https://12factor.net/), [AWS best practices for architectures](https://aws.amazon.com/fr/architecture/well-architected/?wa-lens-whitepapers.sort-by=item.additionalFields.sortDate&wa-lens-whitepapers.sort-order=desc) ...

In support, have one (or more?) test/staging environments (and pipelines) to prevent deployment incidents, manage the infrastructure/application lifecycle, etc.

Then finally, ensure the run/day 2 of the project in production: alerting mechanism such as Cloudwatch Alarms, update process, backup, rollback, incident management, request management and feedback (use of the project's GitHub issues?) etc.
