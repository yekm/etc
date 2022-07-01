hwloc-bind pci=$(lspci | grep VGA | head -n1 | cut -f1 -d' ') -- $@
