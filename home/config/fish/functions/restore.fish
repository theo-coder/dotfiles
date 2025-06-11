function restore --argument file
    mv $file (echo $file | sed s/.bak//)
end

abbr -a re restore
