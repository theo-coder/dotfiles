{ inputs, ... }:
{
  flake.modules.nixos.dux-shell = {
    services.power-profiles-daemon.enable = true;
    services.accounts-daemon.enable = true;
    services.geoclue2.enable = true;
    security.polkit.enable = true;
  };

  flake.modules.homeManager.dux-shell =
    { pkgs, ... }:
    let
      baseDmsPkg = (inputs.dms.lib.buildDmsPkgs pkgs).dms-shell;
      customDmsPkg = baseDmsPkg.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + ''
            python3 - "$out/share/quickshell/dms" << 'PYEOF'
            import pathlib, sys

            dms_dir = pathlib.Path(sys.argv[1])

            # 1. WorkspaceModel.js: show all named workspaces globally across monitors, sorted by numeric name
            wm_path = dms_dir / "Common/WorkspaceModel.js"
            wm = wm_path.read_text()

            old_curr = """function niriCurrentIdx(raw, screenName, followFocus) {
                if (raw.allWorkspaces.length === 0)
                    return 1;
                if (!screenName || followFocus)
                    return raw.focusedIdx;
                const active = raw.allWorkspaces.find(ws => ws.output === screenName && ws.is_active);
                return active ? active.idx : 1;
            }"""

            new_curr = """function niriSortOrder(a, b) {
                const na = parseInt(a.name ?? "", 10);
                const nb = parseInt(b.name ?? "", 10);
                if (!isNaN(na) && !isNaN(nb) && na !== nb)
                    return na - nb;
                if (!isNaN(na) && isNaN(nb))
                    return -1;
                if (isNaN(na) && !isNaN(nb))
                    return 1;
                if (a.output !== b.output)
                    return String(a.output ?? "").localeCompare(String(b.output ?? ""));
                return (a.idx ?? 0) - (b.idx ?? 0);
            }

            function niriCurrentIdx(raw, screenName, followFocus) {
                if (raw.allWorkspaces.length === 0)
                    return 1;
                const hasNamed = raw.allWorkspaces.some(ws => ws.name && ws.name !== "");
                if (hasNamed) {
                    const target = (!screenName || followFocus)
                        ? (raw.allWorkspaces.find(ws => ws.is_focused) || raw.allWorkspaces.find(ws => ws.is_active))
                        : raw.allWorkspaces.find(ws => ws.output === screenName && ws.is_active);
                    return target ? target.id : 1;
                }
                if (!screenName || followFocus)
                    return raw.focusedIdx;
                const active = raw.allWorkspaces.find(ws => ws.output === screenName && ws.is_active);
                return active ? active.idx : 1;
            }"""

            old_for_screen = """function niriWorkspacesForScreen(raw, screenName, followFocus, occupiedOnly, cache) {
                const all = raw.allWorkspaces;
                if (all.length === 0)
                    return niriFallback().map(niriRecord);
                dropStale(cache, new Set(all.map(ws => String(ws.id))));
                const onScreen = !screenName || followFocus ? raw.currentOutputWorkspaces : all.filter(ws => ws.output === screenName);
                const sorted = (onScreen.length > 0 ? onScreen : niriFallback()).slice().sort((a, b) => a.idx - b.idx);
                const workspaces = occupiedOnly ? sorted.filter(ws => ws.is_active || (raw.windows?.some(win => win.workspace_id === ws.id) ?? false)) : sorted;
                return workspaces.map(ws => reuse(cache, ws.id, niriRecord(ws)));
            }"""

            new_for_screen = """function niriWorkspacesForScreen(raw, screenName, followFocus, occupiedOnly, cache) {
                const all = raw.allWorkspaces;
                if (all.length === 0)
                    return niriFallback().map(niriRecord);
                dropStale(cache, new Set(all.map(ws => String(ws.id))));
                const named = all.filter(ws => ws.name && ws.name !== "");
                if (named.length > 0) {
                    const sortedNamed = named.slice().sort(niriSortOrder);
                    const filtered = occupiedOnly ? sortedNamed.filter(ws => ws.is_active || (raw.windows?.some(win => win.workspace_id === ws.id) ?? false)) : sortedNamed;
                    return filtered.map(ws => reuse(cache, ws.id, niriRecord(ws)));
                }
                const onScreen = !screenName || followFocus ? raw.currentOutputWorkspaces : all.filter(ws => ws.output === screenName);
                const sorted = (onScreen.length > 0 ? onScreen : niriFallback()).slice().sort((a, b) => a.idx - b.idx);
                const workspaces = occupiedOnly ? sorted.filter(ws => ws.is_active || (raw.windows?.some(win => win.workspace_id === ws.id) ?? false)) : sorted;
                return workspaces.map(ws => reuse(cache, ws.id, niriRecord(ws)));
            }"""

            assert old_curr in wm, "old_curr not found in WorkspaceModel.js"
            assert old_for_screen in wm, "old_for_screen not found in WorkspaceModel.js"
            wm = wm.replace(old_curr, new_curr, 1).replace(old_for_screen, new_for_screen, 1)
            wm_path.write_text(wm)

            # 2. CompositorService.qml: key named niri workspaces by id and summon to target monitor when clicked
            cs_path = dms_dir / "Services/CompositorService.qml"
            cs = cs_path.read_text()

            old_key = """        case "niri":
                        return record.idx;"""
            new_key = """        case "niri":
                        return (record.name && record.name !== "") ? record.id : record.idx;"""

            old_switch = """        case "niri":
                        NiriService.switchToWorkspace(record.id);
                        return;"""
            new_switch = """        case "niri":
                        NiriService.switchToWorkspace(record.id, screenName, record.name);
                        return;"""

            assert old_key in cs, "old_key not found in CompositorService.qml"
            assert old_switch in cs, "old_switch not found in CompositorService.qml"
            cs = cs.replace(old_key, new_key, 1).replace(old_switch, new_switch, 1)
            cs_path.write_text(cs)

            # 3. NiriService.qml: move workspace to target monitor when switching to a shared named workspace
            ns_path = dms_dir / "Services/NiriService.qml"
            ns = ns_path.read_text()

            old_ns_switch = """    function switchToWorkspace(workspaceId) {
                    return send({
                        "Action": {
                            "FocusWorkspace": {
                                "reference": {
                                    "Id": workspaceId
                                }
                            }
                        }
                    });
                }"""

            new_ns_switch = """    function switchToWorkspace(workspaceId, targetOutput, workspaceName) {
                    const out = targetOutput || currentOutput;
                    if (out && workspaceName) {
                        const targetWs = allWorkspaces.find(w => w.id === workspaceId);
                        const sourceOut = targetWs ? targetWs.output : "";
                        const wasActiveOnSource = !!(targetWs && targetWs.is_active);
                        const currentActiveOnTarget = allWorkspaces.find(w => w.output === out && w.is_active);

                        if (sourceOut && sourceOut !== out) {
                            send({
                                "Action": {
                                    "MoveWorkspaceToMonitor": {
                                        "output": out,
                                        "reference": {
                                            "Id": workspaceId
                                        }
                                    }
                                }
                            });
                            if (wasActiveOnSource && currentActiveOnTarget && currentActiveOnTarget.id !== workspaceId) {
                                send({
                                    "Action": {
                                        "MoveWorkspaceToMonitor": {
                                            "output": sourceOut,
                                            "reference": {
                                                "Id": currentActiveOnTarget.id
                                            }
                                        }
                                    }
                                });
                                send({
                                    "Action": {
                                        "FocusWorkspace": {
                                            "reference": {
                                                "Id": currentActiveOnTarget.id
                                            }
                                        }
                                    }
                                });
                            }
                        }
                    }
                    return send({
                        "Action": {
                            "FocusWorkspace": {
                                "reference": {
                                    "Id": workspaceId
                                }
                            }
                        }
                    });
                }"""

            assert old_ns_switch in ns, "old_ns_switch not found in NiriService.qml"
            ns = ns.replace(old_ns_switch, new_ns_switch, 1)
            ns_path.write_text(ns)

            # 4. DMSNetworkService.qml: integrate NetBird into the VPN widget & popout
            net_path = dms_dir / "Services/DMSNetworkService.qml"
            net = net_path.read_text()

            old_net_props = """    property var vpnProfiles: []
                property var vpnActive: []"""

            new_net_props = """    property var vpnProfiles: []
                property var vpnActive: []
                property bool netbirdInstalled: true
                property bool netbirdConnected: false
                property bool netbirdConnecting: false
                property string netbirdIp: ""

                function pollNetbirdStatus() {
                    Proc.runCommand("netbird-status", ["netbird", "status", "--json"], (output, exitCode) => {
                        if (exitCode !== 0 || !output) {
                            return;
                        }
                        try {
                            const data = JSON.parse(output.trim());
                            const st = String(data.daemonStatus || "");
                            netbirdConnected = st === "Connected";
                            netbirdConnecting = st === "Connecting";
                            netbirdIp = String(data.netbirdIp || "").split("/")[0] || "";
                        } catch (e) {}
                    }, 0, 3000);
                }

                Timer {
                    interval: 5000
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: root.pollNetbirdStatus()
                }"""

            old_net_profiles = """            if (uuidKey)
                            seen.add(uuidKey);
                        if (nameKey)
                            seen.add(nameKey);
                    }

                    return mergedProfiles;
                }
                property alias activeConnections: root.vpnActive
                property var activeUuids: vpnActive.map(v => v.uuid).filter(u => !!u)
                property var activeNames: vpnActive.map(v => v.name).filter(n => !!n)
                property string activeUuid: activeUuids.length > 0 ? activeUuids[0] : ""
                property string activeName: activeNames.length > 0 ? activeNames[0] : ""
                property string activeDevice: vpnActive.length > 0 ? (vpnActive[0].device || "") : ""
                property string activeState: vpnActive.length > 0 ? (vpnActive[0].state || "") : ""
                property bool vpnConnected: activeUuids.length > 0"""

            new_net_profiles = """            if (uuidKey)
                            seen.add(uuidKey);
                        if (nameKey)
                            seen.add(nameKey);
                    }

                    if (netbirdInstalled && !seen.has("uuid:netbird")) {
                        mergedProfiles.unshift({
                            uuid: "netbird",
                            name: "NetBird",
                            serviceType: "netbird",
                            type: "wireguard",
                            typeLabel: netbirdConnected && netbirdIp ? ("NetBird • " + netbirdIp) : "NetBird Mesh",
                            state: netbirdConnected ? "activated" : (netbirdConnecting ? "activating" : "deactivated"),
                            device: "wt0",
                            transient: true,
                            canDelete: false,
                            canExpand: false
                        });
                    }

                    return mergedProfiles;
                }
                property alias activeConnections: root.vpnActive
                property var activeUuids: (vpnActive.map(v => v.uuid).filter(u => !!u)).concat(netbirdConnected ? ["netbird"] : [])
                property var activeNames: (vpnActive.map(v => v.name).filter(n => !!n)).concat(netbirdConnected ? ["NetBird"] : [])
                property string activeUuid: activeUuids.length > 0 ? activeUuids[0] : ""
                property string activeName: activeNames.length > 0 ? activeNames[0] : ""
                property string activeDevice: vpnActive.length > 0 ? (vpnActive[0].device || "") : (netbirdConnected ? "wt0" : "")
                property string activeState: vpnActive.length > 0 ? (vpnActive[0].state || "") : (netbirdConnected ? "activated" : (netbirdConnecting ? "activating" : ""))
                property bool vpnConnected: activeUuids.length > 0"""

            old_net_state_fn = """    function vpnStateForUuid(uuid) {
                    if (!uuid)
                        return "";
                    const match = vpnActive.find(v => v.uuid === uuid);
                    return match ? (match.state || "") : "";
                }"""

            new_net_state_fn = """    function vpnStateForUuid(uuid) {
                    if (!uuid)
                        return "";
                    if (uuid === "netbird")
                        return netbirdConnected ? "activated" : (netbirdConnecting ? "activating" : "");
                    const match = vpnActive.find(v => v.uuid === uuid);
                    return match ? (match.state || "") : "";
                }"""

            old_net_connect = """    function connectVpn(uuidOrName, singleActive = false) {
                    if (!vpnAvailable || vpnIsBusy)
                        return;"""

            new_net_connect = """    function connectVpn(uuidOrName, singleActive = false) {
                    if (uuidOrName === "netbird") {
                        netbirdConnecting = true;
                        Proc.runCommand("netbird-up", ["netbird", "up"], (_out, _code) => {
                            pollNetbirdStatus();
                        }, 0, 15000);
                        return;
                    }
                    if (!vpnAvailable || vpnIsBusy)
                        return;"""

            old_net_disconnect = """    function disconnectVpn(uuidOrName) {
                    if (!vpnAvailable || vpnIsBusy)
                        return;"""

            new_net_disconnect = """    function disconnectVpn(uuidOrName) {
                    if (uuidOrName === "netbird") {
                        Proc.runCommand("netbird-down", ["netbird", "down"], (_out, _code) => {
                            pollNetbirdStatus();
                        }, 0, 10000);
                        return;
                    }
                    if (!vpnAvailable || vpnIsBusy)
                        return;"""

            old_net_disconnect_all = """    function disconnectAllVpns() {
                    if (!vpnAvailable || vpnIsBusy)
                        return;"""

            new_net_disconnect_all = """    function disconnectAllVpns() {
                    if (netbirdConnected) {
                        disconnectVpn("netbird");
                        if (vpnActive.length === 0)
                            return;
                    }
                    if (!vpnAvailable || vpnIsBusy)
                        return;"""

            assert old_net_props in net, "old_net_props not found"
            assert old_net_profiles in net, "old_net_profiles not found"
            assert old_net_state_fn in net, "old_net_state_fn not found"
            assert old_net_connect in net, "old_net_connect not found"
            assert old_net_disconnect in net, "old_net_disconnect not found"
            assert old_net_disconnect_all in net, "old_net_disconnect_all not found"

            net = (
                net.replace(old_net_props, new_net_props, 1)
                .replace(old_net_profiles, new_net_profiles, 1)
                .replace(old_net_state_fn, new_net_state_fn, 1)
                .replace(old_net_connect, new_net_connect, 1)
                .replace(old_net_disconnect, new_net_disconnect, 1)
                .replace(old_net_disconnect_all, new_net_disconnect_all, 1)
            )
            net_path.write_text(net)
            PYEOF
          '';
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.python3 ];
      });
    in
    {
      imports = [ inputs.dms.homeModules.dank-material-shell ];

      programs.dank-material-shell = {
        enable = true;
        package = customDmsPkg;

        systemd = {
          enable = true;
          target = "niri.service";
          restartIfChanged = true;
        };

        enableSystemMonitoring = true;
        enableVPN = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
      };

      systemd.user.services.dms.Service.Environment = [
        "DMS_HIDE_TRAYIDS=spotify-client,spotify"
      ];
    };
}
