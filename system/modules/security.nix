{...}: {
  security.pki.certificateFiles = [
    (builtins.readFile ../../assets/home.crt)
  ];
}
