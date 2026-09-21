<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-09-21</p>
<!-- markdownlint-enable  MD033 MD041-->

### Remove unnecessary Fedora repositories

#### Fedora `rpms/`[`fedora-workstation-repositories`](https://src.fedoraproject.org/rpms/fedora-workstation-repositories)

```plain
sudo dnf remove fedora-workstation-repositories
```

- repo files:  
`/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo`  
`/etc/yum.repos.d/`[`google-chrome.repo`](https://src.fedoraproject.org/rpms/fedora-workstation-repositories/blob/rawhide/f/google-chrome.repo)  
`/etc/yum.repos.d/`[`rpmfusion-nonfree-nvidia-driver.repo`](https://src.fedoraproject.org/rpms/fedora-workstation-repositories/blob/rawhide/f/rpmfusion-nonfree-nvidia-driver.repo)  
`/etc/yum.repos.d/`[`rpmfusion-nonfree-steam.repo`](https://src.fedoraproject.org/rpms/fedora-workstation-repositories/blob/rawhide/f/rpmfusion-nonfree-steam.repo)

#### Fedora `rpms/`[`adoptium-temurin-java-repository`](https://src.fedoraproject.org/rpms/adoptium-temurin-java-repository)

```plain
sudo dnf remove adoptium-temurin-java-repository
```

- repo file:  
`/etc/yum.repos.d/`[`adoptium-temurin-java-repository.repo`](https://src.fedoraproject.org/rpms/adoptium-temurin-java-repository/blob/rawhide/f/adoptium-temurin-java-repository.repo)

---

### Visual Studio Code

```plain
sudo curl https://raw.githubusercontent.com/musinsky/config/master/yum.repos.d/vscode.repo \
     --output-dir /etc/yum.repos.d/ --remote-name
```

```plain
sudo dnf install code
```

### eduVPN for Linux 4.x

```plain
sudo curl https://app.eduvpn.org/linux/v4/rpm/app+linux@eduvpn.org.asc \
     --output /etc/pki/rpm-gpg/RPM-GPG-KEY-python-eduvpn-client_v4
sudo curl https://raw.githubusercontent.com/musinsky/config/master/yum.repos.d/python-eduvpn-client_v4.repo \
     --output-dir /etc/yum.repos.d/ --remote-name
```

```plain
sudo dnf install eduvpn-client
```

### AlmaLinux 9 (selected pkgs for Fedora only) - CERN

```plain
sudo curl https://raw.githubusercontent.com/musinsky/config/master/yum.repos.d/cern-almalinux.repo \
     --output-dir /etc/yum.repos.d/ --remote-name
sudo dnf install cern-gpg-keys --no-gpgchecks
```

```plain
sudo dnf install CERN-CA-certs
```

### Adoptium Temurin Java

```plain
# sudo dnf remove adoptium-temurin-java-repository
sudo curl https://raw.githubusercontent.com/musinsky/config/master/yum.repos.d/adoptium-temurin-java.repo \
     --output-dir /etc/yum.repos.d/ --remote-name
```

```plain
sudo dnf --repo=adoptium-temurin-java list --available
```

### Google Chrome

```plain
# sudo dnf remove fedora-workstation-repositories
sudo curl https://raw.githubusercontent.com/musinsky/config/master/yum.repos.d/google-chrome.repo \
     --output-dir /etc/yum.repos.d/ --remote-name
```

```plain
sudo dnf --repo=google-chrome list --available
sudo dnf install google-chrome-stable
```
