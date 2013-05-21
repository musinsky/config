GistIt
------
GistIt is simple [MediaWiki](https://www.mediawiki.org) extension that allows you to embed [GitHub](https://github.com) file over [gist-it](http://gist-it.appspot.com)

### Installation

* download this file
```
wget https://raw.github.com/musinsky/config/master/GistIt/GistIt.php
```

* and place it in ``$IP/extensions/GistIt/GistIt.php``

* add the following code to ``LocalSettings.php``
```
require_once("$IP/extensions/GistIt/GistIt.php");
```

### Usage
* import file from GitHub
```
<gistit user="musinsky" repo="config" file="GistIt/GistIt.php"/>
```

* use ``/`` at the end of line is important
