## Metabase

Create an Metabase instance on Google Cloud Platform

### Resources
The module will create bellow resources on Google Cloud:
- Private VPC Network and Subnets
- Google Cloud Instance2
- Google Cloud Load Balancing
- Google Cloud SQL Instance

### Steps
Export Google Cloud Credentials and create a SSH key to allow us connecting on Instance via SSH:   
```
$ export GOOGLE_APPLICATION_CREDENTIALS={{Credentials Path}}
$ ssh-keygen -t rsa -f "gcp_instance" -C ""
```
Initialize the Terraform modules:
```
$ terraform init
```