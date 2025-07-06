{
  nixpkgs,
  microvm,
}: {
  gpuPath ? "/dev/dri/renderD128",
  gdPath
}: let
  configuration = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      microvm.nixosModules.microvm
      ({ config, lib, pkgs, ... }: let
        runUntilText = pkgs.writers.writePython3Bin "run_until_text" {} (builtins.readFile ./run_until_text.py);
      in {
        systemd.services.taskAndShutdown = {
          description = "Runs GD and then shuts down the system";

          after = [ "network.target" ];

          serviceConfig = {
            Type = "oneshot";
            StandardOutput="journal+console";
            StandardError="journal+console";
            ExecStart = pkgs.writeShellScript "bot-gd" ''
              set +e # Don't exit on error
              export WINEDLLOVERRIDES="XInput1_4.dll=n,b;mscoree=d;winemono=d;winemenubuilder.exe=d"
              export WINEDEBUG=+warn
              export WLR_BACKENDS=headless
              export WINEPREFIX=/home/vm/geometry-dash/.wine
              export XDG_RUNTIME_DIR=/run/user/1000
              export WINARCH=win64
              mkdir -p /run/user/1000
              chown -R root:root /home/vm/geometry-dash
              # chmod -R 700 /run/user/1000
              # chmod -R 700 /home/vm/geometry-dash
              env -C /home/vm/geometry-dash ${pkgs.cage}/bin/cage ${runUntilText}/bin/run_until_text -- "fixme:dbghelp_msc:dump" "${pkgs.wineWowPackages.stable}/bin/wine" ./GeometryDash.exe
              echo Powering off...
              echo o >/proc/sysrq-trigger
              echo Done
            '';
          };

          wantedBy = [ "multi-user.target" ];
        };

        microvm = {
          hypervisor = "qemu";
          qemu.extraArgs = [
            "-device" "virtio-gpu-gl"
            "-display" "egl-headless,rendernode=${gpuPath}"
            # "-device" "virtio-vga"
            # "-display" "egl-headless"
            # "-vga" "none"
          ];
          shares = [
            {
              source = "${gdPath}";
              mountPoint = "/home/vm/geometry-dash";
              tag = "gd";
              proto = "9p";
            }
          ];
          graphics.enable = true;
          mem = 4096;
          vcpu = 2;
        };

        system.stateVersion = "23.11";

        networking.hostName = "vm-showcase";

        users.users.vm = {
          password = "vm";
          group = "vm";
          isNormalUser = true;
          extraGroups = [ "wheel" "video" ];
        };
        users.groups.vm = { };

        security.sudo = {
          enable = true;
          wheelNeedsPassword = false;
        };

        hardware.graphics.enable = true;

        boot.kernelModules = [ "drm" "qxl" "bochs_drm" ];
      })
    ];
  };
in
  configuration.config.microvm.declaredRunner
