{
  description = "Ansible development environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/32f313e49e42f715491e1ea7b306a87c16fe0388";

  outputs = { self, nixpkgs }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = { allowUnfree = true; };
    };
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        ansible
        ansible-lint
        python3
        git
        openssh
        vim
        vscode
        fish
      ];
      shellHook = ''
        export SHELL=${pkgs.fish}/bin/fish
        echo "Welcome to your Ansible environment!"
        echo "Ansible version: $(ansible --version)"
        exec fish
      '';
    };
  };

  nixConfig = {
    allowUnfree = true;
  };
}
