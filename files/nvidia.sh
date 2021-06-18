# https://github.com/Witko/nvidia-xrun/blob/master/nvidia-xrun
MODULES_UNLOAD=(nvidia_drm nvidia_modeset nvidia_uvm nvidia)
MODULES_LOAD=(nvidia nvidia_uvm nvidia_modeset "nvidia_drm modeset=1")

function unload_modules {
    for module in "${MODULES_UNLOAD[@]}"
    do
	echo "Unloading module ${module}"
	sudo modprobe -r ${module}
    done
}


function load_modules {
    for module in "${MODULES_LOAD[@]}"
    do
	echo "Loading module ${module}"
	sudo modprobe ${module}
    done
}

function control_nvidia {
    nvidia-smi
}


if [[ $1 = "unload" ]]; then
    unload_modules
elif [[ $1 = "load" ]]; then
    load_modules
fi
