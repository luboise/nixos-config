{
  lib,
  config,
  ...
}:
with lib; {
  options.fish.enable = mkEnableOption "Enable fish shell";

  config = mkIf config.fish.enable {
    home-manager.users.lucasjr.programs = {
      direnv = {
        enableFishIntegration = true;
      };
      fish = {
        enable = true;

        shellAliases = {
          fucking = "sudo";

          # TODO: Make these config agnostic
          rebuild-switch = "fucking nixos-rebuild switch --flake ~/nixos#laptop-aorus";
          rebuild-test = "fucking nixos-rebuild test --flake ~/nixos#laptop-aorus";
        };

        shellInit = "zoxide init fish --cmd cd | source";

        functions = {
          clip = {
            body = "xclip -selection clipboard $argv";
          };

          ConnectPi = {
            body = ''              set ip (arp -a | grep "on enp46s0" | awk '{print $2}' | tr -d '()')
                  				if test -n "$ip"
                      				ssh lucas@$ip
                  				else
                      				echo "No IP address found for enp46s0"
                  				end'';
          };

          openbg = {
            body = ''
              # Check if a command was provided
                  if test (count $argv) -eq 0
                      echo "Usage: bgcmd <command>"
                      return 1
                  end

                  # Run the command in the background
                  command $argv &

                  # Get the PID of the last background process and disown it
                  set pid $last_pid
                  disown $pid
            '';
          };

          ssh-home = {
            body = "killall ssh-agent; and eval (ssh-agent -c); and ssh-add ~/.ssh/github_luboise $argv";
          };
          ssh-uni = {
            # # You can also set the file content immediately.
            # ".gradle/gradle.properties".text = ''
            #   org.gradle.console=verbose
            #   org.gradle.daemon.idletimeout=3600000
            # '';
            body = "killall ssh-agent; and eval (ssh-agent -c); and ssh-add ~/.ssh/id_ed25519 $argv";
          };
        };
      };
    };
  };
}
