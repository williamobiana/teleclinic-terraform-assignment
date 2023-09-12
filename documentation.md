## Objective

The objective of this Terraform script is to set up a static website hosting in an AWS S3 bucket. The bucket should be configured in such a way that it is publicly accessible, but with a policy in place to allow access only from specific IP addresses (in this case, "18.158.69.72" and "localhost").

## Reasons:
Based on the assignment given to deploy a simple index.html as static hosting.

Although there are other alternatives to approach this, such as using a docker container to deploy the site, AWS S3 is the cheapest and most effecient way.


## Steps and Outcome:
### Backend Configuration:
I create a backend for this project to ensure that the statefiles are always secure and cannot be accessed by unauthorized users.

I also added a dynamoDB table to ensure that mutiple admin users cannot run terraform apply simutaneously to the infrasture, this is important to avoid conflict.

### Provider Configuration:
I specify the AWS region to be used for this setup (us-east-1).

### Bucket Creation:
I create an S3 bucket named teleclinic-app-bucket-assignment" with the website configuration. The index document is set to "index.html".

#### Outcome: 
A new S3 bucket is created, ready to host the static website.

### Public Access Configuration:
I configure the bucket to allow public access. This means that the contents of the bucket, including "index.html", can be accessed by anyone with the appropriate URL.

#### Outcome: 
The bucket is set up to be publicly accessible.

### Ownership Control Configuration:
I set up ownership controls to ensure that objects in the bucket are owned by the bucket owner. This is important for controlling access and permissions.

#### Outcome: 
Ownership control is configured to enforce BucketOwnerPreferred ownership.

### Copying "index.html" to S3:
I upload the "index.html" file from the local system to the S3 bucket. The ACL (Access Control List) is set to "public-read" to allow public access to this file.

#### Outcome: 
"index.html" is uploaded to the S3 bucket and configured for public access.

### Policy for IP Restriction:
I create a policy that allows access to the S3 bucket only from specific IP addresses ("18.158.69.72" and "127.0.0.1"). All other IPs are denied access.

#### Outcome: 
A policy is in place to restrict access to the S3 bucket based on IP addresses.

### Outputs:
I provided an output with the website domain, which is the endpoint where the static website will be hosted.

#### Outcome: 
The website domain endpoint is provided for reference.
[Link to static hosting website](
teleclinic-app-bucket-assignment.s3-website-us-east-1.amazonaws.com)


## Usage
### State_bucket
Initialize and run the terraform main.tf in hidden `.state_bucket` folder to launch the terraform state bucket
```
terraform init
terraform plan
terraform apply
```

Once the state-bucket has been deployed, run a terraform destroy to clean up the resources, this will also ensure that we have a clean statefile we can use for the backend.

Make a copy of the empty statefile and save outsite the `.state_bucket` folder preferably in root folder (this empty state file will be uploaded to the state-bucket on s3 and would be used for our backend).

Go back into the `.state_bucket` run 
```
terraform apply
```

Access the aws console and upload the statefile into the created s3 bucket.

### App
With our state-bucket created, go to the `app` folder and simply run the commands
```
terraform init
terraform plan
terraform apply
```

The application (index.html) will initialize the backend from the `backend.tf` and deploy all resources contained in the `main.tf` and provide the website link to your terminal.

To see details of the code, you can view the terraform scripts in infrastructure/app folder

## Clean-Up
You can clean up the resources by running the command
```
terraform destory
```

Destory the resource in decending order in which it was created.

Start by running the destory command in `app` folder first, followed by the `.state_bucket` folder.