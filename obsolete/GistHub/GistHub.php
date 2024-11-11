<?php
if( !defined( 'MEDIAWIKI' ) ) {
  echo( "This file is part of an extension to the MediaWiki software and cannot be used standalone.\n" );
  die( 1 );
}

$wgExtensionCredits['parserhook'][] = array(
                                            'name' =>        'GistHub',
                                            'author' =>      'Adam Meyer, Jan Musinsky',
                                            'description' => 'Import file(s) from [https://gist.github.com/ GitHub Gist]',
                                            'url' =>         'https://github.com/musinsky/config/tree/master/GistHub'
                                            );

if ( defined( 'MW_SUPPORTS_PARSERFIRSTCALLINIT' ) ) {
  $wgHooks['ParserFirstCallInit'][] = 'efGistHub';
} else {
  $wgExtensionFunctions[] = 'efGistHub';
}

function efGistHub() {
  global $wgParser;
  $wgParser->setHook( 'gisthub', 'efGistHubRender' );
  return true;
}

function efGistHubRender( $input, $args, $parser ) {
  $attr = array();
  // This time, make a list of attributes and their values,
  // and dump them, along with the user input
  foreach( $args as $name => $value ) {
    if ( $name == 'gist' ) {
      $num = $value;
    }
    if ( $name == 'file' ) {
      $fname = $value;
    }
  }

  return '<script src="https://gist.github.com/'.$num.'.js?file='.$fname.'"></script>';
}
?>
