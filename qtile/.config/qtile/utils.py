from libqtile.lazy import lazy


@lazy.function
def kill_all_windows(qtile):
    for window in qtile.current_group.windows:
        window.kill()
