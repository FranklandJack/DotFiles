# How to Partition Format and Mount an External Drive

* This guide walks you through partitioning, formatting and mounting
an external storage.
* It assumes that the physical hardware is already connected to your bus.
* This is a guide for linux users.

## Paritioning the Disk
1. Run the command `lsblk`. This command lists information about all available
block devices the system can see. In the output you should see something like:
```
name           8:0    0 931.5G  0 disk
```
where `name` will be a name the system is using to identify the device. You can
recognise the storage based on the known size (in this case 1TB).

2. Run the command `sudo fdisk -l`. This will list the partition table for all the
devices listed in `/proc/partitions`. The output will look something like:
```
Disk /dev/name: 931.5 GiB, 1000204886016 bytes, 1953525168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
```
Since there is no partition section in this output it means that the disk has not been
partitioned yet, if it is then skip to the section on creating the file system.

3. We can double check where the device is with `sudo lshw -C disk`. The output of
this command will look something like:
```
  *-disk
       description: ATA Disk
       product: ST1000DM010-2EP1
       vendor: Seagate
       physical id: 0.0.0
       bus info: scsi@0:0.0.0
       logical name: /dev/name
       version: CC43
       serial: Z9ASRPEC
       size: 931GiB (1TB)
       configuration: ansiversion=5 logicalsectorsize=512 sectorsize=4096
```
The important part here is the logical name `/dev/name` which is how linux handles the
drive as a file and how we will identify it.

By running `file /dev/name` and getting the output:
```
/dev/name: block special (8/0)
```
we see that `/dev/name` is a *block special* file, meaning its not really a file, but a
device appearing as a file (this is quite a common pattern in linux).

4. We can now format the disk with `sudo fdisk /dev/name`, this will launch an interactive
menu with a bunch of options. Press `n` to create a new partition. It'll ask you if you
want to make a primary or extended partition, this gets into some esoteric legacy stuff
whereby you can only have a certain number of primary partitions (hence the 1-4) so if
you get the to the point where you've already got 3 but want several more they'd need to
be extended. We're just going to make one big partition filling the drive so we pick
primary `p`. Once you've picked primary it'll ask you what number to create, assuming you
already only have one primary partition on your boot drive hit `1`. You will then be
promted for the first sector, with someting like
`First sector (2048-1953525167, default 2048)`, since we want to use the whole drive we
can just take the default and hit enter, we can then repeat this for the last sector as
well. Finally press `w` to write these changes to the disk and you should be returned to
the command line.

5. We can check that we have correctly formatted the drive with `file /dev/name` and the
output should look like:
```
/dev/name: block special (8/1)
```
`/dev/name` is the file representing the drive itself, `/dev/name1` is the file representing
the partition we just created. At this point we can move onto creating a file system on
the partition. We can also now see in the output of `sudo fdisk -l` that the drive is
formatted since the output contains a partition section for `/dev/name1`:
```
Disk /dev/sda: 931.5 GiB, 1000204886016 bytes, 1953525168 sectors
Units: sectors of 1 * 512 = 512 bytes                 
Sector size (logical/physical): 512 bytes / 4096 bytes    
I/O size (minimum/optimal): 4096 bytes / 4096 bytes  
Disklabel type: dos                                  
Disk identifier: 0xbdfc528e                      
                                                            
Device     Boot Start        End    Sectors   Size Id Type 
/dev/sda1        2048 1953525167 1953523120 931.5G 83 Linux
```

## Creating the Filesystem

1. Since we are on linux we can use the *ext4* filesystem. In order to do this we execute
the command `sudo mkfs -t ext4 /dev/name1`, the output should look something like:
```
mke2fs 1.44.1 (24-Mar-2018)
Creating filesystem with 244190390 4k blocks and 61054976 inodes
Filesystem UUID: 49d48377-717a-464c-a667-c6e4b28e8058
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
        102400000, 214990848

Allocating group tables: done
Writing inode tables: done
Creating journal (262144 blocks): done
Writing superblocks and filesystem accounting information: done
```
With that the filesystem has been correctly in the partition we created above.

## Mounting the Drive

In order to actually use the file system we need to mount it. We can either do this
manually, mounting and unmounting it each time we want to use it, or we can tell the OS
to do it each time it boots. The latter option is more convenient if you plan to make use
of the storage regularly, so lets go with that.

1. Create a directory in `/media` with a name you like e.g. `sudo mkdir /media/my_drive`
(it is convention to mount your drives in `/media` but you could actually put it anywhere.

2. Since we created the mount point as a super user we need to change the ownership,
otherwise when we mount the filesystem it'll be read only. To do this execute the command:
`sudo chown -R user:user /media/my_drive` where `user` is your user name.

3. Now to tell the OS to always mount the drive at this mount point execute 
`sudo edit /etc/fstab` and at the bottom add the line:
```
/dev/name  /media/my_drive  ext4  defaults  0  2
```
`/etc/fstab` is a file that tells the OS which drives to mount where at boot time.

4. Execute `sudo mount -a` which tells the mount command to run through the `fstab` file
and mount everything there.

5. You should now be able to `cd` into `/media/my_drive` and create files, test this with
`touch foo`. `df -h` should now also have an entry for your new drive, something like:
```
/dev/name1       916G   77M  870G   1% /media/my_drive
```
6. Finally to check that the OS is actually mounting the drive automatically at boot,
reboot your computer and check that the drive gets automatically mounted.



# Trouble Shooting
Note that if you are unable to create files with `touch foo` after stage 5. of
*Mounting the Drive* but `sudo touch foo` works
it is because you didn't change ownership of the mount point after you created the
directory. Unmount the directory with umount `/media/my_drive` and then repeat step 2.
and step 4.
