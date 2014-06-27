Eclipse CDT
-----------
```
wget https://raw.github.com/musinsky/config/master/Eclipse/eclipse_custom.ini
wget https://raw.github.com/musinsky/config/master/Eclipse/profile_AliRoot.xml
```

### Prepare config

* replace all "=" by "\="
```
sed 's/=/\\=/g' profile_AliRoot.xml > profile_AliRoot.tmp
```

* replace all 'end of line' by "\n"
```
sed -i ':a;N;$!ba;s/\n/\\n/g' profile_AliRoot.tmp
```

* append "...formatterprofiles"
```
echo "org.eclipse.cdt.ui/org.eclipse.cdt.ui.formatterprofiles="`cat profile_AliRoot.tmp` > profile_AliRoot.tmp
```

* insert ``profile_AliRoot.tmp`` file to ``eclipse_custom.ini`` file (after "formatter_profile" word)
```
sed -i '/formatter_profile/ r profile_AliRoot.tmp' eclipse_custom.ini
```

### Start Eclipse with custom config

```
eclipse -plugincustomization /opt/eclipse/eclipse_custom.ini
```
or add to ``eclipse.ini`` file this line

```
-Declipse.pluginCustomization=/opt/eclipse/eclipse_custom.ini
```

* append custom config to ``eclipse.ini`` file
```
echo -e "\n-Declipse.pluginCustomization=/opt/eclipse/eclipse_custom.ini" >> eclipse.ini
```

### GTK+ 3
```
eclipse --launcher.GTK_version 3   # or   export SWT_GTK3=1; eclipse
```

* modified ``eclipse.ini`` file ("launcher.GTK_version" must be before "-vmargs")
```
sed -i '/-vmargs/ i \--launcher.GTK_version\n3' eclipse.ini
```
