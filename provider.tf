# Google Provider
provider "google" {
  credentials = "credentials.json"
  project     = "f5-gdm-template-testing"
  region      = "us-east4"
  zone        = "us-east4-b"
}

