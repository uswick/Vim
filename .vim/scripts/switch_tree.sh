#!/bin/bash

switch_tree()
{
  ESX_LINK_PATH="/opt/install/testesx"
  STR=$PWD
  SUB='/bora'
  if [[ "$STR" == *"$SUB"*  ]]; then
	echo "It's there. $PWD"
	match="${STR%\/bora\/*}"
	tree_path="$match"
	tree_base=`readlink -f "$match/.."`
	export VMPROD=ws
	export VMBLD=obj
	#rm $ESX_LINK_PATH; ln -sf ${tree_base} $ESX_LINK_PATH
	#export VMTREE="$ESX_LINK_PATH/bora"
	if [[ "$match" != *"/bora"*   ]]; then
	  # inside some descendent folder
	  export VMTREE="${tree_path}/bora"
	else
	  export VMTREE="$tree_path"
	fi


	if [ -f "$VMTREE/esxconf.sc"  ]; then
		echo "esxconf.sc exist"
	else
		ln -sf /mts/home1/wickramasinu/esxconf.sc $tree_path/esxconf.sc
		echo "Linking esxconf.sc"
	fi
	if [ -f "$VMTREE/Local.sc"  ]; then
		echo "Local.sc exist"
	else
		ln -sf /mts/home1/wickramasinu/Local.sc $tree_path/Local.sc
		echo "Linking Local.sc"
	fi
	echo "Switched to updated tree: " $tree_path " done!"
	echo "VMTREE: " $VMTREE
	echo "VMPROD: " $VMPROD
	echo "VMBLD: " $VMBLD
  else
        echo "Unable to switch tree; $STR is not a bora path!"  
  fi
}

switch_tree
