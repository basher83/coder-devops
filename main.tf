resource "coder_agent" "main" {
  os             = "linux"
  arch           = "amd64"
  startup_script = <<-EOT
    echo "Welcome to your DevOps workspace"
    exec zsh
  EOT
}
