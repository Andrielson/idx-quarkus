# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [ 
        pkgs.graalvm-ce
        pkgs.htop
        pkgs.maven
    ];
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [ 
        "vscjava.vscode-java-pack"
        "redhat.vscode-quarkus"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        install = "./mvnw dependency:resolve";
      };
      # Runs when a workspace is (re)started
      onStart = { run-server = "./mvnw compile quarkus:dev"; };
    };
  };
}
