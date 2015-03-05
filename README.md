# Cloud meetup 2015 Budapest
Meetup presentation about Terraform at Cloud Meetup Budapest. 
Link: http://www.meetup.com/Cloud-Budapest/events/220555819/

## Presentation
To start it, just use the `start_presentation` script and go to localhost:8000. If not that, any HTTP server serving the `p` folder is ok.

## Terraform code
You need to set the access_key and the secret_key as a `terraform.tfvars` file, next to the meetup.tf file.
Define your credentials: 
```
access_key = "foo"
secret_key = "bar"
```

Commands I presented:

```bash
# Shows the plan
terraform plan
# Applies the changes to the infrastructure
terraform apply
# Prints the ip output variable
terraform output ip
# Refreshes the state stored 
terraform refresh
# Destroys our defined infrastructure
terraform destroy
```
