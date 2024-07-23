terraform {
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "= 5.38.0"
        }
    }
}

resource "google_compute_network" "network" {
    name = "worbench-network-05"
    auto_create_subnetworks = false
    routing_mode = "REGIONAL"
    project = "PROJECT-ID"
}

resource "google_compute_subnetwork" "subnetwork" {
    project = "PROJECT-ID"
    network = "worbench-network-05"
    name = "workbench-subnetwork-05"
    ip_cidr_range = "192.171.1.0/24"
    region = "us-west1"
    private_ip_google_access = true
    secondary_ip_range = []
    log_config {
        # default log_config settings
        aggregation_interval = "INTERVAL_5_SEC"
        flow_sampling = 1
        metadata = "INCLUDE_ALL_METADATA"
    }
    
    depends_on = [google_compute_network.network]
}

resource "google_workbench_instance" "workbench-instance-with-subnetwork" {
    project  = "PROJECT-ID"
    name     = "workbench-instance-with-subnetwork-05"
    location = "us-west1-a"
    gce_setup {
      machine_type = "e2-standard-4"
      disable_public_ip = true
      boot_disk {
        disk_size_gb = 150
        disk_type    = "PD_BALANCED"
      }
      data_disks {
        disk_size_gb = 100
        disk_type    = "PD_BALANCED"
      }
      vm_image {
        project = "cloud-notebooks-managed"
        family  = "workbench-instances"
      }
      metadata = {
        serial-port-logging-enable = true
        report-event-health        = true
        terraform                  = true
        report-dns-resolution      = true
        disable-mixer              = true
        idle-timeout-seconds       = 10800
      }
      network_interfaces {
            network = google_compute_network.network.id
            subnet = google_compute_subnetwork.subnetwork.id
        }
    }
    instance_owners      = []
    disable_proxy_access = false
    desired_state        = "ACTIVE"
    
    depends_on = [google_compute_subnetwork.subnetwork]
}
