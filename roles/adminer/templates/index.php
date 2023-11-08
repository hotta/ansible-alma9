<?php
function adminer_object() {
  // required to run any plugin
  include_once "./plugins/plugin.php";
  include_once "./plugins/login-password-less.php";

  // autoloader
  //foreach (glob("plugins/*.php") as $filename) {
  //  include_once "./$filename";
  //}

  $plugins = array(
    // specify enabled plugins here
    new AdminerLoginPasswordLess(password_hash("9999", PASSWORD_DEFAULT)),
  );

  return new AdminerPlugin($plugins);
}

// include original Adminer or Adminer Editor
include "./adminer.php";
?>
