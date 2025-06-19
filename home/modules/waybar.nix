{lib, ...}: {
  programs.waybar = {
    enable = true;
    settings.mainBar = lib.mkForce {
      height = 16;
      modules-left = [
        "image#nix-ico"
        "hyprland/workspaces"
        "custom/arrow"
        "hyprland/window"
      ];
      modules-right = [
        "group/expand"
        "network"
        "group/expand-3"
        "upower"
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
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
          "5" = [];
          "6" = [];
          "7" = [];
          "8" = [];
          "9" = [];
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
        tooltip-format = "{icon} {desc} // {volume}%";
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
        icon-size = 20;
        format = "";
        tooltip = true;
        tooltip-spacing = 20;
        on-click-right = "pkill waybar & hyprctl dispatch exec waybar";
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
          font-size: 19px;
          color: #a6d189;
          margin-right: 0.2em;
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
          /* color: #A1BDCE; */
          /* margin: 2px 0px 0px 0px; */
          color: #E8EDF0;
          background: rgba(23, 23, 23, 0.0);
          margin: 0px 0px 0px 0px;
          padding-left: 1px;
          padding-right: 1px;
          opacity: 0.1
      }
    '';
  };
}
