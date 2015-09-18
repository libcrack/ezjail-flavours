FreeBSD ezjail flavours
=======================

Ezjail is a FreeBSD wrapper for managing jails in a convenient way. Linux people could identify it as a Docker-ish deployment technology for FreeBSD zero-overhead virtualization.

[ezjail main website](https://erdgeist.org/arts/software/ezjail/)


How ezjail flavours do work?
----------------------------

When creating a new jail using ezjail, a jail template can be specified. The jail template is composed by a set of files which will overwrite the instelled ones on the freshly created jail.

The main ezjail shell script is located at `/usr/local/bin/ezjail-admin`. By examining the shell stantences starting at line 780 the customisation of the jail installation process can be easily spotted:

```shell
 780
 781       # if the packages are links and not files we have to copy them now
 782       find "${ezjail_rootdir}/pkg/" -type l -exec cp -r -f {} {}.ezjail \; -exec mv {}.ezjail {} \;
 783
 784       # If an old style flavour config is found, make it auto run on jails startup
 785       if [ -f "${ezjail_rootdir}/ezjail.flavour" ]; then
 786         chmod 0755 "${ezjail_rootdir}/ezjail.flavour"
 787         mv "${ezjail_rootdir}/ezjail.flavour" "${ezjail_rootdir}/ezjail.flavour".`printf %04d ${installed_flavours}`
 788         [ $(( installed_flavours+=1 )) == 1 ] && echo "Note: Shell scripts for flavour ${ezjail_flavour} installed, flavourizing on jails first startup."
 789
 790       cat > "${ezjail_rootdir}/etc/rc.d/ezjail-config" <<"EOF"
 791 #!/bin/sh
 792 #
 793 # BEFORE: DAEMON
 794 # PROVIDE: ezjail-config
 795 #
 796 name=ezjail-config
 797 start_cmd=flavour_setup
 798
 799 flavour_setup() {
 800   # N.B.: Do NOT rm $0, it points to /etc/rc
 801   rm -f "/etc/rc.d/ezjail-config"
 802   for ezjail_flavour in /ezjail.flavour.*; do
 803     [ -x "${ezjail_flavour}" ] && "${ezjail_flavour}"
 804     rm -f "${ezjail_flavour}"
 805   done
 806 }
 807 run_rc_command "$1"
 808 EOF
 809       chmod 0755 "${ezjail_rootdir}/etc/rc.d/ezjail-config"
 810       fi
 811     done
 812   fi
 813
```

As can be seen on `/usr/local/bin/ezjail-admin:788`, the script checks for the existence of the directory `${ezjail_rootdir}/pkg` and the script file `ezjail.flavour` on the freshly created jail filesystem. If the directory `${ezjail_rootdir}/pkg` exists, all packages contained on it will be installed automatically; If the file `${ezjail_rootdir}/etc/rc.d/ezjail.flavour` is also present, it will be executed.

If the file `${ezjail_rootdir}/ezjail.flavour` exists, `ezjail-admin` understand that its a "old-style jail" and it will be also executed. The same applies to every script named with the form  `ezjail.flavour.*`. The execution of this scripts is carried out with a helper rc-script which is located on the jail's filesystem (`${ezjail_rootdir}/etc/rc.d/ezjail-config`). The helper rc-script (as well the rest of the `ezjail.flavour.*` scripts if present) will be deleted after the jail's first boot. Note that the original flavour script included at `${ezjail_rootdir}/etc/rc.d/ezjail.flavour` won't be deleted from the freshly installed jail.

So, in order to customise a jail using a specifig flavour the following requeriments must be met:

1. The default flavour *must* exist at `/usr/jails/flavour/default`. If it doesn't, ezjail-admin will create an example jail flavour.
2. The jail flavour must contain a customisation script located at the flavour's filesystem `${ezjail_rootdir}/etc/rc.d/ezjail.flavour`
3. Customisation code must be implemented on the shell function `flavour_setup` inside `${ezjail_rootdir}/etc/rc.d/ezjail.flavour`. This can be also customised by modifying the variable `start_cmd=flavour_setup` in the flavour script.


Creating a new ezjail flavour
-----------------------------

1. Copy the base default flavour
    ```
    cp -r /usr/jails/flavours/default /usr/jails/flavours/myflavour
    ```

2. Rename the ezjail post-installation script and variables
    ```
    mv /usr/jails/flavours/myflavour/etc/rc.d/ezjail.flavour.default \
        /usr/jails/flavours/myflavour/etc/rc.d/ezjail.flavour.myflavour
    sed -i '' -s 's/default/myflavour/g' \
        /usr/jails/flavours/myflavour/etc/rc.d/ezjail.flavour.myflavour
    ```

3. Implement the post-install inside the `flavour_setup` shell function
    ```
    vim /usr/jails/flavours/myflavour/etc/rc.d/ezjail.flavour.myflavour
    ```

4. Deploy a jail using the newly created flavour
    ```
    ezjail-admin create -f myflavour mynewjail 'lo1|172.16.1.10'
    ```

5. Start the jail (first boot, so be patiente)
    ```
    ezjail-admin start mynewjail
    ```

6. Connect to the flavoured jail
    ```
    ezjail-admin console mynewjail
    ```

