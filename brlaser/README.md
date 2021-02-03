brlaser in Fedora
-----------------
[brlaser](https://github.com/pdewacht/brlaser): Brother laser printer driver.

[brother-brlaser-printer](https://copr.fedorainfracloud.org/coprs/musinsky/brlaser/)
package repository for Fedora (or CentOS).

### Create SRPM
```
$ wget https://raw.githubusercontent.com/musinsky/config/master/brlaser/brother-brlaser-printer.spec -P $(rpm --eval %{_specdir})
$ rpmdev-spectool -g -R $(rpm --eval %{_specdir})/brother-brlaser-printer.spec
$ # add (temporary) patch
$ wget https://raw.githubusercontent.com/musinsky/config/master/brlaser/DCP-7070DW.patch -P $(rpm --eval %{_sourcedir})
$ rpmbuild -bs $(rpm --eval %{_specdir})/brother-brlaser-printer.spec
$ ls $(rpm --eval %{_srcrpmdir})
brother-brlaser-printer-6-1.20200420git9d7ddda.fc33.src.rpm
```
