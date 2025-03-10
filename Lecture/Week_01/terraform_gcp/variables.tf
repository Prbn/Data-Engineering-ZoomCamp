
variable "credentials" {
  description = "My Credentials"
  default     = "/Users/prbnrs/.keys/.gc/ny-rides-prbn.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "ny-rides-prbn"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default = "us-central1"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default = "US"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default = "terraform-demo-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

variable "gcp_service_acc_name" {
  description = "GCP Service Account Name"
  default     = "STANDARD"
}

variable "gcp_service_acc_email" {
  description = "GCP Service Account Email"
  default     = "terraform-runner@ny-rides-prbn.iam.gserviceaccount.com"
}

variable "gci_name" {
  description = "Google Compute Instance Name"
  #Update the below to what you want your Compute Instance to be called
  default = "dezc-1"
}

variable "gci_image" {
  description = "Google Compute Instance Image"
  #Update the below to what Compute Instance Image you want
  default = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20250213"
}

variable "gci_disk_size" {
  description = "Google Compute Instance disk Size in GB"
  #Update the below to what Compute Instance disk Size you want
  default = 30
}

variable "gci_machine_type" {
  description = "Google Compute Instance Machine Type"
  #Update the below to what Compute Instance Machine Type you want
  default = "e2-standard-4"
}

variable "gci_zone" {
  description = "Google Compute Instance Zone"
  #Update the below to what Compute Instance Machine Type you want
  default = "us-central1-c"
}


