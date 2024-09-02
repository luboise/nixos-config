{...}: {
  programs = {
    fish = {
      enable = true;

      shellAliases = {
        fucking = "sudo";

        # TODO: Make these config agnostic
        rebuild-switch = "fucking nixos-rebuild switch --flake ~/nixos#home-pc";
        rebuild-test = "fucking nixos-rebuild test --flake ~/nixos#home-pc";
      };

      shellInit = "zoxide init fish --cmd cd | source";

      functions = {
        clip = {
          body = "xclip -selection clipboard $argv";
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
      };
    };
  };
}
