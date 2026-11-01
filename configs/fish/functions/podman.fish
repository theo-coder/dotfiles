function podman
    set -l args
    set -l push_flag 0
    set -l tag_value

    for arg in $argv
        if test $arg = "--push"
            set push_flag 1
        else
            set args $args $arg
        end
    end

    if test $push_flag = 1
        set -l found_t 0
        for arg in $args
            if test $found_t = 1
                set tag_value $arg
                set found_t 0
            end

            if test $arg = "-t"
                set found_t 1
            end
        end

        if test -z "$tag_value"
            echo "Error: when --push is used, you must specify a tag with -t" >&2
            return 1
        end

        command podman $args && podman push $tag_value docker://docker.io/$tag_value
    else
        command podman $args
    end
end
