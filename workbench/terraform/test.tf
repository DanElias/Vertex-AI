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
  project      = "PROJECT-ID"
  gce_setup {
    container_image {
      repository = "us-docker.pkg.dev/deeplearning-platform-release/gcr.io/base-cu113.py310"
      tag = "latest"
    }
    metadata = {
      enable-guest-attributes = "true"
      report-system-health = "true"
    }
  }
}

resource "google_workbench_instance" "instance2" {
  name = "workbench-instance-with-metadata2"
  location = "us-west1-a"
  project      = "PROJECT-ID"
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