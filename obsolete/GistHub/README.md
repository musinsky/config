GistHub
-------
GistHub is simple [MediaWiki](https://www.mediawiki.org) extension that allows you to embed [GitHub Gist](https://gist.github.com) file(s)

### Installation

* download this file
```
wget https://raw.githubusercontent.com/musinsky/config/master/GistHub/GistHub.php
```

* and place it in ``$IP/extensions/GistHub/GistHub.php``

* add the following code to ``LocalSettings.php``
```
require_once("$IP/extensions/GistHub/GistHub.php");
```

### Usage
* import file (or all files) from GitHub Gist
```
<gisthub gist="2370651"/>
```

* import only one specif file (for example ``GistHub.wiki``) from GitHub Gist
```
<gisthub gist="2370651" file="GistHub.wiki"/>
```

* use ``/`` at the end of line is important
