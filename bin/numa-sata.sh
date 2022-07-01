hwloc-bind pci=$(lspci | grep SATA | head -n1 | cut -f1 -d' ') -- $@
