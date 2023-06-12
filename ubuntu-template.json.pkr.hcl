source "virtualbox-iso" "autogenerated_1" {
  boot_command = [
    "c<wait>",
    "linux /casper/vmlinuz autoinstall ",
    #"ds=nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}} ",
    "ds=\"nocloud-net;s=http://{{ .HTTPIP }}:{{.HTTPPort}}/\"<enter>",
    "initrd /casper/initrd<enter>",
    "boot<enter>",
    "<wait4m>"
  ]
  boot_wait         = "5s"
  disk_size         = 50000
  guest_os_type     = "Ubuntu_64"
  headless          = "false"
  http_directory    = "http"
  iso_checksum      = "sha256:5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
  iso_url           = "https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso"
  # iso_url           = "https://releases.ubuntu.com/22.04.2/ubuntu-22.04.2-live-server-amd64.iso"
  output_directory  = "output-ubuntu"
  shutdown_command  = "sudo shutdown -h now"
  ssh_username      = "ubuntu"
  ssh_password      = "ubuntu"
  ssh_timeout       = "60m"
  vboxmanage        = [
    ["modifyvm", "{{ .Name }}", "--memory", 8192], 
    ["modifyvm", "{{ .Name }}", "--cpus", 4],
    ["modifyvm", "{{ .Name }}", "--vram", "12"],
    ["modifyvm", "{{ .Name }}", "--graphicscontroller", "vmsvga"],
	["modifyvm", "{{ .Name }}", "--nat-localhostreachable1", "on"]]
}

build {
  sources = ["source.virtualbox-iso.autogenerated_1"]

  provisioner "shell" {
    scripts = ["test-script.sh"]
  }

}
