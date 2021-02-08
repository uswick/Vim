export PATH=/build/apps/bin:$PATH
export P4CONFIG=.p4config
export P4USER=wickramasinu
export HISTFILE=/tmp/$USER.bash_history

if type rg &> /dev/null; then
     export FZF_DEFAULT_COMMAND='rg --files'
     export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

cscope_tags(){
 find $PWD -name "*.[chxsS]" -print > cscope.files && cscope -R -i cscope.files -q -k
 #find $PWD -name "*.[chxsS]" -print > cscope.files && cscope -R -i cscope.files -b -q -k
}

patch_p4(){
 rm -f patched_out.tmp

 patch -p2 --merge --dry-run -i $@ > patched_out.tmp
 #patch -p2 -N --dry-run -i $@ > patched_out.tmp
 echo "patched output: "
 cat patched_out.tmp
 echo "------------------------------------------------"
 awk 'match($0, /File /) {print $2}' < patched_out.tmp | xargs ls -lart
  
 echo ""
 read -p 'Enter to continue p4 patch files: ' ent
 awk 'match($0, /File /) {print $2}' < patched_out.tmp | xargs p4 open

 patch -p2 --merge -i $@ > patched_out.tmp
 echo "patched (with p4 opened) output: "
 cat patched_out.tmp
}


patch_lic(){
   patch_p4 ~/lic.patch
}

p4_unsh_resolve(){
  read -p 'Enter CLN# to unshelve: ' cln
  p4 unshelve -s $cln && p4 sync && p4 resolve
}

p4_create_change(){
  p4cname=`p4 info | grep "Client name" | awk '{print $3}'`
  p4opened=`p4 opened`
  p4opened=""
  read -p 'Enter short description of the change: ' sdesc
  read -p 'Enter long description of the change: ' ldesc
  cat << EOF2 > ~/tmp.spec
Change:	new

Client:	$p4cname

User:	wickramasinu

Status:	new

Description:
	$sdesc

	$ldesc

	QA Notes: 
	Testing Done: <required>
	Documentation Notes: 
	Bug Number: 
	Reviewed by: <required>
	Approved by: 
	Mailto: 
	Review URL: 
	SVS Submit Restricted: Yes
	Post Submit Tests: 
Files:
	$p4opened
EOF2
  p4 change -i < ~/tmp.spec
}

#:walias vim='STTYOPTS="$(stty --save)" && stty stop \'\':w -ixoff && vim . && stty "$STTYOPTS"'
vim2()
{
    # osx users, use stty -g
    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
    stty "$STTYOPTS"
}


loadesx()
{
   loadESXEnable -e --ignore-platform
   local cmdEsxEnable=`find . -name loadESXEnable`
   local cmdLoadEsx=`find . -name loadESX.py`

   if [ -z $cmdLoadEsx ]; then
      echo "loadESX not found"
      return
   fi
   if [ -z $cmdEsxEnable ]; then
      echo "loadESXEnable not found"
      return
   fi

   read -p 'Enter boot.cfg path: ' TARGET
   $cmdEsxEnable -e --ignore-platform
   $cmdLoadEsx --no-sig-check --boot-cfg $TARGET
}

vmmon_reinstall()
{
  read -p 'Enter build type: ' bt
  #local VMMON_PATH=`find . -name vmmon.ko | grep "vmmon/vmmon.ko"`
  local VMMON_PATH=`find . -name vmmon.ko | grep $bt`
  if [ -z $VMMON_PATH ]; then
    echo "vmmon.ko not found for build type=$bt! available vmmon.ko:"
    find . -name vmmon.ko
    return
  fi

  VMMON_PATH=`readlink -f ${VMMON_PATH}`
  echo "vmmon path: $VMMON_PATH"
  ls -lart $VMMON_PATH
  sudo rmmod -f vmmon
  sudo insmod ${VMMON_PATH}
  lsmod | grep vmmon

  #create device files
  #if [ -c /dev/vmmon ]; then
    #sudo chmod 777 /dev/vmmon
    #echo "/dev/vmmon exist"
  #else
    #sudo mknod /dev/vmmon c 62 0
    #sudo chmod 777 /dev/vmmon
    #echo "creating /dev/vmmon"
  #fi
  #
  #if [ -c /dev/vmx86.$USER ]; then
    #sudo chmod 777 /dev/vmx86.$USER
    #echo "/dev/vmx86.$USER exist"
  #else
    #sudo mknod /dev/vmx86.$USER c 62 0
    #sudo chmod 777 /dev/vmx86.$USER
    #echo "creating /dev/vmx86.$USER"
  #fi
  echo "Done!"
}

p4_create_client(){
  read -p 'Enter a client name: ' uservar
  read -p 'Enter a general workspace description: ' desc

  echo $desc > README.txt

  dt=`date`
  hst=`hostname`
  dir=$PWD
  cat << EOF3 > ~/tmpclient.spec

Client:	$uservar

Update:	$dt

Access:	$dt

Owner:	wickramasinu

Host:	$hst

Description:
	Created by wickramasinu.

Root:	$dir

Options:	noallwrite noclobber nocompress unlocked nomodtime normdir

SubmitOptions:	submitunchanged

LineEnd:	local

View:
	//depot/bora/main/... //${uservar}/bora/...
	//depot/scons/main/... //${uservar}/scons/...
	//depot/vmkdrivers/main/... //${uservar}/vmkdrivers/...
EOF3

  #p4 client
  p4 client -i < ~/tmpclient.spec
  echo "P4CLIENT=${uservar}" > .p4config
}

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


switch_tree_esx()
{
  ESX_LINK_PATH="/opt/install/testesx"
  STR=$PWD
  SUB='/bora'
  if [[ "$STR" == *"$SUB"*  ]]; then
	echo "It's there. $PWD"
	match="${STR%\/bora\/*}"
	tree_path="$match"
	tree_base=`readlink -f "$match/.."`
	export VMPROD=esx
	export VMBLD=release
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

pxe_locs()
{
LOCS="Austin Colorado Colorado-Springs CreeksideC DFW2 HTA HTB HTE HTF PromA PromB PromB-lab PromC PromD PromE PromE-lab PromH RDC-MC SEA2 SF2 SJC31"

#LOCS="Austin BLR-CPDPDP BLR-KM BLR-OSDC BLR7 BLR9 BOS2 BOS3 Bangalore-PDP Beijing-PDP CLOUD-CPDPDP Cambridge China-Raycom Colorado Colorado-Springs CreeksideC DFW2 ETC-VCD-PDP-CAT GSS-Cork HTA HTB HTE HTF Herzilya London MUC PRMB-PDP-CAT PRME-PDP-CAT PromA PromB PromB-lab PromB-lab-pdp PromC PromD PromE PromE-lab PromH Pune RDC-MC SC2-PDP SC2-PDP2 SEA2 SF2 SJC31 SOF2-CPBU Shanghai-China Singapore Singapore-ONPREM Singapore-PDP Sofia Sofia-Colo WDC WDC-CPDPDP WDC-HS2-CPDPDP WDC-HS4-ONPREM WDC-PDP WDC-PDP-CAT WDC-PDP-CAT1 WDC-POC WDC-POD3 WDC-Perfsds WDC-ROCSPERF WDC-U WDC-VC1K WDC-VSAN WDC-VSAN-DP WDC-VXR WDC2-CPDPDP Yerevan sc-rdops sc-stage-rdops wdc-rdops"


for i in $LOCS; do echo "loc ->$i";./PXEconfig.pl -m d0:94:66:10:1d:78 -d dbc/sc-dbc1221 -p wickramasinu/pxe -l $i ; done

}
#export VMTREE=/dbc/sc-dbc1221/wickramasinu/test/bora
#export VMPROD=ws
#export VMBLD=obj

export PATH=~/.vim/scripts:$PATH
export PATH=~/bora-dash:$PATH
#export PATH=/dbc/sc-dbc1221/wickramasinu/cmake/cmake/bin:$PATH
#export PATH=/dbc/sc-dbc1221/wickramasinu/LLVM-clang/llvm-project/build/bin:$PATH
export P4CONFIG=.p4config
#export PATH=/dbc/sc-dbc1221/wickramasinu/gcc-5/gcc-5.4.0/install/bin:$PATH
export VMTREE=$PWD
export VMPROD=ws
export VMBLD=obj
export BORA_SRC_ROOT=/opt/install/repos01

alias vim="vim2"

alias ws_obj="scons BUILDTYPE=obj PRODUCT=ws vmx; make vmmon"
alias ws_rel="scons BUILDTYPE=release PRODUCT=ws vmx; make vmmon"
alias esx_vmk_obj="scons BUILDTYPE=obj PRODUCT=esx vmx ; scons BUILDTYPE=obj PRODUCT=esx vmkernel ; scons BUILDTYPE=obj PRODUCT=esx vmkmod-all"
alias esx_vmk_rel="scons BUILDTYPE=release PRODUCT=esx vmx; scons BUILDTYPE=release PRODUCT=esx vmkernel; scons BUILDTYPE=release PRODUCT=esx vmkmod-all"
alias esx_obj="scons BUILDTYPE=obj PRODUCT=esx visor-pxe"
alias esx_rel="scons BUILDTYPE=release PRODUCT=esx visor-pxe"


# pxe sc2-hs3-i1214
alias pxe0="ssh pxeuser@suite ./PXEconfig.pl -m e4-43-4b-93-0a-d0 -d dbc/sc-dbc1221 -p wickramasinu/pxe -l SJC31"
# pxe mon-bdw-ep04
alias pxe1="ssh pxeuser@suite ./PXEconfig.pl -m 18-66-da-65-a8-49 -d dbc/sc-dbc1221 -p wickramasinu/pxe -l PromA"
#raghu's skylake
alias pxe2="ssh pxeuser@suite ./PXEconfig.pl -m 18:66:da:4e:41:d9  -d dbc/sc-dbc1221 -p wickramasinu/pxe -l PromA"
alias pxe_amd1="ssh pxeuser@suite ./PXEconfig.pl -m d0:94:66:10:1d:78 -d dbc/sc-dbc1221 -p wickramasinu/pxe -l PromE-lab"

# ssh hosts
alias ssh_sc2hs3="ssh root@sc2-hs3-i1214"
alias ssh_dbc="ssh wickramasinu@sc-dbc1221.eng.vmware.com"

alias dash="dash.py"
alias dbcdash="BORA_SRC_ROOT=/dbc/sc-dbc1221/wickramasinu/repos02 /build/apps/contrib/bin/python-wrapper-2.7.13 ~/bora-dash/dash.py"

alias freemem="free -g; sync; sudo sh -c \"echo 1 > /proc/sys/vm/drop_caches\";free -g"

# add shortcut key binding C-f
bind '"\C-f":"fzf\n"'



review_gen(){
read -p 'Enter CLN# to generate review: ' cln

change=`p4 describe $cln | grep -ve "Documentation Notes:\|QA Notes:\|Reviewed by:\|Approved by:\|Mailto:\|Review URL:\|Post Submit Tests:\|SVS Submit Restricted:"`
info=`make-review -c $cln |  grep -i "^INFO\|^TkDiff\|^Meld\|^HTML"`

cat<<EOF>review.gen.tmp

-------------- Change Description -----------------
$change

-------------- Change Info ------------------------
$info
EOF

cat review.gen.tmp | awk '{$1=$1;print}'
rm -f review.gen.tmp
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
