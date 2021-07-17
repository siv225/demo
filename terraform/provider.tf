provider "aws" {
	region = "us-east-2"
}

provider "google" {
  project = "acme-app"
  region  = "us-central1"
}

provider "azurerm" {
  features {}
}
