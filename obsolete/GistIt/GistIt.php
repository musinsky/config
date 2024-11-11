<?php
if( !defined( 'MEDIAWIKI' ) ) {
  echo( "This file is part of an extension to the MediaWiki software and cannot be used standalone.\n" );
  die( 1 );
}

$wgExtensionCredits['parserhook'][] = array(
                                            'name' =>        'GistIt',
                                            'author' =>      'Adam Meyer, Jan Musinsky',
                                            'description' => 'Import file(s) from [https://github.com/ GitHub] and embed it over [http://gist-it.appspot.com/ gist-it]',
                                            'url' =>         'https://github.com/musinsky/config/tree/master/GistIt'
                                            );

if ( defined( 'MW_SUPPORTS_PARSERFIRSTCALLINIT' ) ) {
  $wgHooks['ParserFirstCallInit'][] = 'efGistIt';
} else {
  $wgExtensionFunctions[] = 'efGistIt';
}

function efGistIt() {
  global $wgParser;
  $wgParser->setHook( 'gistit', 'efGistItRender' );
  return true;
}

function efGistItRender( $input, $args, $parser ) {
  $attr = array();
  // This time, make a list of attributes and their values,
  // and dump them, along with the user input
  foreach( $args as $name => $value ) {
    if ( $name == 'user' ) {
      $user = $value;
    }
    if ( $name == 'repo' ) {
      $repo = $value;
    }
    if ( $name == 'file' ) {
      $fname = $value;
    }
  }

  return '<script src="http://gist-it.appspot.com/https://github.com/'.$user.'/'.$repo.'/blob/master/'.$fname.'"></script>';
}
?>
