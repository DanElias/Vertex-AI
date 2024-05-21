You can read more about terraform
[here](https://developer.hashicorp.com/terraform/intro)

## Terraform for Vertex AI Workbench

-   Workbench Instances:
    [google_workbench_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/workbench_instance)

### Deprecated Terraform resources

-   User-managed notebooks:
    [google_notebooks_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_instance)

-   Managed notebooks:
    [google_notebooks_runtime](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/notebooks_runtime)

### Run Terraform
1.  Install terraform: run **all** the commands for Linux > Ubuntu/Debian
    specified in the
    [terraform installation guide](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli#install-terraform)
1.  Verify terraform was installed by running `terraform --version`
1.  On your Jupyterlab, create a new file. Name it: `test.tf`
1.  Copy the following terraform template code and replace the `project_id`

```
  terraform {
    required_providers {
      google = {
        source  = "hashicorp/google"
        version = "= 5.24.0"
      }
    }
  }

  resource "google_workbench_instance" "instance" {
    name = "workbench-instance-with-metadata"
    location = "us-west1-a"
    project      = "PROJECT_ID"
    gce_setup {
      container_image {
        repository = "us-docker.pkg.dev/deeplearning-platform-release/gcr.io/base-cu113.py310"
        tag = "latest"
      }
      metadata = {
        enable-guest-attributes = "true"
        report-event-health = "true"
      }
    }
  }
```

1.  Back in the terminal, run: `terraform init`. This will initialize terraform
1.  Run `terraform apply`. This will run the terraform files that are in the
    current working directory
1.  Terraform will show you a "execution plan", review it. Then type `yes`
1.  Terraform will proceed to make changes in your GCP project. Some operations
    might take more than 10 minutes to complete.

NOTE: Terraform will keep track of all your `.tf` files and their state. Any
small change to the `.tf` files might result in terraform deciding to replace or
destroy your GCP resources when you run `terraform apply` again. This is why you
need to review the "execution plan" carefully