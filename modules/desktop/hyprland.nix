{ inputs, ... }:
{
  flake.modules.nixos.hyprland =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        waybar
        hyprpolkitagent
        hypridle
        hyprlock
        hyprpicker
      ];

      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };

      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };

  flake.modules.homeManager.hyprland =
    { lib, ... }:
    {
      imports = [ inputs.hyprland.homeManagerModules.default ];

      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        xwayland.enable = true;
        systemd.enable = true;

        settings = {
          mod = {
            _var = "SUPER";
          };
          terminal = {
            _var = "kitty";
          };
          browser = {
            _var = "zen";
          };
          fileManager = {
            _var = "pcmanfm";
          };
          menu = {
            _var = "~/.local/bin/applauncher";
          };
          config = {
            general = {
              gaps_in = 5;
              gaps_out = 10;
              border_size = 2;
              col.active_border = {
                colors = [
                  "rgba(33ccffee)"
                  "rgba(00ff99ee)"
                ];
                angle = 45;
              };
              col.inactive_border = "rgba(595959aa)";
              resize_on_border = true;
              allow_tearing = false;
              layout = "dwindle";
            };
            decoration = {
              rounding = 7;
              active_opacity = 1.0;
              inactive_opacity = 1.0;
              shadow = {
                enabled = false;
              };
              blur = {
                enabled = true;
                size = 3;
                passes = 1;
                vibrancy = 0.1696;
              };
            };
            animations = {
              enabled = true;
            };
            dwindle = {
              preserve_split = true;
              force_split = 2;
            };
            master = {
              new_status = "master";
            };
            misc = {
              force_default_wallpaper = 0;
              disable_hyprland_logo = true;
            };
            input = {
              kb_layout = "us";
              kb_options = "ctrl:nocaps,compose:rctrl";
              follow_mouse = 1;
              sensitivity = 0;
              touchpad = {
                natural_scroll = false;
              };
            };
            xwayland = {
              force_zero_scaling = true;
            };
          };
          curve = [
            {
              _args = [
                "myBezier"
                {
                  type = "bezier";
                  points = [
                    [
                      0.05
                      0.9
                    ]
                    [
                      0.1
                      1.05
                    ]
                  ];
                }
              ];
            }
            {
              _args = [
                "easeOutQuint"
                {
                  type = "bezier";
                  points = [
                    [
                      0.23
                      1
                    ]
                    [
                      0.32
                      1
                    ]
                  ];
                }
              ];
            }
            {
              _args = [
                "quick"
                {
                  type = "bezier";
                  points = [
                    [
                      0.15
                      0
                    ]
                    [
                      0.1
                      1
                    ]
                  ];
                }
              ];
            }
            {
              _args = [
                "almostLinear"
                {
                  type = "bezier";
                  points = [
                    [
                      0.5
                      0.5
                    ]
                    [
                      0.75
                      1
                    ]
                  ];
                }
              ];
            }
          ];
          animation = [
            {
              leaf = "windows";
              speed = 7;
              bezier = "myBezier";
              enabled = true;
            }
            {
              leaf = "windowsOut";
              speed = 7;
              bezier = "linear";
              style = "popin 80%";
              enabled = true;
            }
            {
              leaf = "border";
              speed = 10;
              bezier = "easeOutQuint";
              enabled = true;
            }
            {
              leaf = "borderangle";
              bezier = "easeOutQuint";
              speed = 8;
              enabled = true;
            }
            {
              leaf = "fade";
              speed = 7;
              enabled = true;
              bezier = "quick";
            }
          ];
          bind =
            [
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + RETURN\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + SHIFT + Q\"")
                  (lib.generators.mkLuaInline "hl.dsp.window.close()")
                  { locked = true; }
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + SHIFT + E\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/powermenu\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + SHIFT + RETURN\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(menu)")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + B\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(browser)")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + SPACE\"")
                  (lib.generators.mkLuaInline "hl.dsp.window.fullscreen()")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + SHIFT + p\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/monitor prompt\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + CONTROL + p\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/monitor internal\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + P\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprpicker --autocopy\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + C\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/toggle-center-gaps\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + X\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprlock\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + H\"")
                  (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"left\" })")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + J\"")
                  (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"down\" })")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + K\"")
                  (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"up\" })")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + L\"")
                  (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"right\" })")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + V\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"kitty --class clipse -e clipse\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + S\"")
                  (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special(\"scratchpad\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + O\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"appimage-run /home/theo/Applications/Handy_0.9.6_amd64.AppImage --toggle-transcription\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + SHIFT + S\"")
                  (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace =\"special:scratchpad\" })")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + F10\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + F11\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "\"XF86AudioRaiseVolume\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "\"XF86AudioLowerVolume\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "\"XF86AudioMute\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
                  { locked = true; }
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "\"XF86AudioMicMute\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")")
                  { locked = true; }
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "\"XF86MonBrightnessUp\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"brightnessctl set +10%\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "\"XF86MonBrightnessDown\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"brightnessctl set 10%-\")")
                  {
                    locked = true;
                    repeating = true;
                  }
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "\"Print\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/capture monitor-focused\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "\"SHIFT + Print\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/capture region\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + SHIFT + Print\"")
                  (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/capture window\")")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + mouse:272\"")
                  (lib.generators.mkLuaInline "hl.dsp.window.drag()")
                ];
              }
              {
                _args = [
                  (lib.generators.mkLuaInline "mod .. \" + mouse:273\"")
                  (lib.generators.mkLuaInline "hl.dsp.window.resize()")
                ];
              }
            ]
            ++ (builtins.concatLists (
              builtins.genList (
                i:
                let
                  ws = i + 1;
                in
                [
                  {
                    _args = [
                      (lib.generators.mkLuaInline "mod .. \" + code:1${toString i}\"")
                      (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"${toString ws}\", on_current_monitor = true })")
                    ];
                  }
                  {
                    _args = [
                      (lib.generators.mkLuaInline "mod .. \" + SHIFT + code:1${toString i}\"")
                      (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = \"${toString ws}\" })")
                    ];
                  }
                ]
              ) 9
            ));

          on = {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
                  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
                  hl.exec_cmd("systemctl --user start hyprpolkitagent")
                  hl.exec_cmd("poweralertd &")
                  hl.exec_cmd("clipse -listen")
                  hl.exec_cmd("waybar &")
                  hl.exec_cmd("hypridle")
                  hl.exec_cmd("appimage-run /home/theo/Applications/Handy_0.9.6_amd64.AppImage --start-hidden")
                  hl.exec_cmd("~/.local/bin/monitor")
                end
              '')
            ];
          };
          window_rule = [
            {
              name = "suppress-maximize";
              match = {
                class = ".*";
              };
              suppress_event = "maximize";
            }
            {
              name = "pin-rofi";
              match = {
                class = "^rofi$";
              };
              pin = true;
            }
            {
              name = "calls-widget";
              match = {
                title = "^Calls Widget$";
              };
              float = true;
              border_size = 0;
            }
            {
              name = "float-emulator";
              match = {
                class = "Emulator";
              };
              float = true;
            }
            {
              name = "float-android-studio";
              match = {
                title = "^Welcome to Android Studio$";
              };
              float = true;
            }
            {
              name = "clipse";
              match = {
                class = "clipse";
              };
              float = true;
              size = "800 650";
            }
            {
              name = "float-file-ops";
              match = {
                title = "^Opération sur des fichiers en cours$";
              };
              float = true;
            }
            {
              name = "no-border-handy";
              match = {
                class = "Handy";
              };
              border_size = 0;
            }
          ];
        };
      };

      programs.waybar = {
        enable = true;
        settings.mainBar = lib.mkForce {
          height = 16;
          modules-left = [
            "hyprland/workspaces"
            "custom/arrow"
            "hyprland/window"
          ];
          modules-right = [
            "group/expand"
            "network"
            "group/expand-3"
            "upower"
            "upower#headset"
            "memory"
            "cpu"
            "clock"
          ];
          "image#nix-ico" = {
            path = "${../../assets/nix.png}";
            size = 16;
          };
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
              urgent = "";
              focused = "";
              default = "";
            };
            all-outputs = true;
            sort-by-number = true;
            persistent-workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
              "6" = [ ];
              "7" = [ ];
              "8" = [ ];
              "9" = [ ];
            };
          };
          "custom/arrow" = {
            format = ">";
          };
          "hyprland/window" = {
            format = "{}";
            separate-outputs = true;
          };
          "group/expand" = {
            orientation = "horizontal";
            drawer = {
              transition-duration = 600;
              children-class = "not-power";
              transition-to-left = true;
            };
            modules = [
              "custom/menu"
              "tray"
            ];
          };
          "custom/menu" = {
            format = "󰅃";
            rotate = 90;
          };
          tray = {
            icon-size = 16;
            rotate = 0;
            spacing = 3;
          };
          network = {
            tooltip = true;
            format-wifi = "{icon}";
            format-icons = [
              "󰤟 "
              "󰤢 "
              "󰤥 "
            ];
            rotate = 0;
            format-ethernet = "󰈀 ";
            tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
            format-linked = "󰈀 {ifname} (No IP)";
            format-disconnected = " ";
            tooltip-format-disconnected = "Disconnected";
            on-click = "nm-connection-editor";
            interval = 2;
          };
          "group/expand-3" = {
            orientation = "horizontal";
            drawer = {
              transition-duration = 600;
              children-class = "not-power";
              transition-to-left = true;
              click-to-reveal = true;
            };
            modules = [
              "pulseaudio"
              "pulseaudio/slider"
            ];
          };
          pulseaudio = {
            format = "{icon}";
            rotate = 0;
            format-muted = "婢";
            tooltip-format = "{icon}   {desc} // {volume}%";
            scroll-step = 5;
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
          };
          "pulseaudio/slider" = {
            min = 5;
            max = 100;
            rotate = 0;
            device = "pulseaudio";
            scroll-step = 1;
          };
          upower = {
            format = "󰁹 {percentage}";
            tooltip = false;
            show-icon = false;
            on-click-right = "pkill waybar & pkill .waybar-wrapped & hyprctl dispatch exec waybar";
          };
          "upower#headset" = {
            native-path = "/org/bluez/hci0/dev_F8_4E_17_BC_B6_66";
            format = "  {percentage}";
            tooltip = false;
            show-icon = false;
            hide-if-empty = true;
          };
          memory = {
            interval = 1;
            rotate = 270;
            format = "{icon}";
            format-icons = [
              "󰝦"
              "󰪞"
              "󰪟"
              "󰪠"
              "󰪡"
              "󰪢"
              "󰪣"
              "󰪤"
              "󰪥"
            ];
            max-length = 10;
          };
          cpu = {
            interval = 1;
            format = "{icon}";
            rotate = 270;
            format-icons = [
              "󰝦"
              "󰪞"
              "󰪟"
              "󰪠"
              "󰪡"
              "󰪢"
              "󰪣"
              "󰪤"
              "󰪥"
            ];
          };
          clock = {
            format = "{:%I:%M %p}";
            rotate = 0;
            tooltip-format = "<tt>{calendar}</tt>";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
              on-scroll = 1;
              on-click-right = "mode";
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b>{}</b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };
        style = lib.mkForce ''
          * {
              font-family: logo-font, FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          }

          window#waybar {
              border-bottom: 1px solid #494d64;
          }

          #image {
              margin-left: 0.75em;
              margin-right: 0.25em;
          }

          #workspaces {
              background: #363a4f;
              margin: 0.25em 0.5em;
              border-radius: 0.5em;
              border: 1px solid #494d64;
              font-size: 1.15em;
          }

          #workspaces button.empty {
              color: #6c718a;
          }

          #workspaces button.visible {
              color: #cad3f5;
          }

          #workspaces button.active {
              color: #7c9e79;
              border: none;
          }

          #workspaces button.urgent {
              color: #e67f19;
          }

          #custom-arrow {
              font-weight: bold;
              margin: 0 1em 0.25em 0.5em;
              font-size: 1.25em;
          }

          #window {
              color: #d6a090;
              font-weight: bold;
          }

          #custom-menu {
              font-weight: bold;
              font-size: 1.5em;
              color: #E8EDF0;
              opacity: 0.1;
          }

          #tray {
              margin-right: 0.5em;
          }

          #network {
              color: #A1BDCE;
              font-size: 19px;
              padding-right: 0px;
              padding-left: 4px;
              margin-right: 0.4em;
          }

          #pulseaudio {
              font-size: 17px;
              color: #6F8FDB;
              margin-right: 0.5em;
              margin-top: 1px;
          }

          #backlight-slider slider,
          #pulseaudio-slider slider {
              opacity: 0;
              min-width: 0;
              min-height: 0;
              background: transparent;
              border: none;
              box-shadow: none;
              margin-right: 7px;
          }

          #backlight-slider trough,
          #pulseaudio-slider trough {
              margin-top: -3px;
              min-width: 90px;
              min-height: 10px;
              margin-bottom: -4px;
              border-radius: 8px;
              background: #343434;
          }

          #backlight-slider highlight,
          #pulseaudio-slider highlight {
              border-radius: 8px;
              background-color: #2096C0;
          }

          #backlight {
              color: #2096C0;
              font-size: 19px;
              margin-right: 0.5em;
          }

          #upower#headset,
          #upower {
              font-size: 15px;
              color: #a6d189;
              margin-right: 0.2em;
              margin-left: 0.5em;
          }

          #memory {
              font-size: 17px;
              color: #E4C9AF;
              margin-bottom: 2px;
          }

          #cpu {
              font-size: 17px;
              color: #915CAF;
              margin-bottom: 2px;
          }

          #clock {
              color: #A1BDCE;
              font-size: 15px;
              font-weight: 900;
              font-family: "JetBrains Mono Nerd Font";
              background: rgba(23, 23, 23, 0.0);
              opacity: 1;
              margin: 3px 0px 0px 0px;
              padding-left: 10px;
              padding-right: 10px;
              border: none;
          }

          #custom-notification {
              font-family: "JetBrains Mono Nerd Font";
              font-size: 17px;
              color: #E8EDF0;
              background: rgba(23, 23, 23, 0.0);
              margin: 0px 0px 0px 0px;
              padding-left: 1px;
              padding-right: 1px;
              opacity: 0.1
          }
        '';
      };
    };
}
