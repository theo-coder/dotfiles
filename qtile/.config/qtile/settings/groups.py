from libqtile.config import Group

group_names = ["ampersand", "eacute", "quotedbl", "apostrophe",
               "parenleft", "minus", "egrave", "underscore", "ccedilla"]

def init_groups():
    return [
        Group(
            name="ampersand",
            layout="monadtall",
            label="1",
            layout_opts=None,
            screen_affinity=None,
            spawn=None
        ),
        Group(
            name="eacute",
            layout="monadtall",
            label="2",
            layout_opts=None,
            screen_affinity=None,
            spawn=None
        ),
        Group(
            name="quotedbl",
            layout="monadtall",
            label="3",
            layout_opts=None,
            screen_affinity=None,
            spawn=None
        ),
        Group(
            name="apostrophe",
            layout="monadtall",
            label="4",
            layout_opts=None,
            screen_affinity=None,
            spawn=None
        ),
        Group(
            name="parenleft",
            layout="monadtall",
            label="5",
            layout_opts=None,
            screen_affinity=None,
            spawn=None
        ),
        Group(
            name="minus",
            layout="monadtall",
            label="6",
            layout_opts=None,
            screen_affinity=None,
            spawn=None
        ),
        Group(
            name="egrave",
            layout="monadtall",
            label="7",
            layout_opts=None,
            screen_affinity=None,
            spawn=None
        ),
        Group(
            name="underscore",
            layout="monadtall",
            label="8",
            layout_opts={"margin": 50},
            screen_affinity=None,
            spawn=None
        ),
        Group(
            name="ccedilla",
            layout="monadtall",
            label="9",
            layout_opts=None,
            screen_affinity=None,
            spawn=None
        ),
    ]
