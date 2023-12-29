terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">=1.2"
    }
  }
}


provider "flux" {
  kubernetes = {
    config_path = "~/.kube/config"
  }

  git = {
    url = "ssh://git@github.com/MonBusinessApp/Infrastructure.git"
    ssh = {
      username    = "git"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

resource "flux_bootstrap_git" "this" {
  path             = "clusters/dev"
  components_extra = ["image-reflector-controller", "image-automation-controller"]
  version          = "v2.2.2"

}
