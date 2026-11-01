{
  inputs,
  lib,
  ...
}:
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
        #{
        #  leaf = "workspaces";
        #  speed = 9;
        #  enabled = true;
        #  bezier = "almostLinear";
        #}
      ];
      bind = [
        # Terminal
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + RETURN\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
          ];
        }
        # Fermer la fenêtre
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + Q\"")
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
            { locked = true; }
          ];
        }
        # Power menu
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + E\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/powermenu\")")
          ];
        }
        # App launcher
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + RETURN\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(menu)")
          ];
        }
        # Browser
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + B\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(browser)")
          ];
        }
        # Fullscreen
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SPACE\"")
            (lib.generators.mkLuaInline "hl.dsp.window.fullscreen()")
          ];
        }
        # Monitor scripts
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
        # Hyprpicker
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + P\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprpicker --autocopy\")")
          ];
        }
        # Toggle center gaps
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + C\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"~/.local/bin/toggle-center-gaps\")")
          ];
        }
        # Hyprlock
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + X\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprlock\")")
          ];
        }
        # Move focus
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
        # Clipse
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + V\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"kitty --class clipse -e clipse\")")
          ];
        }
        # Scratchpad toggle
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + S\"")
            (lib.generators.mkLuaInline "hl.dsp.workspace.toggle_special(\"scratchpad\")")
          ];
        }
        # Handy
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + O\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"appimage-run /home/theo/Applications/Handy_0.9.6_amd64.AppImage --toggle-transcription\")")
          ];
        }
        # Move to scratchpad
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + SHIFT + S\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace =\"special:scratchpad\" })")
          ];
        }
        # Zoom
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
              hl.exec_cmd("dunst &")
              hl.exec_cmd("hypridle")
              hl.exec_cmd("appimage-run /home/theo/Applications/Handy_0.9.6_amd64.AppImage --start-hidden")
              hl.exec_cmd("~/.local/bin/monitor")
            end
          '')
        ];
      };
      window_rule = [
        # Supprimer les maximize pour toutes les apps
        {
          name = "suppress-maximize";
          match = {
            class = ".*";
          };
          suppress_event = "maximize";
        }
        # Rofi (pin)
        {
          name = "pin-rofi";
          match = {
            class = "^rofi$";
          };
          pin = true;
        }
        # Calls Widget (float + no border)
        {
          name = "calls-widget";
          match = {
            title = "^Calls Widget$";
          };
          float = true;
          border_size = 0;
        }
        # Emulator
        {
          name = "float-emulator";
          match = {
            class = "Emulator";
          };
          float = true;
        }
        # Android Studio welcome
        {
          name = "float-android-studio";
          match = {
            title = "^Welcome to Android Studio$";
          };
          float = true;
        }
        # Clipse (float + size)
        {
          name = "clipse";
          match = {
            class = "clipse";
          };
          float = true;
          size = "800 650";
        }
        # File operations dialog (FR)
        {
          name = "float-file-ops";
          match = {
            title = "^Opération sur des fichiers en cours$";
          };
          float = true;
        }
        # Handy (no border)
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
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
